//
//  MechTool.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class MechTool: BubbleTool {
	
	init() {
		super.init(maker: MechMaker())
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
