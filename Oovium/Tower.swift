//
//  Tower.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public enum TowerState {
	case open, calced, uncalced, invalid
}
enum CalcState {
	case notReady, progress, cached
}

protocol MemorySource {
	var memory: UnsafeMutablePointer<Memory> {get}
}

public final class Tower: Hashable, CustomStringConvertible {
	let aether: Aether
	let name: String
	let token: Token?

	var index: UInt8 = 0
	var task: UnsafeMutablePointer<Task>?

	var upstream: Set<Tower> = Set<Tower>()
	var downstream: Set<Tower> = Set<Tower>()
	
	var _web: Web? = nil
	var web: Web? {
		set {_web = newValue}
		get {
			if let web = _web {return web}
			for tower in upstream {
				if let web = tower.web {return web}
			}
			return nil
		}
	}
	
	var source: MemorySource {
		if let web = web {return web}
		return aether
	}

	var state: TowerState = .open

	public var gateTo: Tower?
	public var thenTo: Tower?
	public var elseTo: Tower?
	public var gate: Tower?


	init(aether: Aether, token: Token) {
		self.aether = aether
		self.name = token.tag
		self.token = token
	}
	init(aether: Aether, name: String) {
		self.aether = aether
		self.name = name
		self.token = nil
	}
	
//	init(name: String) {
//		self.name = name
//	}
//	public init (task: UnsafeMutablePointer<Task>?) {
//		name = "[\(arc4random_uniform(99999999))]"
//		self.task = task
//	}
	
	func signal () {
	}
	
	public func attach (_ tower: Tower) {
		downstream.insert(tower)
		tower.upstream.insert(self)
	}
	func detach (_ tower: Tower) {
		downstream.remove(tower)
		tower.upstream.remove(self)
	}
	func clear() {
		upstream.removeAll()
		downstream.removeAll()
	}
	
	func wire (chain: Chain, memory: UnsafeMutablePointer<Memory>) {
		guard let token = token else {return}
		
		var lambda: UnsafeMutablePointer<Lambda>
		
		lambda = chain.compile(name: name, memory: memory)
//		let lambdaTask = LambdaTask(label: token.tag, command: "\(token.tag) = \(chain.display)", lambda: lambdaC)
		let lambdaTask = AETaskCreateLambda(lambda)
		lambdaTask?.pointee.label = token.tag.toInt8()
		lambdaTask?.pointee.command = "\(token.tag) = \(chain.display)".toInt8()
		
//		lambdaTask.load(/*label: token.tag, command: "\(token.tag) = \(chain.display)", */)
		
		task = lambdaTask

		index = AEMemoryIndexForName(memory, token.tag.toInt8())
//		lambda.vi = index
		lambda.pointee.vi = UInt8(index)
		for token in chain.tokens {
			let tower = Tower.tower(token: token)
			if let tower = tower {
				tower.attach(self)
			}
		}
	}
	
	func towersDestined (for target: Tower) -> Set<Tower> {
		if self == target {return [self]}
		
		var result = Set<Tower>()
		for tower in downstream {
			result.formUnion(tower.towersDestined(for: target))
		}
		if result.count > 0 && self.task != nil {
			result.insert(self)
		}
		return result
	}
//	private func possiblePaths (for target: Tower) -> Satyr<Tower> {
//		if self == target {
//			var satyr = Satyr<Tower>()
//			satyr.array.append([self])
//		}
//		
//		var satyr = Satyr<Tower>()
//		if task != nil {
//			satyr.array.append([self])
//		} else {
//			satyr.array.append([])
//		}
//		
//		if gateTo == nil {
//			for tower in downstream {
//				satyr.incorporate(tower.possiblePaths(for: target))
//			}
//		} else {
//			for tower in downstream {
//				let downSatyr = tower.possiblePaths(for: target)
//				for set in downSatyr.array {
//					satyr.array.append(set)
//				}
//			}
//		}
//		
//		return satyr
//	}
	func stronglyLinked (to target: Tower, override: Tower?) -> Bool {
		if self == target || self == override {return true}
		if gate != nil {return false}
		if let gateTo = self.gateTo {
			return gateTo.stronglyLinked(to: target, override: override)
		} else {
			for tower in downstream {
				if tower.stronglyLinked(to: target, override: override) {
					return true
				}
			}
			return false
		}
	}
	func towersStronglylinked (for target: Tower, override: Tower?) -> Set<Tower> {
		let towers = towersDestined(for: target)
		var result = Set<Tower>()
		for tower in towers {
			if tower.stronglyLinked(to: target, override: override) {
				result.insert(tower)
			}
		}
		return result
	}
	func towersStronglylinked (for target: Tower) -> Set<Tower> {
		let result = towersStronglylinked(for: target, override: nil)
		
		let satyr = Satyr<Tower>()
		satyr.array.append(result)
		
		for tower in result {
			if tower.gateTo != nil {
				let gateSatyr = Satyr<Tower>()
				for branch in tower.downstream {
					if tower.gateTo == branch {continue}
					gateSatyr.array.append(towersStronglylinked(for: target, override: branch))
				}
				satyr.incorporate(gateSatyr)
			}
		}
		
		return satyr.intersection()
	}

// Evaluate ========================================================================================
	private func isCalced(_ spider: Spider) -> Bool {
		return spider.memory.pointee.slots[Int(index)].loaded != UInt8(0)
	}
	func ping (_ spider: inout Spider) -> Bool {
		if isCalced(spider) {return false}
		
		if let gate = gate {
			if !gate.isCalced(spider) || !spider.needed.contains(gate) {return false}
		}
		
//		var needed: Bool = false
//		for tower in downstream {
//			if spider.needed.contains(tower) {
//				needed = true
//				break
//			}
//		}
//		if !needed {return false}
		
		for tower in upstream {
			if tower.task == nil {continue}
			if !tower.isCalced(spider) {return false}
		}
		
		spider.memory.pointee.slots[Int(index)].loaded = 1
		return true
	}
	
	func calculate (_ memory: UnsafeMutablePointer<Memory>) -> CalcState {
		// temporary guard
		guard task != nil else {return .cached}
		// temporary guard
		
		if state != .open {return .cached}
		
		for tower in upstream {
			if tower.state == .open {
				return .notReady
			} else if tower.state == .uncalced {
				state = .uncalced
				return .progress
			}
		}

		_ = AETaskExecute(task, memory)
		state = .calced
		AEMemoryFix(memory, index)
		
		return .progress
	}
	
	public static func printTowers (_ towers: Set<Tower>) {
		var sb = String()
		sb.append("[ Towers =================================== ]\n")
		for tower in towers {
			print("\(tower)")
		}
//		for tower in towers  {
//			if let taskS = tower.taskS {
//				sb.append("  \(taskS.label) : \(taskS.command)\n")
//			}
//		}
		sb.append("[ ========================================== ]\n\n")
		print("\(sb)")
	}

// Hashable ========================================================================================
	public static func == (left: Tower, right: Tower) -> Bool {
		return left === right
	}
	public var hashValue: Int {
		return name.hashValue
	}

	
// CustomStringConvertible ====================================================================
	private var display: String {
		return "\(name)"
	}
	public var description: String {
		var sb: String = ""

		sb.append("Tower [\(display) : \(state)\n")
		sb.append("\tupstream:\n")
		for tower in upstream
			{sb.append("\t\t\(tower.display)\n")}
		sb.append("\tdownstream:\n")
		for tower in downstream
			{sb.append("\t\t\(tower.display)\n")}

		return sb;
	}
	
// Static ==========================================================================================
	static var lookup = [Token:Tower]()
	static func link (token: Token, tower: Tower) {
		Tower.lookup[token] = tower
	}
	static func register (_ tower: Tower) {
		Tower.lookup[tower.token!] = tower
	}
	static func tower (token: Token) -> Tower? {
		return Tower.lookup[token]
	}
}
