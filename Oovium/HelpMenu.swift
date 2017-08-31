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
		let schematic = Schematic(rows: 4, cols: 1)
		super.init(anchor: .bottomLeft, offset: UIOffset(horizontal: 78+6, vertical: -6), size: CGSize(width: 114, height: 214), fixedOffset: UIOffset(horizontal: 0, vertical: 0), schematic: schematic)

		let apricot = UIColor(red: 1, green: 0.4, blue: 0.2, alpha: 1)

		schematic.add(row: 0, col: 0, key: Key(text: NSLocalizedString("about", comment: ""), uiColor: apricot, {
		}))
		schematic.add(row: 1, col: 0, key: Key(text: NSLocalizedString("messages", comment: ""), uiColor: apricot, {
			Hovers.toggleMessagesMenu()
		}))
		schematic.add(row: 2, col: 0, key: Key(text: NSLocalizedString("links", comment: ""), uiColor: apricot, {
			Hovers.toggleLinksMenu()
		}))
		schematic.add(row: 3, col: 0, key: Key(text: NSLocalizedString("tutorial", comment: ""), uiColor: apricot, {
			Hovers.toggleTutorialsMenu()
		}))
		
		self.schematic = schematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	override func onInvoke() {
		Hovers.dismissAetherMenu()
		Hovers.dismissLinksMenu()
	}
	override func onDismiss() {
		Hovers.dismissMessagesMenu()
		Hovers.dismissLinksMenu()
		Hovers.dismissTutorialsMenu()
	}
}
