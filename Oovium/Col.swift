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
	public required init() {
		tower = Tower(name: String(format: "I%05d", 0))
		super.init(iden: 0)
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		tower = Tower(name: String(format: "I%05d", iden))
		super.init(iden: iden, type: type, attributes: attributes)
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["name", "def", "chain", "aggregate", "justify", "format"]
	}
}
