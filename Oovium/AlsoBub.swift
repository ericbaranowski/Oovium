//
//  AlsoBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class AlsoMaker: Maker {
	
	// Maker ===========================================================================================
	func drawIcon() {
	}
	func make(aetherView: AetherView, at: V2) -> Bubble {
		let also = aetherView.aether.createAlso(at: at)
		return AlsoBub(also)
	}
}

class AlsoBub: Bubble {
	let also: Also
	
	init(_ also: Also) {
		self.also = also
		super.init(hitch: .center, origin: CGPoint(x: self.also.x, y: self.also.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
