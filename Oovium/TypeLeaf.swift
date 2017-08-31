//
//  TypeLeaf.swift
//  Oovium
//
//  Created by Joe Charlier on 8/29/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class TypeLeaf: Leaf {

	override init() {
		super.init()
		
		self.backgroundColor = UIColor.clear
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let path = CGPath(roundedRect: rect.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
		Skin.bubble(path: path, uiColor: OOColor.lavender.uiColor, width: 4.0/3.0*Oo.s)
	}
}
