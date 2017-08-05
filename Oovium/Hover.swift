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
	
	init (anchor: Position, offset: UIOffset, size: CGSize) {
		
		var x: CGFloat
		var y: CGFloat
		
		let parent: CGSize = UIScreen.main.bounds.size
		let s = Hover.s
		
		if anchor.isLeft() {x = offset.horizontal*s}
		else if anchor.isRight() {x = parent.width - size.width*s + offset.horizontal*s}
		else {x = (parent.width - size.width*s) / 2 + offset.horizontal*s}
		
		if anchor.isTop() {y = offset.vertical*s}
		else if anchor.isBottom() {y = parent.height - size.height*s + offset.vertical*s}
		else {y = (parent.height - size.height*s) / 2 + offset.vertical*s}
		
		super.init(frame: CGRect(x: x, y: y, width: size.width*s, height: size.height*s))
		self.backgroundColor = UIColor.clear
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
	var isInvoked: Bool {
		return Hovers.isInvoked(hover: self)
	}

// Events ==========================================================================================
	func onFadeIn() {}
	func onInvoke() {}
	func onDismiss() {}
	
// Actions =========================================================================================
	func invoke() {
		Hovers.invoke(hover: self)
		onInvoke()
	}
	func dismiss() {
		Hovers.dismiss(hover: self)
		onDismiss()
	}
	func toggle() {
		if isInvoked {
			dismiss()
		} else {
			invoke()
		}
	}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let s = Hover.s
		let path = CGMutablePath()
		path.addRoundedRect(in: rect.insetBy(dx: 3*s, dy: 3*s), cornerWidth: 10*s, cornerHeight: 10*s)
		Skin.panel(path: path, uiColor: UIColor.orange)
	}
}
