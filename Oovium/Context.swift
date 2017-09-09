//
//  ContextHover.swift
//  Oovium
//
//  Created by Joe Charlier on 9/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

class Context: KeyPad {
	
	init(schematic: Schematic) {
		super.init(anchor: .bottomRight, offset: UIOffset.zero, size: CGSize(width: 84, height: 154), fixedOffset: UIOffset(horizontal: -6, vertical: -6), uiColor: UIColor.yellow, schematic: schematic)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Hover ===========================================================================================
//	override func onRetract() {
//		dismiss()
//	}
}
