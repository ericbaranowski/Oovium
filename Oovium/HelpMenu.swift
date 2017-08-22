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
		super.init(anchor: .bottomLeft, offset: UIOffset(horizontal: 78, vertical: 0), size: CGSize(width: 114, height: 214), fixedOffset: UIOffset(horizontal: 6, vertical: -6), schematic: schematic)
		
		schematic.add(row: 0, col: 0, key: Key(text: NSLocalizedString("about", comment: ""), uiColor: UIColor.orange, {
		}))
		
		schematic.add(row: 1, col: 0, key: Key(text: NSLocalizedString("whatsnew", comment: ""), uiColor: UIColor.orange, {
			Hovers.invokeMessageHover(NSLocalizedString("whatsnewText", comment: ""))
		}))
		
		schematic.add(row: 2, col: 0, key: Key(text: NSLocalizedString("oovium", comment: ""), uiColor: UIColor.orange, {
			Hovers.invokeMessageHover(NSLocalizedString("ooviumText", comment: ""))
		}))
		
		schematic.add(row: 3, col: 0, key: Key(text: NSLocalizedString("anchoring", comment: ""), uiColor: UIColor.orange, {
			Hovers.invokeMessageHover(NSLocalizedString("anchoringText", comment: ""))
		}))
		
		schematic.add(row: 4, col: 0, key: Key(text: NSLocalizedString("tutorial", comment: ""), uiColor: UIColor.orange, {
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
		Hovers.dismissTutorialsMenu()
	}
}
