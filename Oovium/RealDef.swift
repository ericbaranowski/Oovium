//
//  RealDef.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class RealDef: Def {
	static let cons: (Lambda)->() = {(lambda: Lambda)->() in
		lambda.push(lambda.nextCons())
	}
	static let add: (Lambda)->() = {(lambda: Lambda)->() in
		let a = lambda.pop() as! RealObj
		let b = lambda.pop() as! RealObj
		lambda.push(a+b)
	}
}
