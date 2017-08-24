//
//  PathButton.swift
//  Oovium
//
//  Created by Joe Charlier on 8/23/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class PathButton: UIButton {
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
	}
}
