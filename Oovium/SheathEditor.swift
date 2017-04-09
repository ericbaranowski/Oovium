//
//  SheathHover.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class SheathEditor: Hover {

	init () {
		super.init(anchor: .bottomRight, offset: UIOffset(horizontal: -5, vertical: -5), size: CGSize(width: 100, height: 200))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
}
