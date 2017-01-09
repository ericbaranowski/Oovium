//
//  RealDim.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class RealDim: Dim {
	var x: Double
	
	init (_ x: Double) {
		self.x = x;
	}
	
	// Dim ===========================================================================================
	override func asDouble () -> Double {
		return x
	}
	override func asInt () -> Int {
		return Int(x)
	}
	override func asString () -> String {
		return "\(x)"
	}
	
// Static ==========================================================================================
	static func dim (_ x: Double) -> (RealDim) {
		return RealDim(x)
	}
}
