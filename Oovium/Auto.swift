//
//  Auto.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Auto: Aexel {
	var statesTokens: String = ""
	var resultTokens: String = ""
	
	var states: [State] = []
	
	var statesTower = Tower()
	var headTower = Tower()
	var resultTower = Tower()

	@objc public func token (name: String) {
	}
	
// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["statesTokens", "resultTokens"]
	}
	override func children () -> [String] {
		return super.children() + ["states"]
	}
}
