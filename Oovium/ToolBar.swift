//
//  ToolBar.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ToolBar: Hover {
	var tools: [[Tool]]
	var current: Tool
	var expanded: Bool
	
	init(tools: [[Tool]]) {
		self.tools = tools
		current = self.tools[0][0]
		expanded = false
		
		super.init(anchor: .topRight, offset: UIOffset(horizontal: 9, vertical: 29), size: CGSize(width: 40, height: 40))
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
		addGestureRecognizer(gesture)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	func onTap() {
		
	}
	
// UIView ==========================================================================================
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		return super.hitTest(point, with: event)
	}
	override func draw(_ rect: CGRect) {
	}
}
