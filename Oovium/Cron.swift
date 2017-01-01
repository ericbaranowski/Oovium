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

public class Cron: Aexel {
	var startTokens: String = ""
	var stopTokens: String = ""
	var stepsTokens: String = ""
	var rateTokens: String = ""
	var deltaTokens: String = ""
	var whileTokens: String = ""
	var endMode: OOEndMode = .stop
	var exposed: Bool = true
	
	var startTower = Tower()
	var stopTower = Tower()
	var stepsTower = Tower()
	var rateTower = Tower()
	var deltaTower = Tower()
	var whileTower = Tower()

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["startTokens", "stopTokens", "stepsTokens", "rateTokens", "deltaTokens", "whileTokens", "endMode", "exposed"]
	}
}
