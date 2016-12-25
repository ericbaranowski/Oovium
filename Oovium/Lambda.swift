//
//  Pebble.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Lambda: NSObject {
	public var morphs: [@convention(block) (Lambda)->()] = [(Lambda)->()]()
	public var cons = [Obj]()
	public var variables = [String]()
	public var varIndexes = [Int]()
	var stack: [Obj?] = [Obj?]()
	var cp: Int = 0
	var vp: Int = 0
	var sp: Int = 0
	public var vi: Int = 0
	var memory: Memory!
	
	public override init () {
		stack = [Obj?](repeating: nil, count: 10)
		cp = 0
		vp = 0
		sp = 0
		vi = 0
	}
	public init (morphs: [(Lambda)->()], cons: [Obj], vars: [String]) {
		self.morphs = morphs
		self.cons = cons
		self.variables = vars
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
		let obj = memory[varIndexes[vp]]!
		vp += 1
		return obj
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
	public func evaluate (_ memory: Memory) -> Obj {
		cp = 0
		vp = 0
		sp = 0
		self.memory = memory
		for morph in morphs
			{morph(self)}
		return peek()
	}
	public func doubleEvaluate (_ memory: Memory) -> Double {
		cp = 0
		vp = 0
		sp = 0
		self.memory = memory
		
		for morph in morphs
			{morph(self)}
		
		let result: Double = (peek() as! RealObj).value
		
		return result
	}
	
	// Build
	func applyTag (_ tag: Tag) {
		var key = "\(tag.key);"
		var defKeys = [String]()
		for _ in 0..<tag.params {
			let obj = pop()
			defKeys.append(obj.def.key)
		}
		for i in 0..<tag.params {
			key += "\(defKeys[tag.params-1-i]);"
		}
		addMorph(Math.morph(key: key))
	}
	func addConstant (_ x: Double) {
		cons.append(RealObj(x))
		applyTag(Tag.constant)
	}
//	func addVariable (_ name: String) {
//		variables.append(name)
//		applyTag(Tag.variable)
//	}
	func addMorph (_ morph: @escaping (Lambda)->()) {
		morphs.append(morph)
		push(RealObj(0))
	}
	public func compile(memory: Memory) {
		varIndexes = [Int]()
		for name in variables {
			varIndexes.append(memory.index(for: name))
		}
	}
}
