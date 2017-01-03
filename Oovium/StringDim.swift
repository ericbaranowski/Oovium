//
//  StringDim.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class StringDim: Dim {
	var string: String
	
	init (_ string: String) {
		self.string = string
	}
	
	// Dim ===========================================================================================
	override func asString () -> (String) {
		return string
	}
	
// Static ==========================================================================================
	static func dim (_ string: String) -> (StringDim) {
		return StringDim(string)
	}
}
