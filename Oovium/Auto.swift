//
//  Auto.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Auto: Aexel {
	var statesChain: Chain!
	var resultChain: Chain!

	
	public var states: [State] = []
	
	var statesTower: Tower
	public var headTower: Tower
	public var resultTower: Tower

// Inits ===========================================================================================
	public required init(iden: Int, at: V2) {
		statesTower = Tower(name: String(format: "ATS%05d", 0))
		headTower = Tower(name: "")
		resultTower = Tower(name: String(format: "ATN%05d", 0))
		super.init(iden:iden, at:at)
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		statesTower = Tower(name: String(format: "ATS%05d", iden))
		headTower = Tower(name: "")
		resultTower = Tower(name: String(format: "ATN%05d", iden))
		super.init(iden: iden, type: type, attributes: attributes)
	}
	
	@objc public func token (name: String) {
	}
	
	public func foreshadow (_ memory: UnsafeMutablePointer<Memory>) {
		memory.pointee.slots[Int(AEMemoryIndexForName(memory, String(format: "Auto%d.A", iden).toInt8()))].loaded = 1
		memory.pointee.slots[Int(AEMemoryIndexForName(memory, String(format: "Auto%d.B", iden).toInt8()))].loaded = 1
		memory.pointee.slots[Int(AEMemoryIndexForName(memory, String(format: "Auto%d.C", iden).toInt8()))].loaded = 1
		memory.pointee.slots[Int(AEMemoryIndexForName(memory, String(format: "Auto%d.D", iden).toInt8()))].loaded = 1
		memory.pointee.slots[Int(AEMemoryIndexForName(memory, String(format: "Auto%d.E", iden).toInt8()))].loaded = 1
		memory.pointee.slots[Int(AEMemoryIndexForName(memory, String(format: "Auto%d.F", iden).toInt8()))].loaded = 1
		memory.pointee.slots[Int(AEMemoryIndexForName(memory, String(format: "Auto%d.G", iden).toInt8()))].loaded = 1
		memory.pointee.slots[Int(AEMemoryIndexForName(memory, String(format: "Auto%d.H", iden).toInt8()))].loaded = 1
	}
	
// Aexel ===========================================================================================
	override var freeVars: [String] {
		return []
	}
	
	override func plugIn() {
		Tower.link(token: Token.token(type: .variable, tag: String(format: "Auto%d.A", iden)), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: String(format: "Auto%d.B", iden)), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: String(format: "Auto%d.C", iden)), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: String(format: "Auto%d.D", iden)), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: String(format: "Auto%d.E", iden)), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: String(format: "Auto%d.F", iden)), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: String(format: "Auto%d.G", iden)), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: String(format: "Auto%d.H", iden)), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: String(format: "Auto%d.Self", iden)), tower: headTower)
		
		statesTower.name = String(format: "ATS%05d", iden)
		statesTower.token = Token.token(type: .variable, tag: statesTower.name)
		
		resultTower.name = String(format: "ATN%05d", iden)
		resultTower.token = Token.token(type: .variable, tag: resultTower.name)
		
		Tower.register(statesTower)
		Tower.register(resultTower)
	}
	override func wire (_ memory: UnsafeMutablePointer<Memory>) {
		statesChain.tower = statesTower
		resultChain.tower = resultTower
		
		statesTower.wire(chain:statesChain, memory:memory)
		headTower.state = .uncalced
		resultTower.wire(chain:resultChain, memory:memory)
	}
	override var towers: [Tower] {
		return [statesTower, headTower, resultTower]
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["statesChain", "resultChain"]
	}
	override func children() -> [String] {
		return super.children() + ["states"]
	}
}
