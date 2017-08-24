//
//  Persist.swift
//  Oovium
//
//  Created by Joe Charlier on 8/24/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

class Persist {
	
	func attributes(iden: String) -> [String:Any]? {return [:]}
	func attributes(type: String, only: String) -> [String:Any]? {return [:]}
	
	func store (iden: String, attributes: [String:Any]) {}
	func remove(iden: String) {}
	
	func transact(_ closure: ()->(Bool)) {}
	
	func set(key: String, value: String) {}
	func get(key: String) -> String? {return ""}
	func unset(key: String) {}
}
