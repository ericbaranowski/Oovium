//
//  ShapeToolBar.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ShapeToolBar: ToolBar {
	
	init(aetherView: AetherView) {
		var tools: [[Tool?]] = Array(repeating: Array(repeating: nil, count: 4), count: 1)
		
		tools[0][0] = ShapeTool(shape: .ellipse)
		tools[0][1] = ShapeTool(shape: .rounded)
		tools[0][2] = ShapeTool(shape: .rectangle)
		tools[0][3] = ShapeTool(shape: .diamond)
		
		super.init(aetherView: aetherView, tools: tools, offset: UIOffset(horizontal: -40, vertical: 0), fixedOffset: UIOffset(horizontal: 0, vertical: 20))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
