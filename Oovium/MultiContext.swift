//
//  MultiContext.swift
//  Oovium
//
//  Created by Joe Charlier on 9/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

class MultiContext: Context {
	init() {
		super.init(schematic: Schematic(rows: 1, cols: 1))
		
		self.schematic.add(row: 0, col: 0, key: Key(text: NSLocalizedString("delete", comment: ""), uiColor: UIColor(red: 0.6, green: 0.7, blue: 0.8, alpha: 1), {}))

		self.schematic = schematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
