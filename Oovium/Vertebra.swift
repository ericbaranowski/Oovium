//
//  Vertebra.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

final class Vertebra: Domain {
	var name: String = ""
	var def: Def = RealDef.def
	var tokens: String = ""
	
	var chain: Chain!
	
	var tower = Tower()

// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["name", "def", "tokens"]
	}
}
