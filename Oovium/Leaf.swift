//
//  Leaf.swift
//  Oovium
//
//  Created by Joe Charlier on 4/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class Leaf: UIView {
	var hitch: Position = .center
	
	init() {
		super.init(frame: CGRect.zero)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// UIView ==========================================================================================
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		let area = self.bounds.insetBy(dx: -16, dy: -16)
		return area.contains(point)
	}
}
