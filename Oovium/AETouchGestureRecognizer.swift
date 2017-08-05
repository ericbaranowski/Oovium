//
//  AETouchGestureRecognizer.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class AETouchGestureRecognizer: UIGestureRecognizer {

// UIGestureRecognizer =============================================================================
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
		if state == .possible {
			state = .recognized
		}
	}
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
		state = .failed
	}
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
		state = .failed
	}
}
