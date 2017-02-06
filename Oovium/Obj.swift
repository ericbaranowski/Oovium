//
//  Obj.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public protocol ObjS {
	var def: Def {get}
	var description: String {get}
//	mutating func mimic (_ obj: Obj)
}

//open class Obj {
//	open var def: Def {
//		get {return RealDef.def}
//	}
//	open var description: String {
//		get {return ""}
//	}
//	open func mimic (_ obj: Obj) {}
//}
