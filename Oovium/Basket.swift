//
//  Basket.swift
//  Oovium
//
//  Created by Joe Charlier on 12/31/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Basket {
	let persist: Persist
	
	var cache = [Int:Anchor]()
	var blocks: [String:(Domain)->()] = [:]
	
	init(persist: Persist) {
		self.persist = persist
	}

	func load (attributes: [String:Any], cls: Anchor.Type) -> Anchor {
//		let iden: Int = attributes["iden"] as! Int
//		let type: String = attributes["type"] as! String
		
		let anchor = cls.init(attributes: attributes)
		anchor.basket = self
//		anchor.load(attributes: attributes)
		cache[anchor.iden] = anchor
		return anchor
	}
	func load (attributes: [String:Any]) -> Anchor {
		let cls = Domain.classFromName(attributes["type"] as! String) as! Anchor.Type
		return load(attributes: attributes, cls: cls)
	}
	public func inject (attributes: [String:Any]) -> Anchor {
		let anchor = load(attributes: attributes)
		return anchor
	}
	
	func blocksFor (class: Domain.Type, action: DomainAction) -> [(Domain)->()] {
		return []
	}
	
// Memory ==========================================================================================
	func set(key: String, value: String) {
		persist.set(key: key, value: value)
	}
	func get(key: String) -> String? {
		return persist.get(key: key)
	}
	func unset(key: String) {
		persist.unset(key: key)
	}
}
