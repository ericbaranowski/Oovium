//
//  Spider.swift
//  Oovium
//
//  Created by Joe Charlier on 5/21/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

class Spider {
	let memory: UnsafeMutablePointer<Memory>
	let needed: Set<Tower>
	
	init(memory: UnsafeMutablePointer<Memory>, needed: Set<Tower>) {
		self.memory = memory
		self.needed = needed
	}
}
