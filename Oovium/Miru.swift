//
//  Miru.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Miru: Aexel {
	var gridID: Int = 0

// Aexel ===========================================================================================
	override var freeVars: [String] {
		return []
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["gridID"]
	}
}
