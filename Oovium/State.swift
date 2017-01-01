//
//  State.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class State: Domain {
	var color: OOColor = .clear

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["color"]
	}
}
