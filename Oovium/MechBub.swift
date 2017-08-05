//
//  MechBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class MechMaker: Maker {
	// Maker ===========================================================================================
	func icon() -> UIImage {
		return UIImage()
	}
	func make(aether: Aether, at: V2) -> Bubble {
		let mech = aether.createMech(at: at)
		return MechBub(mech)
	}
}

class MechBub: Bubble {
	let mech: Mech
	
	init(_ mech: Mech) {
		self.mech = mech
		super.init(hitch: .center, origin: CGPoint(x: self.mech.x, y: self.mech.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
