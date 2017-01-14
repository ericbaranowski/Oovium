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
	
	public init (def: Def) {
		self.def = def
	}
	init (def: Def, dims: [Dim]) {
		self.def = def
	}
	
	public func mimic (_ obj: Obj) {
		self.def = obj.def
	}
	
	// Legacy
//	public func dim (i: Int) -> Dim {
//		return dims[i]
//	}
//	public func setDim (i: Int, as dim: Dim) {
//		dims[i] = dim
//	}
	public func typeOo () -> Def {
		return RealDef()
	}
	open var description : String {
		return def.format(self)
	}
}
