//
//  TextLeaf.swift
//  Oovium
//
//  Created by Joe Charlier on 8/28/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol TextLeafDelegate: class {
	var uiColor: UIColor {get}
}

class TextLeaf: Leaf {
	unowned let delegate: TextLeafDelegate
	
	init(delegate: TextLeafDelegate) {
		self.delegate = delegate
		super.init()
		
		self.backgroundColor = UIColor.clear
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let path = CGPath(roundedRect: rect.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
		Skin.bubble(path: path, uiColor: delegate.uiColor, width: 4.0/3.0*Oo.s)
	}	
}
