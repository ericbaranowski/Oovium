//
//  Basket.swift
//  Oovium
//
//  Created by Joe Charlier on 12/31/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Basket {
	var cache = [Int:Anchor]()
	var blocks: [String:(Domain)->()] = [:]
	
	public init () {}

	func load (attributes: [String:Any], cls: Anchor.Type) -> Anchor {
		let anchor = cls.init(basket: self)
		anchor.load(attributes: attributes)
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
}
