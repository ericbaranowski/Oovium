//
//  ComplexDef.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class ComplexDef: Def {
	public static let def = ComplexDef()
	
	init () {
		super.init(name: "Complex", key:"cpx", properties: ["r", "i"], color: UIColor.cyan, order:2)
	}	
}
