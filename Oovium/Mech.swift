//
//  Mech.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Mech: Aexel {
	var resultTokens: String = ""

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["resultTokens"]
	}
}
