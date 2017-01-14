//
//  Type.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Type: Aexel {
	var color: OOColor = .black
	
	var fields: [Field] = []

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["color"]
	}
	override func children () -> [String] {
		return super.children() + ["fields"]
	}
}
