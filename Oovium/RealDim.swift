//
//  RealDim.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class RealDim: Dim {
	public var x: Double
	
	public init (_ x: Double) {
		self.x = x;
	}
	
	// Dim ===========================================================================================
	override public func asDouble () -> Double {
		return x
	}
	override public func asString () -> String {
		return "\(x)"
	}
	
// Static ==========================================================================================
	static public func dim (_ x: Double) -> (RealDim) {
		return RealDim(x)
	}
}
