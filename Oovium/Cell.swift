//
//  Cell.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Cell: Domain {
	var colID: Int = 0
	var rowNo: Int = 0
	var chain: Chain!

	var tower: Tower
	
// Inits ===========================================================================================
	public required init(grid: Grid) {
		let iden: Int = 0
		tower = Tower(aether: grid.aether, token: Token.token(type: .variable, tag: "Ce_\(iden)"))

		super.init(iden: iden)
	}
	public required init(attributes: [String:Any], parent: Domain) {
		let aether: Aether = parent as! Aether
		let iden: Int = attributes["iden"] as! Int
		
		tower = Tower(aether: aether, token: Token.token(type: .variable, tag: "Ce_\(iden)"))
		
		super.init(attributes: attributes, parent: parent)
	}

// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["colID", "rowNo", "chain"]
	}
}
