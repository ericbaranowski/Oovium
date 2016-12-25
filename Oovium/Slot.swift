//
//  Slot.swift
//  Oovium
//
//  Created by Joe Charlier on 12/11/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Slot: NSObject {
	var name: String
	var fixed: Bool
	var loaded: Bool
	var value: Obj
	
	init (_ name: String) {
		self.name = name
		fixed = false
		loaded = false
		value = RealObj(0)
	}
	convenience init (_ name: String, value:Obj) {
		self.init(name)
		self.value = value
	}
	func clear () {
		loaded = fixed
	}
}
