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
}
