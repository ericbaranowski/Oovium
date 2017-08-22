//
//  AetherMenu.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class AetherMenu: KeyPad {
	init() {
		let schematic = Schematic(rows: 4, cols: 1)
		super.init(anchor: .bottomLeft, offset: UIOffset(horizontal: 78, vertical: 0), size: CGSize(width: 94, height: 214), fixedOffset: UIOffset(horizontal: 6, vertical: -6), schematic: schematic)
		
		schematic.add(row: 0, col: 0, key: Key(text: "clear", uiColor: UIColor.orange, {}))
		schematic.add(row: 1, col: 0, key: Key(text: "album", uiColor: UIColor.orange, {}))
		schematic.add(row: 2, col: 0, key: Key(text: "dropbox", uiColor: UIColor.orange, {}))
		schematic.add(row: 3, col: 0, key: Key(text: "logoff", uiColor: UIColor.orange, {}))
		
		self.schematic = schematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// Events ==========================================================================================
	override func onInvoke() {
		Hovers.dismissLinksMenu()
		Hovers.dismissHelpMenu()
	}
}
