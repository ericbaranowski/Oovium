//
//  Hover.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class Hover: UIView {
	let anchor: Position
	let offset: UIOffset
	let size: CGSize
	let fixedOffset: UIOffset
	
	init (anchor: Position, offset: UIOffset, size: CGSize, fixedOffset: UIOffset) {
		self.anchor = anchor
		self.offset = offset
		self.size = size
		self.fixedOffset = fixedOffset
		
		super.init(frame: CGRect.zero)
		
		backgroundColor = UIColor.clear
		render()
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
	
	func render() {
		var x: CGFloat
		var y: CGFloat
		
		let parent: CGSize = UIScreen.main.bounds.size
		
		let offsetX: CGFloat = offset.horizontal*Oo.s + fixedOffset.horizontal
		let offsetY: CGFloat = offset.vertical*Oo.s + fixedOffset.vertical
		
		if anchor.isLeft() {x = offsetX}
		else if anchor.isRight() {x = parent.width - size.width*Oo.s + offsetX}
		else {x = (parent.width - size.width*Oo.s) / 2 + offsetX}
		
		if anchor.isTop() {y = offsetY}
		else if anchor.isBottom() {y = parent.height - size.height*Oo.s + offsetY}
		else {y = (parent.height - size.height*Oo.s) / 2 + offsetY}

		self.frame = CGRect(x: x, y: y, width: size.width*Oo.s, height: size.height*Oo.s)
	}
}
