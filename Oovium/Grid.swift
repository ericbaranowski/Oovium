//
//  Grid.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Grid: Aexel {
	var typeID: Int = 0
	var rows: Int = 0
	
	var cols: [Col] = []
	var cells: [Cell] = []


// Aexel ===========================================================================================
	override var freeVars: [String] {
		return []
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["typeID", "rows"]
	}
	override func children() -> [String] {
		return super.children() + ["cols", "cells"]
	}
}
