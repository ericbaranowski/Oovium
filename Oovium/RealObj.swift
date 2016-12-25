//
//  RealObj.swift
//  Oovium
//
//  Created by Joe Charlier on 10/2/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class RealObj: Obj {
	var x: Double {
		get {return (self.dims[0] as! RealDim).x}
	}
	
	public init (_ x: Double) {
		super.init(def: RealDef.def, dims: [RealDim(x)])
	}
	
//	public var value: Double {
//		get {
//			let dim: RealDim = dims[0] as! RealDim;
//			return dim.asDouble()
//		}
//	}
	override public func mimic (_ obj: Obj) {
		(self.dims[0] as! RealDim).x = (obj.dims[0] as! RealDim).x;
	}
	
	static func + (a: RealObj, b: RealObj) -> RealObj {
		return RealObj(a.x+b.x)
	}
	static func - (a: RealObj, b: RealObj) -> RealObj {
		return RealObj(a.x-b.x)
	}
	static func * (a: RealObj, b: RealObj) -> RealObj {
		return RealObj(a.x*b.x)
	}
	static func / (a: RealObj, b: RealObj) -> RealObj {
		return RealObj(a.x/b.x)
	}
	
	static func == (a: RealObj, b: RealObj) -> RealObj {
		return RealObj(a.x==b.x ? 1.0 : 0.0)
	}
}
