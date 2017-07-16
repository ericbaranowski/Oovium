//
//  Tail.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Tail: Aexel {
	var whileTokens: String = ""
	var resultTokens: String = ""

	var whileChain: Chain!
	var resultChain: Chain!

	var vertebras: [Vertebra] = []	
	
	var headTower: Tower
	var whileTower: Tower
	var resultTower: Tower

// Inits ===========================================================================================
	public required init(iden: Int) {
		headTower = Tower(name: "")
		whileTower = Tower(name: String(format: "ATS%05d", 0))
		resultTower = Tower(name: String(format: "ATN%05d", 0))
		super.init(iden:iden)
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		headTower = Tower(name: "")
		whileTower = Tower(name: String(format: "ATS%05d", iden))
		resultTower = Tower(name: String(format: "ATN%05d", iden))
		super.init(iden: iden, type: type, attributes: attributes)
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["whileTokens", "resultTokens"]
	}
	override func children() -> [String] {
		return super.children() + ["vertebras"]
	}
}
