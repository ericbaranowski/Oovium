//
//  AutoBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class AutoMaker: Maker {
	
	// Maker ===========================================================================================
	func make(aetherView: AetherView, at: V2) -> Bubble {
		let auto = aetherView.aether.createAuto(at: at)
		return AutoBub(auto)
	}
	func drawIcon() {
	}
}

class AutoBub: Bubble {
	let auto: Auto
	
	init(_ auto: Auto) {
		self.auto = auto
		super.init(hitch: .center, origin: CGPoint(x: self.auto.x, y: self.auto.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
