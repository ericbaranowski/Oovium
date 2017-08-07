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
		let p: CGFloat = 8
		let q: CGFloat = 13
		let w: CGFloat = 40-2*p
		let h: CGFloat = 40-2*q
		
		let x1 = p
		let y1 = q
		
		let path = CGPath(rect: CGRect(x: x1, y: y1, width: w, height: h), transform: nil)
		Skin.bubble(path: path, uiColor: color)
	}
}
