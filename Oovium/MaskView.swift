//
//  MaskView.swift
//  Oovium
//
//  Created by Joe Charlier on 8/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class MaskView: UIView {
	let content: UIView
	let path: CGPath
	
	init(frame: CGRect, content: UIView, path: CGPath) {
		self.content = content
		self.path = path

		super.init(frame: frame)

		self.content.frame = self.bounds
		addSubview(self.content)
		
		let mask = CAShapeLayer()
		mask.path = path
		mask.fillColor = UIColor.black.cgColor
		layer.mask = mask
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// UIView ==========================================================================================
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		return path.contains(point)
	}
}
