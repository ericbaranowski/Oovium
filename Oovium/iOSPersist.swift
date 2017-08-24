//
//  iOSPersist.swift
//  Oovium
//
//  Created by Joe Charlier on 8/24/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

class iOSPersist: Persist {
// Persist =========================================================================================
	override func set(key: String, value: String) {
		UserDefaults.standard.set(value, forKey: key)
	}
	override func get(key: String) -> String? {
		let value = UserDefaults.standard.value(forKey: key)
		
		return value == nil ? nil : value as? String
	}
	override func unset(key: String) {
		return UserDefaults.standard.removeObject(forKey: key)
	}
}
