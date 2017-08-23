//
//  Tool.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class Tool: UIView {
	var toolBar: ToolBar!
	
	init() {
		super.init(frame: CGRect.zero)
		backgroundColor = UIColor.clear
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
		addGestureRecognizer(gesture)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
	func render() {}
	func rescale() {}
	
// Events ==========================================================================================
	func onTap() {
		toolBar.select(tool: self)
	}
	func onSelect() {}
	func onDeselect() {}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let path = CGPath(roundedRect: rect.insetBy(dx: 2*Oo.s, dy: 2*Oo.s), cornerWidth: 6*Oo.s, cornerHeight: 6*Oo.s, transform: nil)
		
		let c = UIGraphicsGetCurrentContext()!
		c.setFillColor(UIColor.black.alpha(0.7).cgColor)
		c.setStrokeColor(UIColor.white.cgColor)
		c.setLineWidth(4.0/3.0*Oo.s)
		c.addPath(path)
		c.drawPath(using: .fillStroke)
	}
}
