//
//  BubbleToolBar.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class BubbleToolBar: ToolBar {
	
	init(aetherView: AetherView) {
		var tools: [[Tool?]] = Array(repeating: Array(repeating: nil, count: 6), count: 2)
		
		tools[0][0] = BubbleTool(maker: ObjectMaker())
		tools[1][0] = BubbleTool(maker: GateMaker())
		tools[0][1] = BubbleTool(maker: MechMaker())
		tools[1][1] = BubbleTool(maker: TailMaker())
		tools[0][2] = BubbleTool(maker: GridMaker())
		tools[0][3] = BubbleTool(maker: TypeMaker())
		tools[0][4] = BubbleTool(maker: CronMaker())
		tools[0][5] = BubbleTool(maker: TextMaker())
		
		super.init(aetherView: aetherView, tools: tools, offset: UIOffset.zero, fixedOffset: UIOffset(horizontal: 0, vertical: 20))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
