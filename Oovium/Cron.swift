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

class Cron: Domain {
	var name: String = ""
	var startTokens: String = ""
	var stopTokens: String = ""
	var stepsTokens: String = ""
	var rateTokens: String = ""
	var deltaTokens: String = ""
	var whileTokens: String = ""
	var endMode: OOEndMode = .stop
	var exposed: Bool = true
	var x: Double = 0
	var y: Double = 0
}
