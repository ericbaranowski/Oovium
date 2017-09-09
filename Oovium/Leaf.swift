//
//  Leaf.swift
//  Oovium
//
//  Created by Joe Charlier on 4/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol Citable {
}

protocol Editable {
	func edit()
	func ok()
	func cite(_ citable: Citable)
}

class Leaf: UIView {
	var hitch: Position = .center
	var bubble: Bubble!
	
	init() {
		super.init(frame: CGRect.zero)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// UIView ==========================================================================================
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		let area = self.bounds.insetBy(dx: -20, dy: -20)
		return area.contains(point)
	}
}
