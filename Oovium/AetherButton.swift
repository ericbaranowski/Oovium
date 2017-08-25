//
//  PathButton.swift
//  Oovium
//
//  Created by Joe Charlier on 8/23/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class AetherButton: UIButton {
	var path: CGPath {
		didSet {setNeedsDisplay()}
	}
	
	init(frame: CGRect, path: CGPath) {
		self.path = path
		super.init(frame: frame)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// UIView ==========================================================================================
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		return path.contains(point) ? super.hitTest(point, with: event) : nil
	}
	override func draw(_ rect: CGRect) {
		Skin.aetherPicker(path: path)
	
		let p: CGFloat = 2*Oo.s
		let q: CGFloat = 13*Oo.s
		let sp: CGFloat = 4*Oo.s
		let bw: CGFloat = 60*Oo.s
		let sq: CGFloat = sp*sqrt(2)
		let r: CGFloat = q-sp/2
		
		let x1 = p		
		let x8 = x1+sq
		let x9 = x8+r
		let x11 = x9+bw
		let x13 = x11+bw
		
		let y1 = p
		let y6 = y1+r
		let y7 = y6+r

		let pen: Pen = Pen(font: UIFont(name: "HelveticaNeue", size: 14*Oo.s)!)
		pen.alignment = .center		
		pen.color = UIColor.green
		Skin.panel(text: Oovium.aetherView.aether.name, rect: CGRect(x: x9, y: y1+2*Oo.s-0.5, width: x13-x9, height: y7-y1), pen: pen)

	}
}
