//
//  Gate.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Gate: Aexel {
	var ifTokens: String = ""
	var thenTokens: String = ""
	var elseTokens: String = ""

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["ifTokens", "thenTokens", "elseTokens"]
	}
}
