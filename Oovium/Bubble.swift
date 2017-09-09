//
//  Bubble.swift
//  Oovium
//
//  Created by Joe Charlier on 4/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol Maker {
	func make (aetherView: AetherView, at: V2) -> Bubble
	func drawIcon()
}

class Bubble: UIView, AnchorTappable {
	var hitch: Position
	var aetherView: AetherView?
	var leaves: [Leaf] = [Leaf]()
	
	var selected: Bool = false
	
	init (hitch: Position, origin: CGPoint, size: CGSize) {
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
	
	var context: Context {
		return Hovers.multiContext
	}
	var multiContext: Context {
		return Hovers.multiContext
	}
	
	func add(leaf: Leaf) {
		leaf.bubble = self
		leaves.append(leaf)
		addSubview(leaf)
	}
	
// Events ==========================================================================================
	func onCreate() {}
	func onRemove() {}
	func onSelect() {}
	func onUnselect() {}
	func onMove() {}
	func onUnload() {}
	
	func onAnchorTap() {}
	
// Actions =========================================================================================
	func create() {
		onCreate()
	}
	func select() {
		selected = true
		onSelect()
		setNeedsDisplay()
		for leaf in leaves {
			leaf.setNeedsDisplay()
		}
	}
	func unselect() {
		selected = false
		onUnselect()
		setNeedsDisplay()
		for leaf in leaves {
			leaf.setNeedsDisplay()
		}
	}
	
// UIView ==========================================================================================
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		let area = self.bounds.insetBy(dx: -20, dy: -20)
		return area.contains(point)
	}
}
