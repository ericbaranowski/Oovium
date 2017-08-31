//
//  Tail.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Tail: Aexel {
	var whileChain: Chain!
	var resultChain: Chain!

	var vertebras: [Vertebra] = []	
	
	var headTower: Tower
	var whileTower: Tower
	var resultTower: Tower

// Inits ===========================================================================================
	public required init(iden: Int, at: V2, aether: Aether) {
		whileChain = Chain()
		resultChain = Chain()
		
		headTower = Tower(aether: aether, name: "Ta_\(iden)")
		whileTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "TaW_\(iden)"))
		resultTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "TaR_\(iden)"))

		super.init(iden:iden, at:at, aether: aether)
	}
//	public required init (iden: Int, type: String, attributes: [String:Any]) {
//		headTower = Tower(name: "")
//		whileTower = Tower(name: String(format: "ATS%05d", iden))
//		resultTower = Tower(name: String(format: "ATN%05d", iden))
//		super.init(iden: iden, type: type, attributes: attributes)
//	}
	public required init(attributes: [String:Any], parent: Domain) {
		let aether: Aether = parent as! Aether
		let iden: Int = attributes["iden"] as! Int
		
		headTower = Tower(aether: aether, name: "Ta_\(iden)")
		whileTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "TaW_\(iden)"))
		resultTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "TaR_\(iden)"))
		
		super.init(attributes: attributes, parent: parent)
	}
	
// Aexel ===========================================================================================
	override var freeVars: [String] {
		return []
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["whileChain", "resultChain"]
	}
	override func children() -> [String] {
		return super.children() + ["vertebras"]
	}
}
