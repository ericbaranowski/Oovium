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
		super.init(anchor: .center, offset: UIOffset.zero, size: CGSize(width: 200, height: 200), fixedOffset: UIOffset.zero)
		super.render()
		
		scaleView.frame = CGRect(x: 50, y: 50, width: 200, height: 100)
		scaleView.onChange = {(scale: CGFloat) in
			Oo.s = scale
			Hovers.rescale()
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
	override func rescale() {}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let path = CGMutablePath()
		path.addRoundedRect(in: rect.insetBy(dx: 2*Oo.s, dy: 2*Oo.s), cornerWidth: 6*Oo.s, cornerHeight: 6*Oo.s)
		Skin.bubble(path: path, uiColor: OOColor.marine.uiColor, width: 4.0/3.0*Oo.s)
	}
}
