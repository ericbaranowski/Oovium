//
//  RealObj.swift
//  Oovium
//
//  Created by Joe Charlier on 10/2/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class RealObj: Obj {
	var x: Double {
		get {return (self.dims[0] as! RealDim).x}
	}
	
	public init (_ x: Double) {
		super.init(dims: [RealDim(x)])
	}
	
	var value: Double {
		get {
			let dim: RealDim = dims[0] as! RealDim;
			return dim.asDouble()
		}
	}
	
	static func + (left: RealObj, right: RealObj) -> Obj {
		return RealObj(left.value+right.value)
	}
}
