//
//  TailBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class TailMaker: Maker {
	
	// Maker ===========================================================================================
	func icon() -> UIImage {
		return UIImage()
	}
	func make(aether: Aether, at: V2) -> Bubble {
		let tail = aether.createTail(at: at)
		return TailBub(tail)
	}
}

class TailBub: Bubble {
	let tail: Tail
	
	init(_ tail: Tail) {
		self.tail = tail
		super.init(hitch: .center, origin: CGPoint(x: self.tail.x, y: self.tail.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
