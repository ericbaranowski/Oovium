//
//  AnchorStartGestureRecognizer.swift
//  Oovium
//
//  Created by Joe Charlier on 9/7/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class AnchorStart: UIGestureRecognizer {
	let aetherView: AetherView
	
	init(aetherView: AetherView) {
		self.aetherView = aetherView
		super.init(target: self.aetherView, action: #selector(AetherView.onAnchorStart))
	}
	
// UIGestureRecognizer =============================================================================
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
		guard !aetherView.anchored && touches.count == 1 && touches.first!.view == aetherView else {
			state = .failed
			return
		}
		
		state = .recognized
	}	
}
