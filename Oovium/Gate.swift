//
//  Gate.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Gate: Aexel {
	var ifTokens: String = ""
	var thenTokens: String = ""
	var elseTokens: String = ""

	var ifTower = Tower()
	var thenTower = Tower()
	var elseTower = Tower()
	var resultTower = Tower()
	
// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["ifTokens", "thenTokens", "elseTokens"]
	}
}
