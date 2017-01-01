//
//  Miru.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Miru: Aexel {
	var gridID: Int = 0

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["gridID"]
	}
}
