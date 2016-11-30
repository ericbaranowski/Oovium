//
//  ComplexDef.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class ComplexDef: Def {
	static let def = ComplexDef()
	
	init () {
		super.init(name: "Complex", properties: ["r", "i"], color: UIColor.cyan, order:2)
	}	
}
