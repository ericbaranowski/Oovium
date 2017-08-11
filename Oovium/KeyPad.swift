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
	
	init (anchor: Position, offset: UIOffset, size: CGSize, uiColor: UIColor, schematic: Schematic) {
		self.uiColor = uiColor
		self.schematic = schematic
		super.init(anchor: anchor, offset: offset, size: size)
	}
	init (anchor: Position, offset: UIOffset, size: CGSize, schematic: Schematic) {
		self.uiColor = UIColor.orange
		self.schematic = schematic
		super.init(anchor: anchor, offset: offset, size: size)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

	private func renderSchematic() {
		for view in subviews {
			view.removeFromSuperview()
		}
		
		let margin: CGFloat = 6
		let bw: CGFloat = (frame.size.width - 2*margin) / CGFloat(schematic.cols)
		let bh: CGFloat = (frame.size.height - 2*margin) / CGFloat(schematic.rows)
		
		for keySlot in schematic.keySlots {
			keySlot.key.frame = CGRect(x: margin+keySlot.col*bw, y: margin+keySlot.row*bh, width: keySlot.w*bw, height: keySlot.h*bh)
			addSubview(keySlot.key)
		}
	}

// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let s = Hover.s
		let path = CGMutablePath()
		path.addRoundedRect(in: rect.insetBy(dx: 3*s, dy: 3*s), cornerWidth: 10*s, cornerHeight: 10*s)
		Skin.panel(path: path, uiColor: uiColor)
	}
}
