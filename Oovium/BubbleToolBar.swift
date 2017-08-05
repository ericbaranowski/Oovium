//
//  BubbleToolBar.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class BubbleToolBar: ToolBar {
	
	init() {
		var tools: [[Tool]] = []
		
		tools[0][0] = ObjectTool()
		tools[1][0] = GateTool()
		tools[0][1] = MechTool()
		tools[1][1] = TailTool()
		tools[2][0] = GridTool()
		tools[3][0] = TypeTool()
		tools[4][0] = CronTool()
		
		super.init(tools: tools)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
