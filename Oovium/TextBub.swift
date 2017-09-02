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
	func make(aetherView: AetherView, at: V2) -> Bubble {
		let text = aetherView.aether.createText(at: at)
		text.shape = aetherView.shape
		text.color = aetherView.color
		return TextBub(text)
	}
	func drawIcon() {
		OOShape.ellipse.shape.drawIcon(color: UIColor.orange)
	}
}

class TextBub: Bubble {
	let text: Text
	let textLeaf: TextLeaf
	
	init(_ text: Text) {
		self.text = text		
		textLeaf = TextLeaf(text: text)
		
		super.init(hitch: .center, origin: CGPoint(x: self.text.x, y: self.text.y), size: CGSize(width: 36, height: 36))
		
		textLeaf.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
		addSubview(textLeaf)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
}
