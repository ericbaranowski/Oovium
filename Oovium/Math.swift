//
//  Math.swift
//  Oovium
//
//  Created by Joe Charlier on 11/29/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public enum Morph: Int {
	case add, sub, mul, div, mod, pow, equal, notEqual, lessThan, lessThanOrEqual, greaterThan, greaterThanOrEqual
	case not, and, or, neg, abs, round, floor, sqrt, fac, exp, ln, log, ten, two, log2, sin, cos, tan, asin, acos, atan
	case sec, csc, cot, sinh, cosh, tanh, asinh, acosh, atanh, `if`, min, max, sum, random, variable, constant
}

public final class Math {
	static var morphs = [String:Morph]()
	
	static func registerMorph (key: String, morph:Morph) {
		morphs[key] = morph
	}
	static func registerOperator (token: Token, defs: [Def], morph: Morph) {
		var key = "\(token.tag);"
		for def in defs {
			key += "\(def.key);"
		}
		registerMorph(key: key, morph: morph)
	}
	static func morph (key: String) -> Morph {
		let morph = morphs[key]
		guard morph != nil else {
			print("key [\(key)] not found!")
			return .add
		}
		return morph!
	}
		
	public static func start() {
		registerOperator(token: Token.add,		defs: [RealDef.def, RealDef.def], morph: .add)
		registerOperator(token: Token.subtract,	defs: [RealDef.def, RealDef.def], morph: .sub)
		registerOperator(token: Token.multiply,	defs: [RealDef.def, RealDef.def], morph: .mul)
		registerOperator(token: Token.divide,	defs: [RealDef.def, RealDef.def], morph: .div)
		registerOperator(token: Token.power,	defs: [RealDef.def, RealDef.def], morph: .pow)
		registerOperator(token: Token.equal,	defs: [RealDef.def, RealDef.def], morph: .equal)

		registerMorph(key:"var;num;", morph:.variable)
		registerMorph(key:"constant;", morph:.constant)
	}
	
}
