//
//  Tag.swift
//  Oovium
//
//  Created by Joe Charlier on 10/12/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Tag: NSObject {
	var key: String
	var params: Int
	
	private init (key: String, params:Int) {
		self.key = key
		self.params = params
	}
	
	static var tags: [String:Tag] = [String:Tag]()
	static func tag (key: String, params:Int) -> Tag {
		print("\(key)")
		var tag: Tag? = tags[key]
		if tag == nil {
			tag = Tag(key:key, params:params)
			tags[key] = tag
		}
		return tag!
	}
	static func tag (key: String) -> Tag {
		return tag(key:key, params:1)
	}
	
	static let constant: Tag		= tag(key:"constant")
	static let variable: Tag		= tag(key:"variable")
	static let negative: Tag		= tag(key:"negative")
	
	static let add: Tag				= tag(key:"+", params:2)
	static let subtract: Tag		= tag(key:"−", params:2)
	static let multiply: Tag		= tag(key:"×", params:2)
	static let divide: Tag			= tag(key:"÷", params:2)
	static let dot: Tag				= tag(key:"⋅", params:2)
	static let mod: Tag				= tag(key:"%", params:2)
	static let power: Tag			= tag(key:"^", params:2)
	static let equal: Tag			= tag(key:"=", params:2)
	static let less: Tag			= tag(key:"<", params:2)
	static let greater: Tag			= tag(key:">", params:2)
	static let notEqual: Tag		= tag(key:"≠", params:2)
	static let lessOrEqual: Tag		= tag(key:"≤", params:2)
	static let greaterOrEqual: Tag	= tag(key:"≥", params:2)
	static let not: Tag				= tag(key:"!")
	static let and: Tag				= tag(key:"&", params:2)
	static let or: Tag				= tag(key:"|", params:2)
	static let leftParen: Tag		= tag(key:"(")
	static let comma: Tag			= tag(key:",")
	static let rightParen: Tag		= tag(key:")")
	static let bra: Tag				= tag(key:"[")
	static let ket: Tag				= tag(key:"]")
	static let quote: Tag			= tag(key:"\"")
	
	static let e: Tag				= tag(key:"e")
	static let i: Tag				= tag(key:"i")
	static let pi: Tag				= tag(key:"π")
}
