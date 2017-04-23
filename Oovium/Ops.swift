//
//  Ops.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

final class Ops {
	private let lambda: Lambda
	
	private var pOp: Tag?
	private var mOp: Tag?
	private var aOp: Tag?
	private var cOp: Tag?
	
	init (_ lambda: Lambda) {
		self.lambda = lambda
	}
	
	private func doPOP (_ tag: Tag?) {
		if let pOp = pOp {lambda.applyTag(pOp)}
		pOp = tag
	}
	private func doMOP (_ tag: Tag?) {
		if let mOp = mOp {lambda.applyTag(mOp)}
		mOp = tag
	}
	private func doAOP (_ tag: Tag?) {
		if let aOp = aOp {lambda.applyTag(aOp)}
		aOp = tag
	}
	private func doCOP (_ tag: Tag?) {
		if let cOp = cOp {lambda.applyTag(cOp)}
		cOp = tag
	}
	
	func pOp (_ tag: Tag) {
		doPOP(tag)
	}
	func mOp (_ tag: Tag) {
		doPOP(nil)
		doMOP(tag)
	}
	func aOp (_ tag: Tag) {
		doPOP(nil)
		doMOP(nil)
		doAOP(tag)
	}
	func cOp (_ tag: Tag) {
		doPOP(nil)
		doMOP(nil)
		doAOP(nil)
		doCOP(tag)
	}
	func end() {
		doPOP(nil)
		doMOP(nil)
		doAOP(nil)
		doCOP(nil)
	}
}
