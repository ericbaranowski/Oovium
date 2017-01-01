//
//  Tail.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Tail: Aexel {
	var whileTokens: String = ""
	var resultTokens: String = ""
	
	var vertebras: [Vertebra] = []

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["whileTokens", "resultTokens"]
	}
	override func children () -> [String] {
		return super.children() + ["vertebras"]
	}
}
