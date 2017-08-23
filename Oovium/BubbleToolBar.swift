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
		
		let objectBubbleTool = BubbleTool(maker: ObjectMaker())
		
		tools[0][0] = objectBubbleTool
		tools[1][0] = BubbleTool(maker: GateMaker(), recoil: objectBubbleTool)
		tools[0][1] = BubbleTool(maker: MechMaker(), recoil: objectBubbleTool)
		tools[1][1] = BubbleTool(maker: TailMaker(), recoil: objectBubbleTool)
		tools[0][2] = BubbleTool(maker: GridMaker(), recoil: objectBubbleTool)
		tools[0][3] = BubbleTool(maker: TypeMaker())
		tools[0][4] = BubbleTool(maker: CronMaker(), recoil: objectBubbleTool)
		tools[0][5] = BubbleTool(maker: TextMaker())
		
		super.init(aetherView: aetherView, tools: tools, offset: UIOffset.zero, fixedOffset: UIOffset(horizontal: 0, vertical: 20))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
	func recoil() {
		if let recoil = (selected as! BubbleTool).recoil {
			recoilSelect(tool: recoil)
		}
	}
	
// Events ==========================================================================================
	override func onExpand() {
		if let bubbleTool = selected as? BubbleTool, bubbleTool.maker is TextMaker {
			Hovers.contractShapeToolBar()
			Hovers.contractColorToolBar()
			Hovers.dismissShapeToolBar()
			Hovers.dismissColorToolBar()
		}
	}
}
