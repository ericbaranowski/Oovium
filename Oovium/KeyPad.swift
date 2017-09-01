//
//  KeyPad.swift
//  Oovium
//
//  Created by Joe Charlier on 4/10/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class KeyPad: Hover {
	let uiColor: UIColor
	var schematic: Schematic {
		didSet {renderSchematic()}
	}
	
	init (anchor: Position, offset: UIOffset, size: CGSize, fixedOffset: UIOffset, uiColor: UIColor, schematic: Schematic) {
		self.uiColor = uiColor
		self.schematic = schematic
		super.init(anchor: anchor, offset: offset, size: size, fixedOffset: fixedOffset)
	}
	init (anchor: Position, offset: UIOffset, size: CGSize, fixedOffset: UIOffset, schematic: Schematic) {
		self.uiColor = UIColor.orange
		self.schematic = schematic
		super.init(anchor: anchor, offset: offset, size: size, fixedOffset: fixedOffset)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

	private func renderSchematic() {
		for view in subviews {
			view.removeFromSuperview()
		}
		
		schematic.render(rect: bounds)
		
		for keySlot in schematic.keySlots {
			addSubview(keySlot.key)
		}
	}
	
// Hover ===========================================================================================
	override func rescale() {
		super.rescale()
		renderSchematic()
	}

// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let path = CGMutablePath()
		path.addRoundedRect(in: rect.insetBy(dx: 2*Oo.s, dy: 2*Oo.s), cornerWidth: 10*Oo.s, cornerHeight: 10*Oo.s)
		Skin.bubble(path: path, uiColor: uiColor, width: 4/3*Oo.s)
	}
}
