//
//  State.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class State: Domain {
//	var color: OOColor = .clear
	public var color: Int = 0

// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["color"]
	}
}
