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

//	var objects: [Object] = []
//	var gates: [Gate] = []
//	var crons: [Cron] = []
//	var texts: [Text] = []
//	var mechs: [Mech] = []
//	var tails: [Tail] = []
//	public var autos: [Auto] = []
//	var types: [Type] = []
//	var grids: [Grid] = []
//	var mirus: [Miru] = []
	
	var towers: [Tower] = []
	var tokens: [String:Token] = [:]
	public var memory: UnsafeMutablePointer<Memory>
	
	var idens: IntMap = IntMap()
	
	public required override init() {
		memory = AEMemoryCreate(0);
		super.init()
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		memory = AEMemoryCreate(0);
		super.init(iden: iden, type: type, attributes: attributes)
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
					tower.aether = self
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
	func autoCreate() -> Auto {
		let auto = Auto(iden: idens.increment(key: "auto"))
		return auto
	}
	public func autoFirst() -> Auto? {
		for aexel in aexels {
			if let auto = aexel as? Auto {
				return auto
			}
		}
		return nil
	}
	
	func cronCreate() -> Cron {
		return Cron(iden: idens.increment(key: "cron"))
	}
	
	func gateCreate() -> Gate {
		return Gate(iden: idens.increment(key: "gate"))
	}
	
	func mechCreate() -> Mech {
		return Mech(iden: idens.increment(key: "mech"))
	}
	
	func miruCreate() -> Miru {
		return Miru(iden: idens.increment(key: "miru"))
	}
	
	func objectCreate() -> Object {
		return Object(iden: idens.increment(key: "object"))
	}
	
	func tailCreate() -> Tail {
		return Tail(iden: idens.increment(key: "tail"))
	}
	
	func textCreate() -> Text {
		return Text(iden: idens.increment(key: "text"))
	}
	
	func typeCreate() -> Type {
		return Type(iden: idens.increment(key: "type"))
	}
	
// Events ==========================================================================================
	override func onLoad() {
		print("onLoad")
		for aexel in aexels {
			if aexel.iden > idens.get(key: aexel.type) {
				idens.set(key: aexel.type, to: aexel.iden)
			}
		}
		print("\(idens)")
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["name", "xOffset", "yOffset", "readOnly"]
	}
	override func children() -> [String] {
		return super.children() + ["aexels"]
	}
}
