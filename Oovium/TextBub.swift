//
//  TextBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class TextMaker: Maker {
	
	// Maker ===========================================================================================
	func icon() -> UIImage {
		return UIImage()
	}
	func make(aether: Aether, at: V2) -> Bubble {
		let text = aether.createText(at: at)
		return TextBub(text)
	}
}

class TextBub: Bubble {
	let text: Text
	
	init(_ text: Text) {
		self.text = text
		super.init(hitch: .center, origin: CGPoint(x: self.text.x, y: self.text.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
