//
//  Tower.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

enum TowerState {
	case open, calced, uncalced, invalid
}
enum CalcState {
	case notReady, progress, cached
}

public class Tower: NSObject {
	public var name: String?
	public var index: Int = -1
	var task: Task?
	var token: Token!
	
	public var gateTo: Tower?
	var upstream: Set<Tower> = Set<Tower>()
	var downstream: Set<Tower> = Set<Tower>()

	var state: TowerState = .calced
	var stopper: NSObject?
	
	override init () {
	}
	public init (task: Task?) {
		self.task = task
	}
	
	private var _orbit: Tower?
	var orbit: Tower? {
		set {_orbit = newValue}
		get {
			if (stopper != nil) {return nil}
			if let orbit = orbitUp() {return orbit}
//			if let orbit = orbitDown() {return orbit}
			return nil
		}
	}
	
	private func orbitUp () -> Tower? {
		if let orbit = orbit {return orbit}
		for tower in upstream
			{if let orbit = tower.orbitUp() {return orbit}}
		return nil
		
	}
//	private func orbitDown () -> Tower? {
//		if let orbit = orbit {return orbit}
//		for tower in downstream
//			{if let orbit = tower.orbitDown() {return orbit}}
//		return nil
//	}
	
	public func attach (_ tower: Tower) {
		downstream.insert(tower)
		tower.upstream.insert(self)
	}
	func detach (_ tower: Tower) {
		downstream.remove(tower)
		tower.upstream.remove(self)
	}
	func clear () {
		upstream.removeAll()
		downstream.removeAll()
	}
	
	func wire (chain: Chain, memory: Memory) {
		
		var lambda: Lambda!
		
		do {
			lambda = try chain.compile()
		} catch {
			print("\(error)")
			return
		}
		
		lambda.compile(memory: memory)
		let lambdaTask = LambdaTask(label: token.tag.key, command: "\(token.tag.key) = \(chain.display)")
		lambdaTask.load(label: token.tag.key, command: "\(token.tag.key) = \(chain.display)", lambda: lambda)
		
		task = lambdaTask

		index = memory.index(for: token.tag.key)
		lambda.vi = index
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
		if let gateTo = self.gateTo {
			return gateTo.stronglyLinked(to: target, override: override)
		} else {
			for tower in upstream {
				if tower.gateTo != nil && tower.gateTo != self {
					return false
				}
			}
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
	func ping (_ memory: Memory) -> CalcState {
		if memory.isLoaded(index) {return .cached}
		
		for tower in upstream {
			if tower.task == nil {continue}
			if !memory.isLoaded(tower.index) {
				return .notReady
			}
		}
		
		memory.load(index, with: RealObj(0))
		
		return .progress
	}
//	func evaluate (vars: [String:Obj?]) -> CalcState {
//		if (state != .uncalced || vars[task.name] != nil)
//			{return .cached}
//		
//		for tower in upstream {
//			if (tower.state == .calced) {continue}
//			if (vars[tower.task.name] != nil) {continue}
//			return .notReady
//		}
//		return task.eval(vars) == .calced ? .progress : .cached
//	}
//	private func loadEval (_ towers: inout Set<Tower>) {
//		towers.insert(self)
//		for tower in downstream
//			{tower.loadEval(&towers)}
//	}
	func triggerEval (_ vars: [String:Obj?]) {
		
//		var progress: Bool
//		repeat {
//			for tower in 
//		} while (progress)
	}
	
	
	public static func printTowers (_ towers: Set<Tower>) {
		var sb = String()
		sb.append("[ Towers =================================== ]\n")
		for tower in towers  {
			if let task = tower.task {
				sb.append("  \(task.label) : \(task.command)\n")
			}
		}
		sb.append("[ ========================================== ]\n\n")
		print("\(sb)")
	}

// CustomDebugStringConvertible ====================================================================
	private var display: String {
		get {return ""}
	}
	override public var debugDescription: String {
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
	static func tower (token: Token) -> Tower? {
		return Tower.lookup[token]
	}
}
