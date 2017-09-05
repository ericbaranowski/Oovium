//
//  RectangleShape.swift
//  Oovium
//
//  Created by Joe Charlier on 8/7/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class RectangleShape: Shape {
// Shape ===========================================================================================
	override func drawIcon(color: UIColor) {
		let p: CGFloat = 8*Oo.s
		let q: CGFloat = 13*Oo.s
		let w: CGFloat = 40*Oo.s-2*p
		let h: CGFloat = 40*Oo.s-2*q
		
		let x1 = p
		let y1 = q
		
		let path = CGPath(rect: CGRect(x: x1, y: y1, width: w, height: h), transform: nil)
		Skin.bubble(path: path, uiColor: color, width: 4.0/3.0*Oo.s)
	}
	override func bounds(size: CGSize) -> CGRect {
		return CGRect(x: 0, y: 0, width: size.width+30, height: size.height+20)
	}
	override func draw(rect: CGRect, uiColor: UIColor) {
		let path = CGPath(rect: rect.insetBy(dx: 3, dy: 3), transform: nil)
		Skin.bubble(path: path, uiColor: uiColor, width: 4/3*Oo.s)
	}
}
