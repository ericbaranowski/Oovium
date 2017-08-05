//
//  Tool.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class Tool: UIView {
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let path = CGPath(roundedRect: rect.insetBy(dx: 3, dy: 3), cornerWidth: 6, cornerHeight: 6, transform: nil)
		
		let c = UIGraphicsGetCurrentContext()!
		c.setFillColor(UIColor.black.alpha(0.7).cgColor)
		c.addPath(path)
		c.drawPath(using: .fillStroke)
	}
}
