//
//  JSON.swift
//  Oovium
//
//  Created by Joe Charlier on 1/7/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

public final class JSON {
	public static func toJSON (attributes: [String:Any]) -> String {
		do {
			let data = try JSONSerialization.data(withJSONObject: attributes, options: .prettyPrinted)
			let json = String(data:data, encoding: .utf8)!
			return json
		} catch {
			print("\(error)")
			return ""
		}
	}
	public static func fromJSON (json: String) -> [String:Any] {
		do {
			let data = json.data(using: .utf8)!
			return try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as! [String:Any]
		} catch {
			print("\(error)")
			return [:]
		}
	}
}
