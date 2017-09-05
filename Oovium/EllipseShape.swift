//
//  EllipseShape.swift
//  Oovium
//
//  Created by Joe Charlier on 8/7/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class EllipseShape: Shape {
// Shape ===========================================================================================
	override func drawIcon(color: UIColor) {
		let p: CGFloat = 8*Oo.s
		let q: CGFloat = 13*Oo.s
		let w: CGFloat = 40*Oo.s-2*p
		let h: CGFloat = 40*Oo.s-2*q
		
		let x1 = p
		let y1 = q

		let path = CGMutablePath()
		path.addEllipse(in: CGRect(x: x1, y: y1, width: w, height: h))
		Skin.bubble(path: path, uiColor: color, width: 2*Oo.s)
	}
	override func bounds(size: CGSize) -> CGRect {
		return CGRect(x: 0, y: 0, width: max(size.width*1.5, 90), height: size.height*1.2+16)
	}
	override func draw(rect: CGRect, uiColor: UIColor) {
		let path = CGMutablePath()
		path.addEllipse(in: rect.insetBy(dx: 3, dy: 3))
		Skin.bubble(path: path, uiColor: uiColor, width: 4/3*Oo.s)
	}
}
