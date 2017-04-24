//
//  Lambda.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Lambda {
	var lambdaC: UnsafeMutablePointer<LambdaC>!
	
	public var morphs: [Morph] = [Morph]()
	public var cons = [ObjS]()
	public var variables = [String]()
	public var varIndexes = [Int]()
	var stack: [ObjS] = [ObjS]()
	var cp: Int = 0
	var vp: Int = 0
	var sp: Int = 0
	public var vi: Int = 0
	
	public init() {
		stack = [ObjS](repeating: RealObj.zero, count: 10)
		cp = 0
		vp = 0
		sp = 0
		vi = 0
	}
	public init (morphs: [Morph], cons: [ObjS], vars: [String]) {
		self.morphs = morphs
		self.cons = cons
		self.variables = vars
		stack = [ObjS](repeating: RealObj.zero, count: 10)
		cp = 0
		vp = 0
		sp = 0
		vi = 0
	}
	
	// Constants
	func nextCons() -> ObjS {
		let obj = cons[cp]
		cp += 1
		return obj
	}
	
	// Stack
	func push (_ obj: ObjS) {
		stack[sp] = obj;
		sp += 1
	}
	func pop() -> ObjS {
		sp -= 1
		return stack[sp]
	}
	func peek() -> ObjS {
		return stack[sp-1]
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
	func addMorph (_ morph: Morph) {
		morphs.append(morph)
		push(RealObj(0))
	}
	public func compile (memory: UnsafeMutablePointer<Memory>) {
		varIndexes = [Int]()
		for name in variables {
			varIndexes.append(Int(AEMemoryIndexForName(memory, name.toInt8())))
		}
		
		let cn = cons.count
		let c: UnsafeMutablePointer<Obj>! = UnsafeMutablePointer<Obj>.allocate(capacity: cn)
		for i in 0..<cn {
			c[i].a.x = (cons[i] as! RealObj).x
		}
		
		let vn = variables.count
		let v: UnsafeMutablePointer<UInt8>! = UnsafeMutablePointer<UInt8>.allocate(capacity: vn)
		for i in 0..<vn {
			v[i] = UInt8(AEMemoryIndexForName(memory, variables[i].toInt8()))
		}

		let mn = morphs.count
		let m: UnsafeMutablePointer<UInt8>! = UnsafeMutablePointer<UInt8>.allocate(capacity: mn)
		for i in 0..<mn {
			m[i] = UInt8(morphs[i].rawValue)
		}
		
		lambdaC = AELambdaCreate(UInt8(vi), c, UInt8(cn), v, UInt8(vn), m, UInt8(mn))
		
		c.deallocate(capacity: cn)
		v.deallocate(capacity: vn)
		m.deallocate(capacity: mn)
	}	
}
