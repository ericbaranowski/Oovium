//
//  HelpMenu.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class HelpMenu: KeyPad {
	init() {
		let schematic = Schematic(rows: 5, cols: 1)
		super.init(anchor: .bottomLeft, offset: UIOffset(horizontal: 84, vertical: -6), size: CGSize(width: 114, height: 214), schematic: schematic)
		
		schematic.add(row: 0, col: 0, key: Key(text: "about", uiColor: UIColor.orange, {}))
		schematic.add(row: 1, col: 0, key: Key(text: "what's new", uiColor: UIColor.orange, {}))
		schematic.add(row: 2, col: 0, key: Key(text: "oovium", uiColor: UIColor.orange, {}))
		schematic.add(row: 3, col: 0, key: Key(text: "anchoring", uiColor: UIColor.orange, {}))
		schematic.add(row: 4, col: 0, key: Key(text: "tutorial", uiColor: UIColor.orange, {Hovers.toggleTutorialsMenu()}))
		
		self.schematic = schematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	override func onInvoke() {
		Hovers.dismissAetherMenu()
		Hovers.dismissLinksMenu()
	}
	override func onDismiss() {
		Hovers.dismissTutorialsMenu()
	}
}
