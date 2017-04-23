//
//  KeyPad.swift
//  Oovium
//
//  Created by Joe Charlier on 4/10/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class KeyPad: Hover {
	private var _schematic: Schematic = Schematic(rows: 1, cols: 1)
	var schematic: Schematic {
		set {
			_schematic = newValue
			renderSchematic()
		}
		get {return _schematic}
	}
	
	init (size: CGSize) {
		super.init(anchor: .bottomRight, offset: UIOffset(horizontal: -7, vertical: -7), size: size)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

	private func renderSchematic() {
		let s = Hover.s
		let margin = 7*s
		let bw: CGFloat = (frame.size.width - 2*margin) / CGFloat(schematic.cols)
		let bh: CGFloat = (frame.size.height - 2*margin) / CGFloat(schematic.rows)
		
		for keySlot in schematic.keySlots {
			keySlot.key.frame = CGRect(x: margin+keySlot.col*bw, y: margin+keySlot.row*bh, width: keySlot.w*bw, height: keySlot.h*bh)
			addSubview(keySlot.key)
		}
	}
}
