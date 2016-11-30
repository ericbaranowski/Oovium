//
//  ComplexObj.swift
//  Oovium
//
//  Created by Joe Charlier on 11/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class ComplexObj: Obj {
	var r: Double {
		get {return (self.dims[0] as! RealDim).x}
	}
	var i: Double {
		get {return (self.dims[1] as! RealDim).x}
	}

	public init (_ r: Double, _ i: Double) {
		super.init(def: ComplexDef.def, dims: [RealDim(r), RealDim(i)])
	}
	convenience public init (_ r: Double) {
		self.init(r,0)
	}
	
	static func + (a: ComplexObj, b: ComplexObj) -> Obj {
		return ComplexObj(a.r+b.r,a.i+b.i)
	}
}
