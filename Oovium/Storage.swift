//
//  Storage.swift
//  Oovium
//
//  Created by Joe Charlier on 8/24/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

class Storage {
	static let basket: Basket = Basket(persist: iOSPersist())
	
	static func set(key: String, value: String) {
		basket.set(key: key, value: value)
	}
	static func get(key: String) -> String? {
		return basket.get(key: key)
	}
	static func unset(key: String) {
		basket.unset(key: key)
	}
}
