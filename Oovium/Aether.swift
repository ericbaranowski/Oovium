//
//  Aether.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

@objc public final class Aether: Anchor, MemorySource {
	var name: String = ""
	var xOffset: Double = 0
	var yOffset: Double = 0
	var readOnly: Bool = false

	var aexels: [Aexel] = []

	var towers: [Tower] = []
	var tokens: [String:Token] = [:]
	public var memory: UnsafeMutablePointer<Memory>
	
	var idens: IntMap = IntMap()
	
	public init() {
		memory = AEMemoryCreate(1);
		super.init(iden: 0)
	}
	public required init (attributes: [String:Any]) {
		memory = AEMemoryCreate(1);
		super.init(attributes: attributes)
	}
	public required init(attributes: [String:Any], parent: Domain) {fatalError()}
	
	private func renderMemory() {
		var vars = [String]()
		for aexel in aexels {
			vars += aexel.freeVars
		}
		
		let oldMemory: UnsafeMutablePointer<Memory> = memory
		memory = AEMemoryCreate(vars.count)

		var i = 0
		for variable in vars {
			withUnsafeMutablePointer(to: &memory.pointee.slots[i].name) {
				$0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: memory.pointee.slots[i].name)) {
					_ = strlcpy($0, variable, MemoryLayout.size(ofValue: memory.pointee.slots[i].name))
				}
			}
			i += 1
		}
		
		AEMemoryLoad(memory, oldMemory)
		AEMemoryRelease(oldMemory)
	}
	
	public func wireQ() {
		// Generate Tokens
		for aexel in aexels {
			aexel.generateTokens()
		}
		
		// Wire Towers
		for aexel in aexels {
			aexel.wireTowers()
		}
		
		// Collect Towers
		for aexel in aexels {
			for tower in aexel.towers {
				if tower.web == nil {
					towers.append(tower)
//					tower.aether = self
				}
			}
			for token in aexel.tokens {
				tokens[token.key] = token
			}
		}
	}
	
	public func wire() {
		for aexel in aexels {aexel.plugIn()}
	
		let tokens = Token.tokens
		var vars = [String]()
		for key in tokens.keys {
			let token = tokens[key]!
			if token.type != .variable {continue}
			vars.append(token.tag)
		}
		vars.sort(by: {$0<$1})
		
		AEMemoryRelease(memory)
		memory = AEMemoryCreate(vars.count)
		
		var i = -1
		for v in vars {
			i += 1
			withUnsafeMutablePointer(to: &memory.pointee.slots[i].name) {
				$0.withMemoryRebound(to: Int8.self, capacity: MemoryLayout.size(ofValue: memory.pointee.slots[i].name)) {
					_ = strlcpy($0, v, MemoryLayout.size(ofValue: memory.pointee.slots[i].name))
				}
			}
		}
				
//		for key in tokens.keys {
//			let token = tokens[key]!
//			token.ip = Int(AEMemoryIndexForName(memory, token.tag.toInt8()))
//		}

		for aexel in aexels {aexel.wire(memory)}
	}
	
	public func calculate() {
		var towers = [Tower]()
		for aexel in aexels {towers.append(contentsOf: aexel.towers)}
		
		var progress: Bool
		repeat {
			progress = false
			
			for tower in towers {
				if tower.calculate(memory) == .progress {
					progress = true
				}
			}
			
		} while progress
	}
	
// Aexels ==========================================================================================
	private func addAexel(_ aexel: Aexel) {
		add(aexel)
		aexels.append(aexel)
		renderMemory()
	}
	func removeAexel(_ aexel: Aexel) {
		remove(aexel)
		if let i = aexels.index(of: aexel) {
			aexels.remove(at: i)
		}
		renderMemory()
	}
	
	// Object
	func createObject(at: V2) -> Object {
		let iden = idens.increment(key: "object")
		let object = Object(iden: iden, at: at, aether: self)
		addAexel(object)
		return object
	}
	
	// Gate
	func createGate(at: V2) -> Gate {
		let iden = idens.increment(key: "gate")
		let gate = Gate(iden: iden, at: at, aether: self)
		addAexel(gate)
		return gate
	}
	
	// Mech
	func createMech(at: V2) -> Mech {
		let iden = idens.increment(key: "mech")
		let mech = Mech(iden: iden, at: at, aether: self)
		addAexel(mech)
		return mech
	}
	
	// Tail
	func createTail(at: V2) -> Tail {
		let iden = idens.increment(key: "tail")
		let tail = Tail(iden: iden, at: at, aether: self)
		addAexel(tail)
		return tail
	}
	
	// Auto
	func createAuto(at: V2) -> Auto {
		let iden = idens.increment(key: "auto")
		let auto = Auto(iden: iden, at: at, aether: self)
		addAexel(auto)
		return auto
	}
	public func firstAuto() -> Auto? {
		for aexel in aexels {
			if let auto = aexel as? Auto {
				return auto
			}
		}
		return nil
	}
	
	// Grid
	func createGrid(at: V2) -> Grid {
		let iden = idens.increment(key: "grid")
		let grid = Grid(iden: iden, at: at, aether: self)
		addAexel(grid)
		return grid
	}
	
	// Type
	func createType(at: V2) -> Type {
		let iden = idens.increment(key: "type")
		let type = Type(iden: iden, at: at, aether: self)
		addAexel(type)
		return type
	}
	
	// Miru
	func createMiru(at: V2) -> Miru {
		let iden = idens.increment(key: "miru")
		let miru = Miru(iden: iden, at: at, aether: self)
		addAexel(miru)
		return miru
	}
	
	// Cron
	func createCron(at: V2) -> Cron {
		let iden = idens.increment(key: "cron")
		let cron = Cron(iden: iden, at: at, aether: self)
		addAexel(cron)
		return cron
	}
	
	// Text
	func createText(at: V2) -> Text {
		let iden = idens.increment(key: "text")
		let text = Text(iden: iden, at: at, aether: self)
		addAexel(text)
		return text
	}
	
	// Also
	func createAlso(at: V2) -> Also {
		let iden = idens.increment(key: "also")
		let also = Also(iden: iden, at: at, aether: self)
		addAexel(also)
		return also
	}
	

// Events ==========================================================================================
	override func onLoad() {
		for aexel in aexels {
			if aexel.iden > idens.get(key: aexel.type) {
				idens.set(key: aexel.type, to: aexel.iden)
			}
		}
		wire()
		calculate()
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["name", "xOffset", "yOffset", "readOnly"]
	}
	override func children() -> [String] {
		return super.children() + ["aexels"]
	}
}
