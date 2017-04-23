//
//  Aether.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

@objc public final class Aether: Anchor {
	var name: String = ""
	var xOffset: Double = 0
	var yOffset: Double = 0
	var readOnly: Bool = false
	
	public var objects: [Object] = []
	public var gates: [Gate] = []
	public var crons: [Cron] = []
	public var texts: [Text] = []
	public var mechs: [Mech] = []
	public var tails: [Tail] = []
	public var autos: [Auto] = []
	public var types: [Type] = []
	public var grids: [Grid] = []
	public var mirus: [Miru] = []
	
	var aexels: [Aexel] = []
	var tags: [String:Tag] = [:]
	var tokens: [String:Token] = [:]
	public var memoryS: MemoryS!
	public var memory: UnsafeMutablePointer<Memory>!
	
	public func link (_ tower: Tower) {
		Tower.link(token: tower.token, tower: tower)
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
		memoryS = MemoryS(vars.sorted())
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
		
//		var i = -1
//		for v in vars {
//			i += 1
//			
//			memory.pointee.slots[i].name = (0,0,0,0,0,0,0,0,0,0,0,0)
//			
//			let array: [UInt8] = Array(v.utf8)
//			
//			if v.length == 0 {continue}
//			memory.pointee.slots[i].name.0 = Int8(array[0])
//
//			if v.length == 1 {continue}
//			memory.pointee.slots[i].name.1 = Int8(array[1])
//
//			if v.length == 2 {continue}
//			memory.pointee.slots[i].name.2 = Int8(array[2])
//
//			if v.length == 3 {continue}
//			memory.pointee.slots[i].name.3 = Int8(array[3])
//
//			if v.length == 4 {continue}
//			memory.pointee.slots[i].name.4 = Int8(array[4])
//
//			if v.length == 5 {continue}
//			memory.pointee.slots[i].name.5 = Int8(array[5])
//
//			if v.length == 6 {continue}
//			memory.pointee.slots[i].name.6 = Int8(array[6])
//
//			if v.length == 7 {continue}
//			memory.pointee.slots[i].name.7 = Int8(array[7])
//
//			if v.length == 8 {continue}
//			memory.pointee.slots[i].name.8 = Int8(array[8])
//
//			if v.length == 9 {continue}
//			memory.pointee.slots[i].name.9 = Int8(array[9])
//
//			if v.length == 10 {continue}
//			memory.pointee.slots[i].name.10 = Int8(array[10])
//
//			if v.length == 11 {continue}
//			memory.pointee.slots[i].name.11 = Int8(array[11])
//		}
		
		for key in tokens.keys {
			let token = tokens[key]!
			let ip = memoryS.index(for: token.tag.key)
			token.ip = ip
		}

		for object in objects {object.wire(memory, memoryS: memoryS)}
		for gate in gates {gate.wire(memory, memoryS: memoryS)}
		for auto in autos {auto.wire(memory, memoryS: memoryS)}
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
