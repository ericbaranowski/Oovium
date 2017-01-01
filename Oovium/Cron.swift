//
//  Cron.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

enum OOEndMode {
	case stop, `repeat`, bounce, endless, `while`
}

class Cron: Aexel {
	var startTokens: String = ""
	var stopTokens: String = ""
	var stepsTokens: String = ""
	var rateTokens: String = ""
	var deltaTokens: String = ""
	var whileTokens: String = ""
	var endMode: OOEndMode = .stop
	var exposed: Bool = true

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["startTokens", "stopTokens", "stepsTokens", "rateTokens", "deltaTokens", "whileTokens", "endMode", "exposed"]
	}
}
