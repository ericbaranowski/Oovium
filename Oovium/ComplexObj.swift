//
//  ComplexObj.swift
//  Oovium
//
//  Created by Joe Charlier on 11/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class ComplexObj: ObjS {
	public var r: Double
	public var i: Double

	public init (_ r: Double, _ i: Double) {
		self.r = r
		self.i = i
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
	
// Obj =============================================================================================
	public var def: Def {
		get {return ComplexDef.def}
	}
	public var description: String {
		get {return ""}
	}
	func mimic (_ obj: ObjS) {}
}
