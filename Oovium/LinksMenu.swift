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
		
		schematic.add(row: 0, col: 0, key: Key(text: NSLocalizedString("oovium", comment: ""), uiColor: UIColor.orange, {
			UIApplication.shared.open(URL(string: "http://aepryus.com/Principia?view=article&articleID=3")!, options: [:], completionHandler: nil)
		}))
		
		schematic.add(row: 1, col: 0, key: Key(text: NSLocalizedString("forums", comment: ""), uiColor: UIColor.orange, {
			UIApplication.shared.open(URL(string: "https://www.reddit.com/r/Oovium/")!, options: [:], completionHandler: nil)
		}))
		
		schematic.add(row: 2, col: 0, key: Key(text: NSLocalizedString("twitter", comment: ""), uiColor: UIColor.orange, {
			UIApplication.shared.open(URL(string: "http://twitter.com/oovium")!, options: [:], completionHandler: nil)
		}))
		
		schematic.add(row: 3, col: 0, key: Key(text: NSLocalizedString("review", comment: ""), uiColor: UIColor.orange, {
			UIApplication.shared.open(URL(string: "http://itunes.apple.com/app/oovium/id336573328?mt=8")!, options: [:], completionHandler: nil)
		}))
		
		self.schematic = schematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// Events ==========================================================================================
	override func onInvoke() {
		Hovers.dismissAetherMenu()
		Hovers.dismissHelpMenu()
	}
}
