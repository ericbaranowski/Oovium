//
//  ComplexObj.swift
//  Oovium
//
//  Created by Joe Charlier on 11/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class ComplexObj: Obj {
	var r: Double
	var i: Double

	public init (_ r: Double, _ i: Double) {
		self.r = r
		self.i = i
		super.init(def: ComplexDef.def)
	}
	convenience public init (_ r: Double) {
		self.init(r,0)
	}
	
	static func + (a: ComplexObj, b: ComplexObj) -> ComplexObj {
		return ComplexObj(a.r+b.r, a.i+b.i)
	}
	static func - (a: ComplexObj, b: ComplexObj) -> ComplexObj {
		return ComplexObj(a.r-b.r, a.i-b.i)
	}
	static func * (a: ComplexObj, b: ComplexObj) -> ComplexObj {
		return ComplexObj(a.r*b.r-a.i*b.i, a.r*b.i+a.i*b.r)
	}
	static func / (a: ComplexObj, b: ComplexObj) -> ComplexObj {
		let x = b.r*b.r + b.i*b.i
		return ComplexObj((a.r*b.r+a.i*b.i)/x , (a.i*b.r-a.r*b.i)/x)
	}

	static func == (a: ComplexObj, b: ComplexObj) -> RealObj {
		return RealObj(a.r==b.r && a.i==b.i ? 1 : 0)
	}
}
