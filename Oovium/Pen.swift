//
//  Pen.swift
//  Oovium
//
//  Created by Joe Charlier on 4/15/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class Pen {
	var attributes = [String:Any]()
	
	var font: UIFont {
		set {attributes[NSFontAttributeName] = newValue}
		get {return attributes[NSFontAttributeName] as! UIFont}
	}
	var color: UIColor {
		set {attributes[NSForegroundColorAttributeName] = newValue}
		get {return attributes[NSForegroundColorAttributeName] as! UIColor}
	}
	var alignment: NSTextAlignment {
		set {style.alignment = newValue}
		get {return style.alignment}
	}
	var style: NSMutableParagraphStyle {
		set {attributes[NSParagraphStyleAttributeName] = newValue}
		get {return attributes[NSParagraphStyleAttributeName] as! NSMutableParagraphStyle}
	}
	
	init (font: UIFont) {
		self.font = font
		self.color = UIColor.white
		self.style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
		self.style.lineBreakMode = .byWordWrapping
	}
	convenience init() {
		self.init(font: UIFont.systemFont(ofSize: 12))
	}
	
	func copy() -> Pen {
		let pen = Pen(font: font)
		pen.color = color
		pen.alignment = alignment
		pen.style = style.mutableCopy() as! NSMutableParagraphStyle
		return pen
	}
}
