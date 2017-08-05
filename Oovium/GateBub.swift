//
//  GateBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class GateMaker: Maker {
// Maker ===========================================================================================
	func icon() -> UIImage {
		return UIImage()
	}
	func make(aether: Aether, at: V2) -> Bubble {
		let gate = aether.createGate(at: at)
		return GateBub(gate)
	}
}

class GateBub: Bubble {
	let gate: Gate
	
	init(_ gate: Gate) {
		self.gate = gate
		super.init(hitch: .center, origin: CGPoint(x: self.gate.x, y: self.gate.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
