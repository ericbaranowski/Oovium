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
	
	func plugIn () {}
	func wire (_ memory: Memory) {}
	func towers () -> [Tower] {
		return []
	}

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["name", "x", "y"]
	}
}
