//
//  TronSkin.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class TronSkin: Skin {
// Skin ============================================================================================
	// Panel
	override func panel (path: CGPath, uiColor: UIColor) {
		let rgb = RGB(uiColor: uiColor)
		let field = rgb.blend(rgb: RGB.white, percent: 0.5)
		let accent = rgb.blend(rgb: RGB.black, percent: 0.5)
		
		let c = UIGraphicsGetCurrentContext()!
		c.setFillColor(field.uiColor.withAlphaComponent(0.5).cgColor)
		c.setStrokeColor(accent.cgColor)
		c.setLineWidth(1.5)
		c.addPath(path)
		c.drawPath(using: .fillStroke)
	}
	
	// Key
	override func key (path: CGPath, uiColor: UIColor) {
		let rgb = RGB(uiColor: uiColor)
		let field = rgb.blend(rgb: RGB.white, percent: 0.5)
		let accent = rgb.blend(rgb: RGB.black, percent: 0.5)
		
		let c = UIGraphicsGetCurrentContext()!
		c.setFillColor(field.cgColor)
		c.setStrokeColor(accent.cgColor)
		c.addPath(path)
		c.drawPath(using: .fillStroke)
	}
	override func key (text: String, rect: CGRect, font: UIFont) {
		let pen = Pen(font: font)
		let size = (text as NSString).size(attributes: pen.attributes)
		let c = UIGraphicsGetCurrentContext()!
		c.saveGState()
		c.setShadow(offset: CGSize(width: 2, height: 2), blur: 2)
		c.setFillColor(UIColor.white.cgColor)
		let inside = CGRect(x: (rect.size.width-size.width)/2, y: (rect.size.height-size.height)/2, width: size.width, height: size.height)
		(text as NSString).draw(in: inside, withAttributes: pen.attributes)
		c.restoreGState()
	}
	
	// Bubble
	override func bubble (path: CGPath, uiColor: UIColor) {
		let c = UIGraphicsGetCurrentContext()!
		
		c.setFillColor(UIColor.black.withAlphaComponent(0.7).cgColor)
		c.addPath(path)
		c.drawPath(using: .fill)
		
		c.setStrokeColor(uiColor.withAlphaComponent(0.4).cgColor)
		c.setLineWidth(6)
		c.addPath(path)
		c.drawPath(using: .stroke)

		c.setStrokeColor(uiColor.withAlphaComponent(0.6).cgColor)
		c.setLineWidth(4)
		c.addPath(path)
		c.drawPath(using: .stroke)

		c.setStrokeColor(UIColor.white.cgColor)
		c.setLineWidth(2)
		c.addPath(path)
		c.drawPath(using: .stroke)
	}
	override func bubble (text: String, x: CGFloat, y: CGFloat, uiColor: UIColor) {
		let pen = Pen(font: UIFont(name: "HelveticaNeue", size: 16)!)
		pen.color = uiColor.withAlphaComponent(0.4)

		(text as NSString).draw(at: CGPoint(x: x+1, y: y+1), withAttributes: pen.attributes)
		(text as NSString).draw(at: CGPoint(x: x-1, y: y-1), withAttributes: pen.attributes)
		
		pen.color = UIColor.white
		(text as NSString).draw(at: CGPoint(x: x, y: y), withAttributes: pen.attributes)
	}
	// Miscellaneous
	override func message (text: String, rect: CGRect, uiColor: UIColor, font: UIFont) {
		let style = NSMutableParagraphStyle()
		style.lineBreakMode = .byWordWrapping
		
		let pen = Pen(font: font)
		pen.alignment = .left
		pen.style = style
		
		pen.color = uiColor.alpha(0.4)
		(text as NSString).draw(in: rect.offsetBy(dx: -1, dy: 1), withAttributes: pen.attributes)
		(text as NSString).draw(in: rect.offsetBy(dx: 1, dy: 1), withAttributes: pen.attributes)
		
		pen.color = UIColor.white
		(text as NSString).draw(in: rect, withAttributes: pen.attributes)
	}
	// AetherPicker
	override func aetherPicker (path: CGPath) {
		let rgb = RGB(uiColor: UIColor.green)
		let c = UIGraphicsGetCurrentContext()!
		c.setStrokeColor(rgb.shade(0.4).cgColor)
		c.setFillColor(rgb.tint(0.9).uiColor.alpha(0.85).cgColor)
		c.setLineWidth(2)
		c.addPath(path)
		c.drawPath(using: .fillStroke)
	}
	override func aetherPickerList (path: CGPath) {
		let rgb = RGB(uiColor: UIColor.orange)
		let c = UIGraphicsGetCurrentContext()!
		c.setStrokeColor(rgb.shade(0.4).cgColor)
		c.setFillColor(rgb.tint(0.9).uiColor.alpha(0.85).cgColor)
		c.setLineWidth(2)
		c.addPath(path)
		c.drawPath(using: .fillStroke)
	}
	// AetherCell
	override func aetherCell (path: CGPath) {
		let rgb = RGB(r: 0, g: 191, b: 255)
		let field = rgb.blend(rgb: RGB.white, percent: 0.6)
		let accent = rgb.blend(rgb: RGB.white, percent: 0.8)
		let c = UIGraphicsGetCurrentContext()!
		field.uiColor.alpha(0.7).setFill()
		accent.uiColor.setStroke()
		c.setLineWidth(2)
		c.addPath(path)
		c.drawPath(using: .fillStroke)
	}
	override func aetherCell (text: String, rect: CGRect) {
		let rgb = RGB(uiColor: UIColor.cyan)
		let accent = rgb.blend(rgb: RGB.white, percent: 0.9)
		let c = UIGraphicsGetCurrentContext()!
		c.saveGState()
		c.setShadow(offset: CGSize(width: 2, height: 2), blur: 2)
		let pen = Pen(font: UIFont(name: "HelveticaNeue", size: 14)!)
		pen.color = accent.uiColor
		pen.alignment = .center
		(text as NSString).draw(in: rect, withAttributes: pen.attributes)
		c.restoreGState()
	}
	override func wafer(text: String, x: CGFloat, y: CGFloat, uiColor: UIColor) -> CGFloat {
		let pen = Pen(font: UIFont(name: "HelveticaNeue", size: 16)!)
		let size: CGSize = (text as NSString).size(attributes: pen.attributes)
		let width: CGFloat = max(size.width, 9)
		let c = UIGraphicsGetCurrentContext()!

		let rect = CGRect(x: x+1, y: y+1, width: width+7, height: size.height-1)
		let path = CGPath(roundedRect: rect, cornerWidth: 8, cornerHeight: 8, transform: nil)
		c.setFillColor(uiColor.alpha(0.3).cgColor)
		c.setStrokeColor(uiColor.alpha(0.7).cgColor)
		c.setLineWidth(0.5)
		c.addPath(path)
		c.drawPath(using: .fillStroke)
		
		pen.color = UIColor.white
		(text as NSString).draw(at: CGPoint(x: x+5, y: y), withAttributes: pen.attributes)
		
		return width+9
	}
}
