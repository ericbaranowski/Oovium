//
//  CyanKeyPad.swift
//  Oovium
//
//  Created by Joe Charlier on 8/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class CyanKeyPad: KeyPad {
	let chainEditor: ChainEditor
	
	init(chainEditor: ChainEditor) {
		self.chainEditor = chainEditor
		
		let schematic = Schematic(rows: 5, cols: 1)
		
		super.init(anchor: .bottomRight, offset: UIOffsetMake(-(176+6+1), -6), size: CGSize(width: 54, height: 214), uiColor: UIColor.cyan, schematic: schematic)
		
		schematic.add(row: 0, col: 0, key: Key(text: "num", uiColor: UIColor.cyan, {
			self.chainEditor.presentNumSchematic()
		}))

		schematic.add(row: 1, col: 0, key: Key(text: "sci", uiColor: UIColor.cyan, {
			self.chainEditor.presentSciSchematic()
		}))

		schematic.add(row: 2, col: 0, key: Key(text: "mis", uiColor: UIColor.cyan, {
			self.chainEditor.presentMisSchematic()
		}))

		schematic.add(row: 3, col: 0, key: Key(text: "obj", uiColor: UIColor.cyan, {
		}))

		schematic.add(row: 4, col: 0, key: Key(text: "cus", uiColor: UIColor.cyan, {
		}))

		self.schematic = schematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
