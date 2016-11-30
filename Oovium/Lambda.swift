//
//  Pebble.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Lambda: NSObject {
	var morphs: [(Lambda)->()] = [(Lambda)->()]()
	var cons: [Obj] = [Obj]()
	var vars: [String] = [String]()
	var stack: [Obj?] = [Obj?]()
	var cp: Int = 0
	var vp: Int = 0
	var sp: Int = 0
	var vi: Int = 0
	
	public override init () {}
	init (morphs: [(Lambda)->()], cons: [Obj], vars: [String]) {
		self.morphs = morphs
		self.cons = cons
		self.vars = vars
		stack = [Obj?](repeating: nil, count: 10)
		cp = 0
		vp = 0
		sp = 0
		vi = 0
	}
	
	// Constants
	func nextCons () -> Obj {
		let obj = cons[cp]
		cp += 1
		return obj
	}
	
	// Variables
	func nextVar () -> Obj {
		return Obj(def: RealDef.def, dims: [])
	}
	
	// Stack
	func push (_ obj: Obj) {
		stack[sp] = obj;
		sp += 1
	}
	func pop () -> Obj {
		sp -= 1
		return stack[sp]!
	}
	func peek () -> Obj {
		return stack[sp-1]!
	}

	// Evaluate
	func evaluate (vars: [String:Obj?]) -> [Obj] {
		for morph in morphs
			{morph(self)}
		return [peek()]
	}
	public func doubleEvaluate (_ vars: NSDictionary) -> Double {
		for morph in morphs
			{morph(self)}
		
		let result: Double = (peek() as! RealObj).value
		
		return result
	}
	
	// Build
	func applyTag (_ tag: Tag) {
	}
	func addConstant (_ x: Double) {
		cons.append(RealObj(x))
		applyTag(Tag.constant)
	}
	func addVariable (_ name: String) {
		vars.append(name)
		applyTag(Tag.variable)
	}
}
