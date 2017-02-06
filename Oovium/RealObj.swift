//
//  RealObj.swift
//  Oovium
//
//  Created by Joe Charlier on 10/2/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public struct RealObj: ObjS {
	public var x: Double
	
	public init (_ x: Double) {
		self.x = x
	}
	
//	public mutating func mimic (_ obj: Obj) {
//		x = (obj as! RealObj).x;
//	}
//	public func mimic (int: Int) {
//		x = Double(int)
//	}
	
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
	
// Obj =============================================================================================
	public var def: Def {
		get {return RealDef.def}
	}
	public var description: String {
		get {return ""}
	}
	
// Static ==========================================================================================
	public static let zero = RealObj(0)
}
