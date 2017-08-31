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
	func make(aether: Aether, at: V2) -> Bubble {
		let text = aether.createText(at: at)
		return TextBub(text)
	}
	func drawIcon() {
		OOShape.ellipse.shape.drawIcon(color: UIColor.orange)
	}
}

class TextBub: Bubble, TextLeafDelegate {
	let text: Text
	
	lazy var textLeaf: TextLeaf = {TextLeaf(delegate: self)}()
	
	init(_ text: Text) {
		self.text = text
		
		super.init(hitch: .center, origin: CGPoint(x: self.text.x, y: self.text.y), size: CGSize(width: 36, height: 36))
		
		textLeaf.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
		addSubview(textLeaf)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// TextLeafDelegate ================================================================================
	var uiColor: UIColor {
		return text.color.uiColor
	}
}
