//
//  Local.swift
//  Oovium
//
//  Created by Joe Charlier on 8/23/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

class Local {
	static var documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
	
	private static func path(name: String) -> String {
		return documentsURL.appendingPathComponent("\(name).oo").path
	}
	private static func toJSON(_ attributes: [String:Any]) -> Data? {
		do {
			return try JSONSerialization.data(withJSONObject: attributes, options: [])
		} catch {
			print("\(error)")
			return nil
		}
	}
	private static func fromJSON(_ data: Data) -> [String:Any] {
		do {
			return try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
		} catch {
			print("\(error)")
			return [:]
		}
	}
	
	static func aetherNames() -> [String] {
		var aethers = [String]()
		do {
			let contents = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: [])
			let filtered = contents.filter({$0.pathExtension == "oo"})
			aethers = filtered.map({$0.deletingPathExtension().lastPathComponent})
		} catch {
			print("\(error)")
		}
		return aethers
	}
	
	static func hasAether(name: String) -> Bool {
		return FileManager.default.fileExists(atPath: Local.path(name: name))
	}
	
	static func loadAether(name: String) -> Aether {
		let data = FileManager.default.contents(atPath: Local.path(name: name))!
		let attributes: [String:Any] = Local.fromJSON(data)
		
		let aether = Aether()
		aether.load(attributes: attributes)
		
		return aether
	}
	
	static func storeAether(aether: Aether) {
		FileManager.default.createFile(atPath: Local.path(name: aether.name), contents: Local.toJSON(aether.unload()), attributes: nil)
	}

	static func removeAether(name: String) {
		do {
			try FileManager.default.removeItem(atPath: Local.path(name: name))
		} catch {
			print("\(error)")
		}
	}
}
