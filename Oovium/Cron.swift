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
	var startChain: Chain!
	var stopChain: Chain!
	var stepsChain: Chain!
	var rateChain: Chain!
	var deltaChain: Chain!
	var whileChain: Chain!
	var endMode: OOEndMode = .stop
	var exposed: Bool = true
	
	var startTower: Tower
	var stopTower: Tower
	var stepsTower: Tower
	var rateTower: Tower
	var deltaTower: Tower
	var whileTower: Tower

// Aexel ===========================================================================================
	override var freeVars: [String] {
		return []
	}
	
// Inits ===========================================================================================
	public required init(iden: Int, at: V2, aether: Aether) {
		
		startTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrSta_\(iden)"))
		stopTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrSto_\(iden)"))
		stepsTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrSte_\(iden)"))
		rateTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrR_\(iden)"))
		deltaTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrD_\(iden)"))
		whileTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrW_\(iden)"))

		super.init(iden: iden, at: at, aether: aether)
	}
//	public required init (iden: Int, type: String, attributes: [String:Any]) {
//		startTower = Tower(name: String(format: "I%05d", iden))
//		stopTower = Tower(name: String(format: "I%05d", iden))
//		stepsTower = Tower(name: String(format: "I%05d", iden))
//		rateTower = Tower(name: String(format: "I%05d", iden))
//		deltaTower = Tower(name: String(format: "I%05d", iden))
//		whileTower = Tower(name: String(format: "I%05d", iden))
//		super.init(iden: iden, type: type, attributes: attributes)
//	}
	public required init(attributes: [String:Any], parent: Domain) {
		let aether: Aether = parent as! Aether
		let iden: Int = attributes["iden"] as! Int
		
		startTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrSta_\(iden)"))
		stopTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrSto_\(iden)"))
		stepsTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrSte_\(iden)"))
		rateTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrR_\(iden)"))
		deltaTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrD_\(iden)"))
		whileTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "CrW_\(iden)"))
		
		super.init(attributes: attributes, parent: parent)
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["startChain", "stopChain", "stepsChain", "rateChain", "deltaChain", "whileChain", "endMode", "exposed"]
	}
}
