//
//  ToolBar.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ToolBar: Hover {
	var aetherView: AetherView
	var tools: [[Tool?]]
	var selected: Tool
	var expanded: Bool
	
	var onSelect: (Tool)->() = {(tool: Tool) in }
	
	let numberOfColumns: CGFloat
	let numberOfRows: CGFloat
	
	init(aetherView: AetherView, tools: [[Tool?]], offset: UIOffset, fixedOffset: UIOffset) {
		self.aetherView = aetherView
		self.tools = tools
		selected = self.tools[0][0]!
		expanded = false
		
		numberOfColumns = CGFloat(self.tools.count)
		numberOfRows = CGFloat(self.tools[0].count)
		
		super.init(anchor: .topRight, offset: offset, size: CGSize(width: 40, height: 40), fixedOffset: fixedOffset)
		
		var c: CGFloat = 0
		var r: CGFloat = 0
		for column: [Tool?] in tools {
			for tool: Tool? in column {
				if let tool = tool {
					tool.toolBar = self
					tool.frame = CGRect(x: (CGFloat(tools.count)-(c+1))*40*Oo.s, y: r*40*Oo.s, width: 40*Oo.s, height: 40*Oo.s)
				}
				r += 1
			}
			c += 1
			r = 0
		}
		
		self.selected.frame = CGRect(x: 0, y: 0, width: 40*Oo.s, height: 40*Oo.s)
		addSubview(selected)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
	private func selectedOrigin() -> CGPoint {
		var c: CGFloat = 0
		var r: CGFloat = 0
		for column: [Tool?] in tools {
			for tool: Tool? in column {
				if let tool = tool, tool == selected {
					return CGPoint(x: (CGFloat(tools.count)-(c+1))*40*Oo.s, y: r*40*Oo.s)
				}
				r += 1
			}
			c += 1
			r = 0
		}
		return CGPoint.zero
	}
	
	func expand() {
		guard !expanded else {return}
		expanded = true
		onExpand()
		self.size = CGSize(width: self.numberOfColumns*40, height: self.numberOfRows*40)
		self.selected.frame = CGRect(x: (self.numberOfColumns-1)*40*Oo.s, y: 0, width: 40*Oo.s, height: 40*Oo.s)
		for column: [Tool?] in tools {
			for tool: Tool? in column {
				if let tool = tool, tool != selected {
					addSubview(tool)
				}
			}
		}
		let origin = selectedOrigin()
		UIView.animate(withDuration: 0.2) {
			self.selected.frame = CGRect(x: origin.x, y: origin.y, width: 40*Oo.s, height: 40*Oo.s)
			for column: [Tool?] in self.tools {
				for tool: Tool? in column {
					if let tool = tool, tool != self.selected {
						tool.alpha = 1
					}
				}
			}
		}
	}
	func contract() {
		guard expanded else {return}
		expanded = false
		onContract()
		UIView.animate(withDuration: 0.2, animations: {
			self.selected.frame = CGRect(x: (self.numberOfColumns-1)*40*Oo.s, y: 0, width: 40*Oo.s, height: 40*Oo.s)
			for column: [Tool?] in self.tools {
				for tool: Tool? in column {
					if let tool = tool, tool != self.selected {
						tool.alpha = 0
					}
				}
			}
		}) { (cancelled: Bool) in
			for column: [Tool?] in self.tools {
				for tool: Tool? in column {
					if let tool = tool, tool != self.selected {
						tool.removeFromSuperview()
					}
				}
			}
			self.size = CGSize(width: 40, height: 40)
			self.selected.frame = CGRect(x: 0, y: 0, width: 40*Oo.s, height: 40*Oo.s)
		}
	}
	
	func select(tool: Tool) {
		if expanded {
			selected.onDeselect()
			selected = tool
			selected.onSelect()
			onSelect(tool)
			contract()
		} else {
			expand()
		}
	}
	func recoilSelect(tool: Tool) {
		selected.onDeselect()
		selected.removeFromSuperview()
		let origin = selectedOrigin()
		selected.frame = CGRect(x: origin.x, y: origin.y, width: 40*Oo.s, height: 40*Oo.s)
		
		selected = tool
		selected.frame = CGRect(x: 0, y: 0, width: 40*Oo.s, height: 40*Oo.s)
		selected.alpha = 1
		addSubview(selected)
		selected.onSelect()
		onSelect(tool)
	}
	
// Events ==========================================================================================
	func onExpand() {}
	func onContract() {}
	
// Hover ===========================================================================================
	override func render() {
		super.render()
		var c: CGFloat = 0
		var r: CGFloat = 0
		for column: [Tool?] in tools {
			for tool: Tool? in column {
				if let tool = tool {
					tool.frame = CGRect(x: (CGFloat(tools.count)-(c+1))*40*Oo.s, y: r*40*Oo.s, width: 40*Oo.s, height: 40*Oo.s)
					tool.render()
					tool.setNeedsDisplay()
				}
				r += 1
			}
			c += 1
			r = 0
		}
	}
	override func rescale() {
		super.rescale()
		var c: CGFloat = 0
		var r: CGFloat = 0
		for column: [Tool?] in tools {
			for tool: Tool? in column {
				if let tool = tool {
					tool.frame = CGRect(x: (CGFloat(tools.count)-(c+1))*40*Oo.s, y: r*40*Oo.s, width: 40*Oo.s, height: 40*Oo.s)
					tool.rescale()
				}
				r += 1
			}
			c += 1
			r = 0
		}
		if !expanded {
			self.selected.frame = CGRect(x: 0, y: 0, width: 40*Oo.s, height: 40*Oo.s)
			self.selected.rescale()
		}
	}
	override func retract() {
		contract()
	}

// UIView ==========================================================================================
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		let view = super.hitTest(point, with: event)
		return view != self ? view : nil
	}
}
