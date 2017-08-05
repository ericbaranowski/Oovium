//
//  GridTool.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class GridTool: BubbleTool {
	init() {
		super.init(maker: GridMaker())
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
