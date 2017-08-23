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
	func bubble (path: CGPath, uiColor: UIColor, width: CGFloat) {}
	func bubble (text: String, x: CGFloat, y: CGFloat, uiColor: UIColor) {}
	func message (text: String, rect: CGRect, uiColor: UIColor, font: UIFont) {}
	func aetherPicker (path: CGPath) {}
	func aetherPickerList (path: CGPath) {}
	func aetherCell (path: CGPath) {}
	func aetherCell (text: String, rect: CGRect) {}
	func wafer(text: String, x: CGFloat, y: CGFloat, uiColor: UIColor) -> CGFloat {return 0}
	
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
	static func bubble (path: CGPath, uiColor: UIColor, width: CGFloat) {
		skin.bubble(path: path, uiColor: uiColor, width: width)
	}
	static func bubble (text: String, x: CGFloat, y: CGFloat, uiColor: UIColor) {
		skin.bubble(text: text, x: x, y: y, uiColor: uiColor)
	}
	static func message (text: String, rect: CGRect, uiColor: UIColor, font: UIFont) {
		skin.message(text: text, rect: rect, uiColor: uiColor, font: font)
	}
	static func aetherPicker (path: CGPath) {
		skin.aetherPicker(path: path)
	}
	static func aetherPickerList (path: CGPath) {
		skin.aetherPickerList(path: path)
	}
	static func aetherCell (path: CGPath) {
		skin.aetherCell(path: path)
	}
	static func aetherCell (text: String, rect: CGRect) {
		skin.aetherCell(text: text, rect: rect)
	}
	static func wafer(text: String, x: CGFloat, y: CGFloat, uiColor: UIColor) -> CGFloat {
		return skin.wafer(text: text, x: x, y: y, uiColor: uiColor)
	}
}
