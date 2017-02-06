//
//  RealDef.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import UIKit

public final class RealDef: Def {
	public static let def = RealDef()
	
	init () {
		super.init(name: "Number", key:"num", properties: ["x"], color: UIColor.green, order:1)
	}
	
	static let add: (Lambda)->() = {(lambda: Lambda)->() in
		let a = lambda.pop() as! RealObj
		let b = lambda.pop() as! RealObj
		lambda.push(a+b)
	}

	static var formatter_ = NumberFormatter()
	static var scientific_ = NumberFormatter()
	
	public static func initialize () {
		formatter_.positiveFormat = "#,##0.########"
		formatter_.negativeFormat = "#,##0.########"
		
		scientific_.maximumIntegerDigits = 1
		scientific_.maximumFractionDigits = 8
		scientific_.exponentSymbol = "e"
		scientific_.numberStyle = .scientific
	}

	override func format (_ obj: ObjS) -> String {
		let x = (obj as! RealObj).x
		if (fabs(x) < 0.00000001 && x != 0) || fabs(x) > 999999999 {
			return RealDef.scientific_.string(from: NSNumber(value: x))!
		} else {
			return RealDef.formatter_.string(from: NSNumber(value: x))!
		}
	}

}
