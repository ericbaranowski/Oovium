//
//  Col.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

enum OOAggregate {
	case none, sum, average, running, count, match
}
enum OOJustify {
	case left, center, right
}

public final class Col: Domain {
	var name: String = ""
	var def: Def = RealDef.def
	var chain: Chain!
	var aggregate: OOAggregate = .none
	var justify: OOJustify = .right
	var format: String = ""
	
	
	var tower: Tower

// Inits ===========================================================================================
	public init(grid: Grid) {
		let iden: Int = 0
		tower = Tower(aether: grid.aether, token: Token.token(type: .variable, tag: "Co_\(iden)"))

		super.init(iden: iden)
	}
	public required init(attributes: [String:Any], parent: Domain) {
		let aether: Aether = parent as! Aether
		let iden: Int = attributes["iden"] as! Int
		
		tower = Tower(aether: aether, token: Token.token(type: .variable, tag: "Co_\(iden)"))
		
		super.init(attributes: attributes, parent: parent)
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["name", "def", "chain", "aggregate", "justify", "format"]
	}
}
