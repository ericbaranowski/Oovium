//
//  TutorialsMenu.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class TutorialsMenu: KeyPad {
	init() {
		let schematic = Schematic(rows: 3, cols: 1)
		super.init(anchor: .bottomLeft, offset: UIOffset(horizontal: 192, vertical: 0), size: CGSize(width: 105, height: 214), fixedOffset: UIOffset(horizontal: 6, vertical: -6), schematic: schematic)
		
		schematic.add(row: 0, col: 0, key: Key(text: "basics", uiColor: UIColor.orange, {}))
		schematic.add(row: 1, col: 0, key: Key(text: "mapper", uiColor: UIColor.orange, {}))
		schematic.add(row: 2, col: 0, key: Key(text: "cancel", uiColor: UIColor.orange, {}))
		
		self.schematic = schematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
