//
//  Text.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

enum OOColor {
	case red, orange, yellow, lime, maroon, peach, paleYellow, olive, magenta, lavender, marine, green, violet, cyan, cobolt, blue, black, grey, white, clear
	case cgaRed, cgaLightRed, cgaBrown, cgaYellow, cgaGreen, cgaLightGreen, cgaCyan, cgaLightCyan, cgaBlue, cgaLightBlue, cgaMagenta, cgaLightMagenta
	
}
enum OOShape {
	case ellipse, rectangle, rounded, diamond
}

class Text: Domain {
	var text: String = ""
	var color: OOColor = .orange
	var shape: OOShape = .ellipse
	var note: String = ""
	var x: Double = 0.0
	var y: Double = 0.0
}
