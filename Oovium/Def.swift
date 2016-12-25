//
//  Def.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Def: NSObject {
	public let name: String
	public let key: String
	public let properties: [String]
	public let color: UIColor
	public let order: Int
	
	init (name: String, key: String, properties: [String], color: UIColor, order: Int) {
		self.name = name
		self.key = key
		self.properties = properties
		self.color = color
		self.order = order
	}
	convenience init (name: String, key:String, properties: [String], color: UIColor) {
		self.init(name:name, key:key, properties:properties, color:color, order:9)
	}
	
	func format (_ obj: Obj) -> String {
		return "format not defined"
	}
	
	static let variable = {(lambda: Lambda)->() in
		lambda.push(lambda.nextVar())
	}
	static let constant = {(lambda: Lambda)->() in
		lambda.push(lambda.nextCons())
	}
}
