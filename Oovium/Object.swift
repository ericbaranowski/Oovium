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
	
	var chain = Chain()
	
	var tower = Tower()
	
// Actioms =========================================================================================
	func ok() {
	}
	
// Aexel ===========================================================================================
	override func plugIn() {
		tower.name = String(format: "I%05d", iden)
		tower.token = Token.token(type: .variable, tag: Tag.tag(key: tower.name))
		aether.link(tower)
	}
	override func wire (_ memory: UnsafeMutablePointer<Memory>, memoryS: MemoryS) {
		chain = Chain(tokens: tokens)
		tower.wire(chain:chain, memory:memory, memoryS: memoryS)
	}
	override func towers() -> [Tower] {
		return [tower]
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["tokens"]
	}
}
