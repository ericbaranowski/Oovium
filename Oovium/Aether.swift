//
//  Aether.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

@objc public class Aether: Anchor {
	var name: String = ""
	var xOffset: Double = 0
	var yOffset: Double = 0
	var readOnly: Bool = false
	
	public var objects: [Object] = []
	public var gates: [Gate] = []
	public var crons: [Cron] = []
	public var texts: [Text] = []
	public var mechs: [Mech] = []
	public var tails: [Tail] = []
	public var autos: [Auto] = []
	public var types: [Type] = []
	public var grids: [Grid] = []
	public var mirus: [Miru] = []
	
// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["name", "xOffset", "yOffset", "readOnly"]
	}
	override func children () -> [String] {
		return super.children() + ["objects", "gates", "crons", "texts", "mechs", "tails", "autos", "types", "grids", "mirus"]
	}
}
