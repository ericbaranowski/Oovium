//
//  Ops.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Ops: NSObject {
	private let lambda: Lambda
	
	private var pOp: String?
	private var mOp: String?
	private var aOp: String?
	private var cOp: String?
	
	init (_ lambda: Lambda) {
		self.lambda = lambda
	}
	
	private func doPOP (_ o: String?) {
//		if let tag = pOp {lambda.applyTag(tag: tag, stack: stack)}
		pOp = o
	}
	private func doMOP (_ o: String?) {
//		if let tag = mOp {lambda.applyTag(tag: tag, stack: stack)}
		mOp = o
	}
	private func doAOP (_ o: String?) {
//		if let tag = aOp {lambda.applyTag(tag: tag, stack: stack)}
		aOp = o
	}
	private func doCOP (_ o: String?) {
//		if let tag = cOp {lambda.applyTag(tag: tag, stack: stack)}
		cOp = o
	}
	
	func pOp (_ o: String) {
		doPOP(o)
	}
	func mOp (_ o: String) {
		doPOP(nil)
		doMOP(o)
	}
	func aOp (_ o: String) {
		doPOP(nil)
		doMOP(nil)
		doAOP(o)
	}
	func cOp (_ o: String) {
		doPOP(nil)
		doMOP(nil)
		doAOP(nil)
		doCOP(o)
	}
	func end () {
		doPOP(nil)
		doMOP(nil)
		doAOP(nil)
		doCOP(nil)
	}
}
