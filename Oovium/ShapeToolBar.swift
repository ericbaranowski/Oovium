//
//  ShapeToolBar.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ShapeToolBar: ToolBar {
	
	init() {
		var tools: [[Tool?]] = []
		
		tools[0][0] = ShapeTool()
		tools[0][1] = ShapeTool()
		tools[0][2] = ShapeTool()
		tools[0][3] = ShapeTool()
		
		super.init(tools: tools)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
