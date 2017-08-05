//
//  LinksMenu.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class LinksMenu: KeyPad {
	init() {
		let schematic = Schematic(rows: 4, cols: 1)
		super.init(anchor: .bottomLeft, offset: UIOffset(horizontal: 84, vertical: -6), size: CGSize(width: 104, height: 214), schematic: schematic)
		
		schematic.add(row: 0, col: 0, key: Key(text: "oovium", uiColor: UIColor.orange, {}))
		schematic.add(row: 1, col: 0, key: Key(text: "forums", uiColor: UIColor.orange, {}))
		schematic.add(row: 2, col: 0, key: Key(text: "twitter", uiColor: UIColor.orange, {}))
		schematic.add(row: 3, col: 0, key: Key(text: "review", uiColor: UIColor.orange, {}))
		
		self.schematic = schematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// Events ==========================================================================================
	override func onInvoke() {
		Hovers.dismissAetherMenu()
		Hovers.dismissHelpMenu()
	}
}
