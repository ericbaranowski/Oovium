//
//  Obj.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

open class Obj {
	var def: Def
	var dims: [Dim]
	
	public init (def: Def) {
		self.def = def
		self.dims = [Dim]()
	}
	init (def: Def, dims: [Dim]) {
		self.def = def
		self.dims = dims
	}
	
	public func mimic (_ obj: Obj) {
		self.def = obj.def
		self.dims = obj.dims
	}
	
	// Legacy
//	public func dim (i: Int) -> Dim {
//		return dims[i]
//	}
//	public func setDim (i: Int, as dim: Dim) {
//		dims[i] = dim
//	}
	public func v (i: Int) -> Double {
		return dims[i].asDouble()
	}
	public func typeOo () -> Def {
		return RealDef()
	}
	public var value: Double {
		get {
			let dim: RealDim = dims[0] as! RealDim;
			return dim.asDouble()
		}
	}
	public var asDouble: Double {
		get {
			let dim: RealDim = dims[0] as! RealDim;
			return dim.asDouble()
		}
	}
	public var asInt: Int {
		get {
			let dim: RealDim = dims[0] as! RealDim;
			return dim.asInt()
		}
	}
	open var description : String {
		return def.format(self)
	}
}
