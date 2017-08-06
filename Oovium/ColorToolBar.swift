//
//  ColorToolBar.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ColorToolBar: ToolBar {
	
	init() {
		var tools: [[Tool?]] = []
		
		tools[0][0] = ColorTool()
		tools[0][1] = ColorTool()
		tools[0][2] = ColorTool()
		tools[0][3] = ColorTool()
		tools[1][0] = ColorTool()
		tools[1][1] = ColorTool()
		tools[1][2] = ColorTool()
		tools[1][3] = ColorTool()
		tools[2][0] = ColorTool()
		tools[2][1] = ColorTool()
		tools[2][2] = ColorTool()
		tools[2][3] = ColorTool()
		tools[3][0] = ColorTool()
		tools[3][1] = ColorTool()
		tools[3][2] = ColorTool()
		tools[3][3] = ColorTool()
		
		super.init(tools: tools)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
