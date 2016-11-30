//
//  Def.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Def: NSObject {
	var name: String
	var properties: [String]
	var color: UIColor
	var order: Int
	
	init (name: String, properties: [String], color: UIColor, order: Int) {
		self.name = name
		self.properties = properties
		self.color = color
		self.order = order
	}
	convenience init (name: String, properties: [String], color: UIColor) {
		self.init(name:name, properties:properties, color:color, order:9)
	}
}
