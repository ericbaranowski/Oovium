//
//  Cell.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Cell: Domain {
	var colID: Int = 0
	var rowNo: Int = 0
	var tokens: String = ""

	var chain: Chain!

	var tower = Tower()

// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["colID", "rowNo", "tokens"]
	}
}
