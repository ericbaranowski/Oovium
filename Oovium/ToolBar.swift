//
//  ToolBar.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ToolBar: Hover {
	var tools: [[Tool?]]
	var current: Tool
	var expanded: Bool
	
	init(tools: [[Tool?]]) {
		self.tools = tools
		current = self.tools[0][0]!
		expanded = false
		
		super.init(anchor: .topRight, offset: UIOffset(horizontal: -9, vertical: 29), size: CGSize(width: 40*tools.count, height: 40*tools[0].count))
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
		addGestureRecognizer(gesture)
		
		var c: Int = 0
		var r: Int = 0
		for column: [Tool?] in tools {
			for tool: Tool? in column {
				if let tool = tool {
					tool.frame = CGRect(x: (tools.count-(c+1))*40, y: r*40, width: 40, height: 40)
					addSubview(tool)
				}
				r += 1
			}
			c += 1
			r = 0
		}

	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	func onTap() {
		
	}
	
// UIView ==========================================================================================
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		return super.hitTest(point, with: event)
	}
}
