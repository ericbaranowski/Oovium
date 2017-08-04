//
//  Skin.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class Skin {
	
	func panel (path: CGPath, uiColor: UIColor) {}
	func key (path: CGPath, uiColor: UIColor) {}
	func key (text: String, rect: CGRect, font: UIFont) {}
	func bubble (path: CGPath, uiColor: UIColor) {}
	func bubble (text: String, x: CGFloat, y: CGFloat, uiColor: UIColor) {}
	
// Static ==========================================================================================
	static var skin: Skin = TronSkin()
	
	static func panel (path: CGPath, uiColor: UIColor) {
		skin.panel(path: path, uiColor: uiColor)
	}
	static func key (path: CGPath, uiColor: UIColor) {
		skin.key(path: path, uiColor: uiColor)
	}
	static func key (text: String, rect: CGRect, font: UIFont) {
		skin.key(text: text, rect: rect, font: font)
	}
	static func bubble (path: CGPath, uiColor: UIColor) {
		skin.bubble(path: path, uiColor: uiColor)
	}
	static func bubble (text: String, x: CGFloat, y: CGFloat, uiColor: UIColor) {
		skin.bubble(text: text, x: x, y: y, uiColor: uiColor)
	}
}
