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
	
	var objects: [Object] = []
	var gates: [Gate] = []
	var crons: [Cron] = []
	var texts: [Text] = []
	var mechs: [Mech] = []
	var tails: [Tail] = []
	public var autos: [Auto] = []
	var types: [Type] = []
	var grids: [Grid] = []
	var mirus: [Miru] = []
	
	var aexels: [Aexel] = []
	var tags: [String:Tag] = [:]
	var tokens: [String:Token] = [:]
	public var memory: UnsafeMutablePointer<Memory>
	
	public required init() {
		memory = AEMemoryCreate(0);
		super.init()
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		memory = AEMemoryCreate(0);
		super.init(iden: iden, type: type, attributes: attributes)
	}
	
	public func wire() {
		for object in objects {object.plugIn()}
		for gate in gates {gate.plugIn()}
		for auto in autos {auto.plugIn()}
	
		let tokens = Token.tokens
		var vars = [String]()
		for key in tokens.keys {
			let token = tokens[key]!
			if token.type != .variable {continue}
			vars.append(token.tag.key)
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
				
		for key in tokens.keys {
			let token = tokens[key]!
			token.ip = Int(AEMemoryIndexForName(memory, token.tag.key.toInt8()))
		}

		for object in objects {object.wire(memory)}
		for gate in gates {gate.wire(memory)}
		for auto in autos {auto.wire(memory)}
	}
	
	public func calculate() {
		var towers = [Tower]()
		for object in objects {towers.append(contentsOf: object.towers())}
		for gate in gates {towers.append(contentsOf: gate.towers())}
		for auto in autos {towers.append(contentsOf: auto.towers())}
		
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
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["name", "xOffset", "yOffset", "readOnly"]
	}
	override func children() -> [String] {
		return super.children() + ["objects", "gates", "crons", "texts", "mechs", "tails", "autos", "types", "grids", "mirus"]
	}
}
