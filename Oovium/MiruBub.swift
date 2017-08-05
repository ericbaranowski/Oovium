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
	func icon() -> UIImage {
		return UIImage()
	}
	func make(aether: Aether, at: V2) -> Bubble {
		let miru = aether.createMiru(at: at)
		return MiruBub(miru)
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
