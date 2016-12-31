//
//  Strand.swift
//  Oovium
//
//  Created by Joe Charlier on 12/27/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Strand {
	let head: Tower
	let tail: Tower
	var strong: Bool
	
	init (head: Tower, tail: Tower, strong: Bool) {
		self.head = head
		self.tail = tail
		self.strong = strong
	}
}
