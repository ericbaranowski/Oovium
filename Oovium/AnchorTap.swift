//
//  AnchorTap.swift
//  Oovium
//
//  Created by Joe Charlier on 9/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol AnchorTappable {
	func onAnchorTap()
}

class AnchorTap: UITapGestureRecognizer {
	let aetherView: AetherView
	var anchorTappable: AnchorTappable? = nil
	
	init(aetherView: AetherView) {
		self.aetherView = aetherView
		super.init(target: nil, action: nil)
		addTarget(self, action: #selector(onTap))
	}

// Events ==========================================================================================
	func onTap() {
		anchorTappable!.onAnchorTap()
	}
	
// UIGestureRecognizer =============================================================================
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
		guard aetherView.anchored && touches.count == 1 && touches.first!.view != aetherView else {
			state = .failed
			return
		}
		
		var view: UIView? = touches.first!.view
		while view != nil && !(view is AnchorTappable) {
			view = view?.superview
		}
		
		if view != nil {
			anchorTappable = view as? AnchorTappable
			super.touchesBegan(touches, with: event)
		} else {
			state = .failed
		}		
	}

	override func reset() {
		anchorTappable = nil
	}
}
