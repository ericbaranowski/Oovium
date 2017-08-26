//
//  Mech.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Mech: Aexel {
	var resultChain: Chain
	
	var headTower: Tower
	let resultTower: Tower

// Inits ===========================================================================================
	public required init(iden: Int, at: V2) {
		headTower = Tower(name: "")
		resultTower = Tower(name: "Mc_\(iden)")
		
		resultChain = Chain(tower: resultTower)
		
		super.init(iden:iden, at:at)
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		headTower = Tower(name: "")
		resultTower = Tower(name: "Mc_\(iden)")
		
		resultChain = Chain(tower: resultTower)

		super.init(iden: iden, type: type, attributes: attributes)
	}
	
// Events ==========================================================================================
	override func onLoaded() {
		resultTower.aether = parent as! Aether
	}
	
// Aexel ===========================================================================================
	override var freeVars: [String] {
		return []
	}
	override func wire (_ memory: UnsafeMutablePointer<Memory>) {
		resultChain.tower = resultTower
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["resultChain"]
	}
}
