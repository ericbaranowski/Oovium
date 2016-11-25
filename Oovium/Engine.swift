//
//  Engine.swift
//  Oovium
//
//  Created by Joe Charlier on 10/9/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Engine: NSObject {
	let name: String
	
	init (name: String) {
		self.name = name
	}
	
	func eval (_ vars:[String:Obj?]) -> TowerState {
		return .calced
	}
}
