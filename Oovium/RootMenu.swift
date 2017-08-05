//
//  RootMenu.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class RootMenu: KeyPad {
	init() {
		let schematic = Schematic(rows: 3, cols: 1)
		super.init(anchor: .bottomLeft, offset: UIOffset(horizontal: 6, vertical: -46), size: CGSize(width: 78, height: 220), schematic: schematic)
		
		schematic.add(row: 0, col: 0, key: Key(text: "aether", uiColor: UIColor.orange, {Hovers.toggleAetherMenu()}))
		schematic.add(row: 1, col: 0, key: Key(text: "links", uiColor: UIColor.orange, {Hovers.toggleLinksMenu()}))
		schematic.add(row: 2, col: 0, key: Key(text: "help", uiColor: UIColor.orange, {Hovers.toggleHelpMenu()}))
		
		self.schematic = schematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// Events ==========================================================================================
	override func onDismiss() {
		Hovers.dismissAetherMenu()
		Hovers.dismissLinksMenu()
		Hovers.dismissHelpMenu()
	}
}
