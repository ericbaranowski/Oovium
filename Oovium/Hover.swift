//
//  Hover.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class Hover: UIView {
	static var s: CGFloat = 1
	
	init (anchor: AEPoint, offset: UIOffset, size: CGSize) {
		
		var x: CGFloat
		var y: CGFloat
		
		let parent: CGSize = UIScreen.main.bounds.size
		
		if anchor.isLeft() {x = offset.horizontal * Hover.s}
		else if anchor.isRight() {x = parent.width - size.width + offset.horizontal}
		else {x = (parent.width - size.width) / 2 + offset.horizontal}
		
		if anchor.isTop() {y = offset.vertical}
		else if anchor.isBottom() {y = parent.height - size.height + offset.vertical}
		else {y = (parent.height - size.height) / 2 + offset.vertical}
		
		super.init(frame: CGRect(x: x, y: y, width: size.width, height: size.height))
		self.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// Events ==========================================================================================
	
// Actions =========================================================================================
	func invoke () {
		Hovers.invoke(hover: self)
	}
	func dismiss () {}
	func toggle () {}
}
