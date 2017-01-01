//
//  Migrate.swift
//  Oovium
//
//  Created by Joe Charlier on 12/31/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Migrator {
	let acceptor: ([String:Any])->(Bool)
	let migrator: ([String:Any])->([String:Any])
	
	init (acceptor: @escaping ([String:Any])->(Bool), migrator: @escaping ([String:Any])->([String:Any])) {
		self.acceptor = acceptor
		self.migrator = migrator
	}
}

public class Migrate: NSObject {
	var migrators = [Migrator]()
	
	public func migrate (_ attributes: [String:Any]) -> [String:Any] {
		var attributes = attributes
		
		migrators.append(Migrator(acceptor: { (attributes: [String:Any])->(Bool) in
			return true
		}, migrator: { (attributes: [String:Any])->([String:Any]) in
			
			var aether = [String:Any]()
			
			aether["iden"] = Int(attributes["aetherID"] as! String)
			aether["type"] = "aether"
			aether["name"] = attributes["name"]
			aether["readOnly"] = attributes["readOnly"]
			aether["xOffset"] = attributes["offsetX"]
			aether["yOffset"] = attributes["offsetY"]
			
			if (attributes["instances"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["instances"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["instanceID"] as! String)
					atts["type"] = "object"
					atts["name"] = child["name"]
					atts["x"] = child["x"]
					atts["y"] = child["y"]
					atts["tokens"] = child["tokens"]
					array.append(atts)
				}
				aether["objects"] = array
			}
			
			if (attributes["ifs"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["ifs"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["ifID"] as! String)
					atts["type"] = "gate"
					atts["name"] = child["name"]
					atts["x"] = child["x"]
					atts["y"] = child["y"]
					atts["ifTokens"] = child["ifString"]
					atts["thenTokens"] = child["thenString"]
					atts["elseTokens"] = child["elseString"]
					array.append(atts)
				}
				aether["gates"] = array
			}
			
			if (attributes["crons"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["crons"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["cronID"] as! String)
					atts["type"] = "cron"
					atts["name"] = child["name"]
					atts["x"] = child["x"]
					atts["y"] = child["y"]
					atts["startTokens"] = child["startString"]
					atts["stopTokens"] = child["stopString"]
					atts["stepsTokens"] = child["stepstring"]
					atts["rateTokens"] = child["rateString"]
					atts["deltaTokens"] = child["deltaString"]
					atts["whileTokens"] = child["whileString"]
					atts["endMode"] = child["endMode"]
					atts["exposed"] = child["exposed"]
					array.append(atts)
				}
				aether["crons"] = array
			}
			
			if (attributes["ovals"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["ovals"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["ovalID"] as! String)
					atts["type"] = "text"
					atts["name"] = child["text"]
					atts["x"] = child["x"]
					atts["y"] = child["y"]

					if (child["links"] != nil) {
						var array2 = [[String:Any]]()
						for child2 in child["links"] as! [[String:Any]] {
							var atts2 = [String:Any]()
							atts2["iden"] = Int(child2["linkID"] as! String)
							atts2["type"] = "edge"
							atts2["textID"] = child2["linkedID"]
							array2.append(atts2)
						}
						atts["edges"] = array2
					}
					
					array.append(atts)
				}
				aether["texts"] = array
			}
			
			if (attributes["mechs"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["mechs"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["mechID"] as! String)
					atts["type"] = "mech"
					atts["name"] = child["name"]
					atts["x"] = child["x"]
					atts["y"] = child["y"]
					atts["resultTokens"] = child["tokens"]

					if (child["inputs"] != nil) {
						var array2 = [[String:Any]]()
						for child2 in child["inputs"] as! [[String:Any]] {
							var atts2 = [String:Any]()
							atts2["iden"] = Int(child2["inputID"] as! String)
							atts2["type"] = "input"
							atts2["name"] = child2["name"]
							atts2["def"] = "real"
							array2.append(atts2)
						}
						atts["inputs"] = array2
					}
					
					array.append(atts)
				}
				aether["mechs"] = array
			}
			
			if (attributes["tails"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["tails"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["tailID"] as! String)
					atts["type"] = "tail"
					atts["name"] = child["name"]
					atts["x"] = child["x"]
					atts["y"] = child["y"]
					atts["whileTokens"] = child["whileString"]
					atts["resultTokens"] = child["resultString"]

					if (child["vertebras"] != nil) {
						var array2 = [[String:Any]]()
						for child2 in child["vertebras"] as! [[String:Any]] {
							var atts2 = [String:Any]()
							atts2["iden"] = Int(child2["vertebraID"] as! String)
							atts2["type"] = "vertebra"
							atts2["name"] = child2["name"]
							atts2["def"] = "real"
							atts2["tokens"] = child2["tokens"]
							array2.append(atts2)
						}
						atts["vertebras"] = array2
					}
					
					array.append(atts)
				}
				aether["tails"] = array
			}
			
			if (attributes["autos"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["autos"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["autoID"] as! String)
					atts["type"] = "auto"
					atts["name"] = ""
					atts["x"] = child["x"]
					atts["y"] = child["y"]
					atts["statesTokens"] = child["statesString"]
					atts["resultTokens"] = child["nextString"]

					if (child["autoStates"] != nil) {
						var array2 = [[String:Any]]()
						for child2 in child["autoStates"] as! [[String:Any]] {
							var atts2 = [String:Any]()
							atts2["iden"] = Int(child2["autoStateID"] as! String)
							atts2["type"] = "state"
							atts2["color"] = child2["color"]
							array2.append(atts2)
						}
						atts["states"] = array2
					}
					
					array.append(atts)
				}
				aether["autos"] = array
			}
			
			if (attributes["casts"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["casts"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["castID"] as! String)
					atts["type"] = "type"
					atts["name"] = child["name"]
					atts["x"] = child["x"]
					atts["y"] = child["y"]
					atts["color"] = child["color"]
					
					if (child["fields"] != nil) {
						var array2 = [[String:Any]]()
						for child2 in child["fields"] as! [[String:Any]] {
							var atts2 = [String:Any]()
							atts2["iden"] = Int(child2["fieldID"] as! String)
							atts2["type"] = "field"
							atts2["name"] = child2["name"]
							atts2["def"] = "real"
							array2.append(atts2)
						}
						atts["fields"] = array2
					}
					
					array.append(atts)
				}
				aether["types"] = array
			}
			
			if (attributes["grids"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["grids"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["gridID"] as! String)
					atts["type"] = "grid"
					atts["name"] = child["name"]
					atts["x"] = child["x"]
					atts["y"] = child["y"]
					atts["castID"] = child["castID"]
					atts["rows"] = child["rows"]
					
					if (child["cols"] != nil) {
						var array2 = [[String:Any]]()
						for child2 in child["cols"] as! [[String:Any]] {
							var atts2 = [String:Any]()
							atts2["iden"] = Int(child2["colID"] as! String)
							atts2["type"] = "col"
							atts2["name"] = child2["name"]
							atts2["def"] = "real"
							atts2["tokens"] = child2["tokens"]
							atts2["aggregate"] = child2["aggregate"]
							atts2["justify"] = child2["justify"]
							atts2["format"] = child2["format"]
							array2.append(atts2)
						}
						atts["cols"] = array2
					}
					if (child["cells"] != nil) {
						var array2 = [[String:Any]]()
						for child2 in child["cells"] as! [[String:Any]] {
							var atts2 = [String:Any]()
							atts2["iden"] = Int(child2["cellID"] as! String)
							atts2["type"] = "cell"
							atts2["colID"] = child2["colID"]
							atts2["rowNo"] = child2["rowNo"]
							atts2["tokens"] = child2["tokens"]
							array2.append(atts2)
						}
						atts["cells"] = array2
					}
					
					array.append(atts)
				}
				aether["grids"] = array
			}
			
			if (attributes["mirus"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["mirus"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["miruID"] as! String)
					atts["type"] = "miru"
					atts["name"] = ""
					atts["x"] = child["x"]
					atts["y"] = child["y"]
					atts["gridID"] = child["gridID"]
					array.append(atts)
				}
				aether["mirus"] = array
			}
			
			if (attributes["includes"] != nil) {
				var array = [[String:Any]]()
				for child in attributes["includes"] as! [[String:Any]] {
					var atts = [String:Any]()
					atts["iden"] = Int(child["includeID"] as! String)
					atts["type"] = "import"
					atts["name"] = child["name"]
					atts["x"] = 0.0
					atts["y"] = 0.0
					array.append(atts)
				}
				aether["imports"] = array
			}
			
			return aether
		}))
		
		for migrator in migrators {
			if migrator.acceptor(attributes) {
				attributes = migrator.migrator(attributes)
			}
		}
		
		return attributes
	}
}
