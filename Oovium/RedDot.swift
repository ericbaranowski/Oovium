//
//  RedDot.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class RedDot: Hover, UIGestureRecognizerDelegate {
	init() {
		super.init(anchor: .bottomLeft, offset: UIOffset.zero, size: CGSize(width: 46, height: 46), fixedOffset: UIOffset.zero)

		var gesture: UIGestureRecognizer = AETouchGestureRecognizer(target: self, action: #selector(onTouch))
		gesture.delegate = self
		addGestureRecognizer(gesture)
		
		gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
		gesture.delegate = self
		addGestureRecognizer(gesture)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
	func fade() {
		alpha = 1
		UIView.animate(withDuration: 0.5, delay: 2, options: [.allowUserInteraction], animations: {
			self.alpha = 0.5
		}, completion: nil)
	}
	
// Hover ===========================================================================================
	func onTouch() {
		fade()
	}
	func onTap() {
		Hovers.toggleRootMenu()
		superview?.bringSubview(toFront: self)
	}
	override func onFadeIn() {
		fade()
	}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let rect = CGRect(x: 13*Oo.s, y: 13*Oo.s, width: 20*Oo.s, height: 20*Oo.s)
		let path = CGPath(roundedRect: rect, cornerWidth: 10*Oo.s, cornerHeight: 10*Oo.s, transform: nil)
		let c = UIGraphicsGetCurrentContext()!
		
		c.setStrokeColor(UIColor.red.withAlphaComponent(0.3).cgColor)
		c.setLineWidth(6)
		c.addPath(path)
		c.drawPath(using: .stroke)
		
		c.setStrokeColor(UIColor.red.withAlphaComponent(0.6).cgColor)
		c.setLineWidth(4)
		c.addPath(path)
		c.drawPath(using: .stroke)
		
		c.setFillColor(UIColor.red.cgColor)
		c.setLineWidth(2)
		c.addPath(path)
		c.drawPath(using: .fill)
		
		c.setStrokeColor(UIColor.white.withAlphaComponent(0.07).cgColor)
		c.addPath(path)
		c.drawPath(using: .stroke)
	}
	
// UIGestureRecognizerDelegate =====================================================================
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
