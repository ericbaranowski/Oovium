//
//  Key.swift
//  Oovium
//
//  Created by Joe Charlier on 4/10/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class Key: UIControl {
	let text: String
	let uiColor: UIColor
	let font: UIFont
	
	private var current: UIColor
	
	init (text: String, uiColor: UIColor, font: UIFont, _ closure: @escaping()->()) {
		self.text = text
		self.uiColor = uiColor
		self.font = font
		self.current = self.uiColor
		super.init(frame: .zero)
		add(for: .touchUpInside) {
			closure()
		}
		backgroundColor = UIColor.clear
	}
	convenience init (text: String, uiColor: UIColor, _ closure: @escaping()->()) {
		self.init(text: text, uiColor: uiColor, font: UIFont(name: "Verdana", size: 14*Oo.s)!, closure)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	func onTouchDown() {
	}
	func onTouchUp() {
	}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let s = Hover.s
		let path = CGPath(roundedRect: rect.insetBy(dx: 3*s, dy: 3*s), cornerWidth: 7*s, cornerHeight: 7*s, transform: nil)
		Skin.key(path: path, uiColor: current)
		Skin.key(text: text, rect: rect, font: font)
	}
	override var isHighlighted: Bool {
		didSet {
			current = isHighlighted ? UIColor.red : uiColor
			setNeedsDisplay()
		}
	}
}
