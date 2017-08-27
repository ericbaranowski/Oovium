//
//  Vertebra.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

final class Vertebra: Domain {
	var name: String = ""
	var def: Def = RealDef.def
	var chain: Chain!
		
	var tower: Tower

// Inits ===========================================================================================
	public init(tail: Tail) {
		let iden: Int = 0
		tower = Tower(aether: tail.aether, token: Token.token(type: .variable, tag: "Ve_\(iden)"))

		super.init(iden: iden)
	}
	public required init(attributes: [String:Any], parent: Domain) {
		let aether: Aether = (parent as! Tail).parent as! Aether
		let iden: Int = attributes["iden"] as! Int
		
		tower = Tower(aether: aether, token: Token.token(type: .variable, tag: "Ve_\(iden)"))
		
		super.init(attributes: attributes, parent: parent)
	}

// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["name", "def", "chain"]
	}
}
