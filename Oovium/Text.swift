//
//  Text.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Text: Aexel {
	var color: OOColor = .orange
	var shape: OOShape = .ellipse
	
	var edges: [Edge] = []

// Aexel ===========================================================================================
	override var freeVars: [String] {
		return []
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["color", "shape"]
	}
	override func children() -> [String] {
		return super.children() + ["edges"]
	}
}
