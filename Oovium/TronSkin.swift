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
}
