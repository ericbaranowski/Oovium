//
//  Object.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Object: Aexel {
	var chain: Chain = Chain(string: "")
	
	var tower: Tower
	var token: Token
	
// Inits ===========================================================================================
	public required init(iden: Int) {
		tower = Tower(name: String(format: "I%05d", 0))
		token = Token.token(type: .variable, tag: tower.name)
//		token.tower = tower
		super.init(iden:iden)
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		tower = Tower(name: String(format: "I%05d", iden))
		token = Token.token(type: .variable, tag: tower.name)
		super.init(iden: iden, type: type, attributes: attributes)
	}
	
// Actions =========================================================================================
	func ok() {
//		let memory = aether.memory
		chain.ok()
	}
	
// Aexel ===========================================================================================
	override func plugIn() {
		tower.name = String(format: "I%05d", iden)
		tower.token = Token.token(type: .variable, tag: tower.name)
		Tower.register(tower)
	}
	override func wire (_ memory: UnsafeMutablePointer<Memory>) {
		chain.tower = tower
		tower.wire(chain:chain, memory:memory)
	}
	override var towers: [Tower] {
		return [tower]
	}
	
	override func generateTokens() {
		
	}
	override func wireTowers() {
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["chain"]
	}
}
