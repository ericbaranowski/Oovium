//
//  AnchorGestureRecognizer.swift
//  Oovium
//
//  Created by Joe Charlier on 9/7/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class AnchorStop: UIGestureRecognizer {
	let aetherView: AetherView
	var touch: UITouch? = nil
	
	init(aetherView: AetherView) {
		self.aetherView = aetherView
		super.init(target: self.aetherView, action: #selector(AetherView.onAnchorStop))
	}
	
// UIGestureRecognizer =============================================================================
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
		guard touch == nil else {return}
		guard let touch = touches.first, touch.view == view else {return}
		
		self.touch = touch
	}
//	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
//		guard let touch = touches.first, touch == self.touch else {return}
//
//		let current = touch.location(in: view)
//		let dx = current.x - start!.x
//		let dy = current.y - start!.y
//		let dSq = dx*dx+dy*dy
//		
//		guard dSq > 100 else {return}
//
//		state = .recognized
//		self.touch = nil
//	}
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
		guard let touch = touches.first, touch == self.touch else {return}

		state = .recognized
		self.touch = nil
	}
	override func reset() {
		self.touch = nil
	}
}
