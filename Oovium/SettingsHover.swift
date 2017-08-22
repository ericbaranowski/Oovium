//
//  SettingsHover.swift
//  Oovium
//
//  Created by Joe Charlier on 8/20/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class SettingsHover: Hover {
	
	let scaleView = ScaleView()
	
	init() {
		super.init(anchor: .center, offset: UIOffset.zero, size: CGSize(width: 300, height: 300), fixedOffset: UIOffset.zero)
		super.render()
		
		scaleView.frame = CGRect(x: 50, y: 50, width: 200, height: 100)
		scaleView.onChange = {(scale: CGFloat) in
			Oo.s = scale
			Hovers.render()
		}
		addSubview(scaleView)
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
		addGestureRecognizer(gesture)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// Events ==========================================================================================
	func onTap() {
		dismiss()
	}
	
// Hover ===========================================================================================
	override func render() {
	}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let path = CGMutablePath()
		path.addRoundedRect(in: rect.insetBy(dx: 3*Oo.s, dy: 3*Oo.s), cornerWidth: 10*Oo.s, cornerHeight: 10*Oo.s)
		Skin.bubble(path: path, uiColor: OOColor.marine.uiColor)
	}
}
