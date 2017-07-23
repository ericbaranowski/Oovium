//
//  Bubble.swift
//  Oovium
//
//  Created by Joe Charlier on 4/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol Maker {
	func make (aether: Aether, at: V2) -> Bubble;
	func icon() -> UIImage;
}

class Bubble: UIView {
	var hitch: AEPoint
	
	init (hitch: AEPoint, origin: CGPoint, size: CGSize) {
		self.hitch = hitch
		
		var x: CGFloat = origin.x
		var y: CGFloat = origin.y
		
		if hitch.isRight() {x -= size.width}
		else if !hitch.isLeft() {x -= size.width/2}
		if hitch.isBottom() {y -= size.height}
		else if !hitch.isTop() { y -= size.height/2}
		
		super.init(frame: CGRect(x: x, y: y, width: size.width, height: size.height))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	func onCreate() {}
	func onRemove() {}
	func onSelect() {}
	func onUnselect() {}
	func onMove() {}
	func onUnload() {}
	
// Actions =========================================================================================
	func create() {
		onCreate()
	}
}
