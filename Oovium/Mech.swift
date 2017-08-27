//
//  Mech.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Mech: Aexel {
	var resultChain: Chain!
	
	var headTower: Tower
	let resultTower: Tower

// Inits ===========================================================================================
	public required init(iden: Int, at: V2, aether: Aether) {
		headTower = Tower(aether: aether, name: "Me_\(iden)")
		resultTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "MeR_\(iden)"))
		
		super.init(iden:iden, at:at, aether: aether)
	}
//	public required init (iden: Int, type: String, attributes: [String:Any]) {
//		headTower = Tower(name: "")
//		resultTower = Tower(name: "Mc_\(iden)")
//		
//		resultChain = Chain()
//
//		super.init(iden: iden, type: type, attributes: attributes)
//	}
	public required init(attributes: [String:Any], parent: Domain) {
		let aether: Aether = parent as! Aether
		let iden: Int = attributes["iden"] as! Int
		
		headTower = Tower(aether: aether, name: "Me_\(iden)")
		resultTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "MeR_\(iden)"))
		
		super.init(attributes: attributes, parent: parent)
	}
	
// Aexel ===========================================================================================
	override var freeVars: [String] {
		return []
	}
	override func wire (_ memory: UnsafeMutablePointer<Memory>) {
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["resultChain"]
	}
}
