//
//  Math.swift
//  Oovium
//
//  Created by Joe Charlier on 11/29/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Math: NSObject {
	static var morphs = [String:(Lambda)->()]()
	
	static func registerMorph (key: String, morph:@escaping (Lambda)->()) {
		morphs[key] = morph
	}
	static func registerOperator (tag: Tag, defs: [Def], morph:@escaping (Lambda)->()) {
		var key = "\(tag.key);"
		for def in defs {
			key += "\(def.key);"
		}
		registerMorph(key: key, morph: morph)
	}
	static func morph (key: String) -> (Lambda)->() {
		let morph = morphs[key]
		guard morph != nil else {
			print("key [\(key)] not found!")
			return Math.addCC
		}
		return morph!
	}
	
	static func isRR (_ lambda: Lambda) -> (RealObj, RealObj) {
		let y = lambda.pop() as! RealObj
		let x = lambda.pop() as! RealObj
		return (x,y)
	}
	static func isCC (_ lambda: Lambda) -> (ComplexObj, ComplexObj) {
		let y = lambda.pop() as! ComplexObj
		let x = lambda.pop() as! ComplexObj
		return (x,y)
	}
	static func isRC (_ lambda: Lambda) -> (ComplexObj, ComplexObj) {
		let y = lambda.pop() as! ComplexObj
		let x = ComplexObj((lambda.pop() as! RealObj).x)
		return (x,y)
	}
	static func isCR (_ lambda: Lambda) -> (ComplexObj, ComplexObj) {
		let y = ComplexObj((lambda.pop() as! RealObj).x)
		let x = lambda.pop() as! ComplexObj
		return (x,y)
	}
	static func toCC (_ lambda: Lambda) -> (ComplexObj, ComplexObj) {
		var t = lambda.pop()
		let y = t is ComplexObj ? t as! ComplexObj : ComplexObj((t as! RealObj).x)
		t = lambda.pop()
		let x = t is ComplexObj ? t as! ComplexObj : ComplexObj((t as! RealObj).x)
		return (x,y)
	}
	
	// Add
	static let addRR: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isRR(lambda)
		lambda.push(x+y)
	}
	static let addCC: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isCC(lambda)
		lambda.push(x+y)
	}
	static let addRC: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isRC(lambda)
		lambda.push(x+y)
	}
	static let addCR: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isCR(lambda)
		lambda.push(x+y)
	}
	
	// Sub
	static let subRR: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isRR(lambda)
		lambda.push(x-y)
	}
	static let subCC: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isCC(lambda)
		lambda.push(x-y)
	}
	static let subRC: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isRC(lambda)
		lambda.push(x-y)
	}
	static let subCR: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isCR(lambda)
		lambda.push(x-y)
	}
	
	// Mul
	static let mulRR: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isRR(lambda)
		lambda.push(x*y)
	}
	static let mulCC: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isCC(lambda)
		lambda.push(x*y)
	}
	static let mulRC: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isRC(lambda)
		lambda.push(x*y)
	}
	static let mulCR: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isCR(lambda)
		lambda.push(x*y)
	}

	// Div
	static let divRR: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isRR(lambda)
		lambda.push(x/y)
	}
	static let divCC: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isCC(lambda)
		lambda.push(x/y)
	}
	static let divRC: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isRC(lambda)
		lambda.push(x/y)
	}
	static let divCR: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isCR(lambda)
		lambda.push(x/y)
	}
	
	// Equals
	static let equalsRR: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isRR(lambda)
		lambda.push(x==y)
	}
	static let equalsCC: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isCC(lambda)
		lambda.push(x==y)
	}
	static let equalsRC: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isRC(lambda)
		lambda.push(x==y)
	}
	static let equalsCR: (Lambda)->() = {(lambda: Lambda)->() in
		let (x,y) = isCR(lambda)
		lambda.push(x==y)
	}
	
	public static func start () {
		registerOperator(tag: Tag.add, defs: [RealDef.def,RealDef.def], morph: addRR)
		registerOperator(tag: Tag.subtract, defs: [RealDef.def,RealDef.def], morph: subRR)
		registerOperator(tag: Tag.multiply, defs: [RealDef.def,RealDef.def], morph: mulRR)
		registerOperator(tag: Tag.divide, defs: [RealDef.def,RealDef.def], morph: divRR)
		registerOperator(tag: Tag.equal, defs: [RealDef.def,RealDef.def], morph: equalsRR)

		registerMorph(key:"var;num;", morph:Def.variable)
		registerMorph(key:"constant;", morph:Def.constant)
	}
}
