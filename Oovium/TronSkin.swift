//
//  TronSkin.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class TronSkin: Skin {
	let pen = Pen(font: UIFont(name: "HelveticaNeue", size: 16)!)
	
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
	override func panel(text: String, rect: CGRect, pen: Pen) {
		pen.color = RGB.shade(color: pen.color, percent: 0.7)
		let c = UIGraphicsGetCurrentContext()!
		c.saveGState()
		c.setShadow(offset: CGSize(width: 2, height: 2), blur: 2)
		(text as NSString).draw(in: rect, withAttributes: pen.attributes)
		c.restoreGState()
	}
	
	// Key
	override func key (path: CGPath, uiColor: UIColor) {
		let rgb = RGB(uiColor: uiColor)
		let field = rgb.blend(rgb: RGB.white, percent: 0.25)
		let accent = rgb.blend(rgb: RGB.black, percent: 0.5)
		
		let c = UIGraphicsGetCurrentContext()!
		c.setFillColor(field.cgColor)
		c.setStrokeColor(accent.cgColor)
		c.setLineWidth(2/3*Oo.s)
		c.addPath(path)
		c.drawPath(using: .fillStroke)
	}
	override func key (text: String, rect: CGRect, font: UIFont) {
		let pen = Pen(font: font)
		pen.color = UIColor.black
		let size = (text as NSString).size(attributes: pen.attributes)
		let c = UIGraphicsGetCurrentContext()!
		c.saveGState()
		c.setShadow(offset: CGSize(width: 2, height: 2), blur: 2)
		let inside = CGRect(x: rect.origin.x+(rect.size.width-size.width)/2, y: rect.origin.y+(rect.size.height-size.height)/2, width: size.width, height: size.height)
		(text as NSString).draw(in: inside, withAttributes: pen.attributes)
		c.restoreGState()
	}
	
	// Bubble
	override func bubble (path: CGPath, uiColor: UIColor, width: CGFloat) {
		let c = UIGraphicsGetCurrentContext()!
		
		c.setFillColor(UIColor.black.withAlphaComponent(0.7).cgColor)
		c.addPath(path)
		c.drawPath(using: .fill)
		
		c.setStrokeColor(uiColor.withAlphaComponent(0.4).cgColor)
		c.setLineWidth(width*3)
		c.addPath(path)
		c.drawPath(using: .stroke)

		c.setStrokeColor(uiColor.withAlphaComponent(0.6).cgColor)
		c.setLineWidth(width*2)
		c.addPath(path)
		c.drawPath(using: .stroke)

		c.setStrokeColor(UIColor.white.cgColor)
		c.setLineWidth(width)
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
	// Shape
	override func shape(text: String, rect: CGRect, uiColor: UIColor) {
		let pen = self.pen.copy()
		pen.alignment = .center
		pen.style.lineBreakMode = .byWordWrapping
		
		var size = (text as NSString).size(attributes: pen.attributes)
		if text.components(separatedBy: " ").count > 1 {
			while size.width > size.height*4 {
				size = (text as NSString).boundingRect(with: CGSize(width: size.width*0.7, height: 2000), options: [.usesLineFragmentOrigin], attributes: pen.attributes, context: nil).size
			}
		}
		
		let textRect = CGRect(x: (rect.size.width-size.width)/2, y: (rect.size.height-size.height)/2-1, width: size.width+0.5, height: size.height+0.5)

		pen.color = uiColor.alpha(0.4)
		(text as NSString).draw(in: textRect.offsetBy(dx: 1, dy: 1), withAttributes: pen.attributes)
		(text as NSString).draw(in: textRect.offsetBy(dx: -1, dy: -1), withAttributes: pen.attributes)
		
		pen.color = UIColor.white
		(text as NSString).draw(in: textRect, withAttributes: pen.attributes)
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
		c.setLineWidth(4/3*Oo.s)
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
		c.setLineWidth(4.0/3.0*Oo.s)
		c.addPath(path)
		c.drawPath(using: .fillStroke)
	}
	override func aetherCell (text: String, rect: CGRect) {
		let rgb = RGB(uiColor: UIColor.cyan)
		let accent = rgb.blend(rgb: RGB.white, percent: 0.9)
		let c = UIGraphicsGetCurrentContext()!
		c.saveGState()
		c.setShadow(offset: CGSize(width: 2, height: 2), blur: 2)
		let pen = Pen(font: UIFont(name: "HelveticaNeue", size: 14*Oo.s)!)
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
	// Color
	override func color(_ skinColor: SkinColor) -> UIColor {
		switch skinColor {
			case .labelBack:	return UIColor(red: 0, green: 0.3, blue: 0, alpha: 0.5)
			case .ovalBack:		return UIColor.black.alpha(0.3)
			case .currentCell:	return UIColor.purple
			default:			return UIColor.white
		}
	}
}
