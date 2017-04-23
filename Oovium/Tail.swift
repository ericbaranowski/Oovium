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

	var whileChain = Chain()
	var resultChain = Chain()

	var vertebras: [Vertebra] = []	
	
	var headTower = Tower()
	var whileTower = Tower()
	var resultTower = Tower()

// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["whileTokens", "resultTokens"]
	}
	override func children() -> [String] {
		return super.children() + ["vertebras"]
	}
}
