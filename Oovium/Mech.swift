//
//  Mech.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Mech: Aexel {
	var resultTokens: String = ""
	
	var headTower = Tower()
	var resultTower = Tower()

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["resultTokens"]
	}
}
