//
//  Schematic.swift
//  Oovium
//
//  Created by Joe Charlier on 4/10/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class KeySlot {
	let row: CGFloat
	let col: CGFloat
	let w: CGFloat
	let h: CGFloat
	let key: Key
	
	init (row: CGFloat, col: CGFloat, w: CGFloat, h: CGFloat, key: Key) {
		self.row = row
		self.col = col
		self.w = w
		self.h = h
		self.key = key
	}
}

class Schematic {
	let rows: CGFloat
	let cols: CGFloat
	var keySlots = [KeySlot]()

	init (rows: CGFloat, cols: CGFloat) {
		self.rows = rows
		self.cols = cols
	}
	
	func add (row: CGFloat, col: CGFloat, w: CGFloat, h: CGFloat, key: Key) {
		keySlots.append(KeySlot(row: row, col: col, w: w, h: h, key: key))
	}
	func add (row: CGFloat, col: CGFloat, key: Key) {
		add(row: row, col: col, w: 1, h: 1, key: key)
	}
	
	func render(rect: CGRect) {
		let margin: CGFloat = floor(7*Oo.s)
		let bw: CGFloat = floor((rect.size.width - 2*margin) / CGFloat(cols))
		let bh: CGFloat = floor((rect.size.height - 2*margin) / CGFloat(rows))
		
		for keySlot in keySlots {
			keySlot.key.frame = CGRect(x: margin+keySlot.col*bw, y: margin+keySlot.row*bh, width: keySlot.w*bw, height: keySlot.h*bh)
			keySlot.key.font = UIFont(name: "Verdana", size: 14*Oo.s)!
		}
	}
	
}
