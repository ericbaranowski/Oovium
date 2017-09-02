//
//  MiruBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

import UIKit

class MiruMaker: Maker {
	
	// Maker ===========================================================================================
	func make(aetherView: AetherView, at: V2) -> Bubble {
		let miru = aetherView.aether.createMiru(at: at)
		return MiruBub(miru)
	}
	func drawIcon() {
	}
}

class MiruBub: Bubble {
	let miru: Miru
	
	init(_ miru: Miru) {
		self.miru = miru
		super.init(hitch: .center, origin: CGPoint(x: self.miru.x, y: self.miru.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
