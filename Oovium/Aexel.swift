//
//  Aexel.swift
//  Oovium
//
//  Created by Joe Charlier on 12/31/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Aexel: Domain {
	var name: String = ""
	var x: Double = 0.0
	var y: Double = 0.0
	
	var aether: Aether {
		return parent as! Aether
	}
	
	func plugIn() {}
	func wire (_ memory: UnsafeMutablePointer<Memory>) {}
	
	var towers: [Tower] {
		return []
	}
	var tokens: [Token] {
		return []
	}
	
	func generateTokens() {}
	func wireTowers() {}
	
	var freeVars: [String] {
		return []
	}
	
// Inits ===========================================================================================
	public required init(iden: Int, at: V2, aether: Aether) {
		x = at.x
		y = at.y
		super.init(iden: iden)
	}
//	public required init (iden: Int, type: String, attributes: [String:Any]) {
//		super.init(iden: iden, type: type, attributes: attributes)
//	}
	public required init(attributes: [String:Any], parent: Domain) {
		super.init(attributes: attributes, parent: parent)
	}

// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["name", "x", "y"]
	}
}
