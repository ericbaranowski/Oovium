//
//  Auto.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Auto: Aexel {
	var statesTokens: String = ""
	var resultTokens: String = ""
	
	var statesChain = Chain()
	var resultChain = Chain()
	
	public var states: [State] = []
	
	var statesTower = Tower()
	public var headTower = Tower()
	public var resultTower = Tower()

	@objc public func token (name: String) {
	}
	
// Aexel ===========================================================================================
	override func plugIn () {
		Tower.link(token: Token.token(type: .variable, tag: Tag.tag(key: String(format: "Auto%d.A", iden))), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: Tag.tag(key: String(format: "Auto%d.B", iden))), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: Tag.tag(key: String(format: "Auto%d.C", iden))), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: Tag.tag(key: String(format: "Auto%d.D", iden))), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: Tag.tag(key: String(format: "Auto%d.E", iden))), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: Tag.tag(key: String(format: "Auto%d.F", iden))), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: Tag.tag(key: String(format: "Auto%d.G", iden))), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: Tag.tag(key: String(format: "Auto%d.H", iden))), tower: headTower)
		Tower.link(token: Token.token(type: .variable, tag: Tag.tag(key: String(format: "Auto%d.Self", iden))), tower: headTower)
		
		statesTower.name = String(format: "ATS%05d", iden)
		statesTower.token = Token.token(type: .variable, tag: Tag.tag(key: statesTower.name!))
		
		resultTower.name = String(format: "ATN%05d", iden)
		resultTower.token = Token.token(type: .variable, tag: Tag.tag(key: resultTower.name!))
		
		aether.link(statesTower)
		aether.link(resultTower)
	}
	override func wire (_ memory: Memory) {
		statesChain = Chain(string: statesTokens)
		resultChain = Chain(string: resultTokens)
		
		statesTower.wire(chain:statesChain, memory:memory)
		resultTower.wire(chain:resultChain, memory:memory)
	}
	
// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["statesTokens", "resultTokens"]
	}
	override func children () -> [String] {
		return super.children() + ["states"]
	}
}
