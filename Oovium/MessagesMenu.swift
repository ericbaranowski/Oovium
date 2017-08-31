//
//  MessageMenu.swift
//  Oovium
//
//  Created by Joe Charlier on 8/29/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class MessagesMenu: KeyPad {
	init() {
		let schematic = Schematic(rows: 3, cols: 1)
		super.init(anchor: .bottomLeft, offset: UIOffset(horizontal: 192+6, vertical: -6), size: CGSize(width: 104, height: 214), fixedOffset: UIOffset(horizontal: 0, vertical: 0), schematic: schematic)
		
		let apricot = UIColor(red: 1, green: 0.4, blue: 0.2, alpha: 1)

		schematic.add(row: 0, col: 0, key: Key(text: NSLocalizedString("whatsnew", comment: ""), uiColor: apricot, {
			Hovers.dismissRootMenu()
			Hovers.invokeMessageHover(NSLocalizedString("whatsnewText", comment: ""))
		}))
		
		schematic.add(row: 1, col: 0, key: Key(text: NSLocalizedString("oovium", comment: ""), uiColor: apricot, {
			Hovers.dismissRootMenu()
			Hovers.invokeMessageHover(NSLocalizedString("ooviumText", comment: ""))
		}))
		
		schematic.add(row: 2, col: 0, key: Key(text: NSLocalizedString("anchoring", comment: ""), uiColor: apricot, {
			Hovers.dismissRootMenu()
			Hovers.invokeMessageHover(NSLocalizedString("anchoringText", comment: ""))
		}))
		
		
		self.schematic = schematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	override func onInvoke() {
		Hovers.dismissLinksMenu()
		Hovers.dismissTutorialsMenu()
	}
}
