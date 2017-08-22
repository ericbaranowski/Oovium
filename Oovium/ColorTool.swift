//
//  ColorTool.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ColorTool: Tool {
	let color: OOColor
	
	init(color: OOColor) {
		self.color = color
		super.init()
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		let c = UIGraphicsGetCurrentContext()!
		c.addPath(CGPath(roundedRect: rect.insetBy(dx: 10*Oo.s, dy: 10*Oo.s), cornerWidth: 5*Oo.s, cornerHeight: 5*Oo.s, transform: nil))
		color.uiColor.setFill()
		c.fillPath()
	}
}
