//
//  Object.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Object: Aexel {
	var tokens: String = ""
	
	var chain: Chain = Chain(string: "")
	
	var tower: Tower
	
// Inits ===========================================================================================
	public required init() {
		tower = Tower(name: String(format: "I%05d", 0))
		super.init()
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		tower = Tower(name: String(format: "I%05d", iden))
		super.init(iden: iden, type: type, attributes: attributes)
	}
	
// Actions =========================================================================================
	func ok() {
	}
	
// Aexel ===========================================================================================
	override func plugIn() {
		tower.name = String(format: "I%05d", iden)
		tower.token = Token.token(type: .variable, tag: Tag.tag(key: tower.name))
		aether.link(tower)
	}
	override func wire (_ memory: UnsafeMutablePointer<Memory>) {
		chain = Chain(tokens: tokens, tower: tower)
		tower.wire(chain:chain, memory:memory)
	}
	override func towers() -> [Tower] {
		return [tower]
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["tokens"]
	}
}
