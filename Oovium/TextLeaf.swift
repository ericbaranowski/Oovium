//
//  TextLeaf.swift
//  Oovium
//
//  Created by Joe Charlier on 8/28/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class TextLeaf: Leaf {
	var text: Text
	
	init(text: Text) {
		self.text = text
		
		super.init()
		
		self.backgroundColor = UIColor.clear
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		text.shape.shape.draw(rect: rect, uiColor: text.color.uiColor)
	}
}
