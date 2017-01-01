//
//  Aether.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Aether: Anchor {
	var name: String = ""
	var xOffset: Double = 0
	var yOffset: Double = 0
	var readOnly: Bool = false
	
	var objects: [Object] = []
	var gates: [Gate] = []
	var crons: [Cron] = []
	var texts: [Text] = []
	var mechs: [Mech] = []
	var tails: [Tail] = []
	var autos: [Auto] = []
	var types: [Type] = []
	var grids: [Grid] = []
	var mirus: [Miru] = []
	
// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["name", "xOffset", "yOffset", "readOnly"]
	}
	override func children () -> [String] {
		return super.children() + ["objects", "gates", "crons", "texts", "mechs", "tail", "auto", "types", "grids", "mirus"]
	}
}
