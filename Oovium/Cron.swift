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

public final class Cron: Aexel {
	var startTokens: String = ""
	var stopTokens: String = ""
	var stepsTokens: String = ""
	var rateTokens: String = ""
	var deltaTokens: String = ""
	var whileTokens: String = ""
	var endMode: OOEndMode = .stop
	var exposed: Bool = true
	
	var startChain: Chain!
	var stopChain: Chain!
	var stepsChain: Chain!
	var rateChain: Chain!
	var deltaChain: Chain!
	var whileChain: Chain!
	
	var startTower: Tower
	var stopTower: Tower
	var stepsTower: Tower
	var rateTower: Tower
	var deltaTower: Tower
	var whileTower: Tower

// Inits ===========================================================================================
	public required init() {
		startTower = Tower(name: String(format: "I%05d", 0))
		stopTower = Tower(name: String(format: "I%05d", 0))
		stepsTower = Tower(name: String(format: "I%05d", 0))
		rateTower = Tower(name: String(format: "I%05d", 0))
		deltaTower = Tower(name: String(format: "I%05d", 0))
		whileTower = Tower(name: String(format: "I%05d", 0))
		super.init()
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		startTower = Tower(name: String(format: "I%05d", iden))
		stopTower = Tower(name: String(format: "I%05d", iden))
		stepsTower = Tower(name: String(format: "I%05d", iden))
		rateTower = Tower(name: String(format: "I%05d", iden))
		deltaTower = Tower(name: String(format: "I%05d", iden))
		whileTower = Tower(name: String(format: "I%05d", iden))
		super.init(iden: iden, type: type, attributes: attributes)
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["startTokens", "stopTokens", "stepsTokens", "rateTokens", "deltaTokens", "whileTokens", "endMode", "exposed"]
	}
}
