//
//  Hovers.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class Hovers {
	static let window = UIApplication.shared.keyWindow!
	
	static var invoked = [Hover]()
	
	static func isInvoked(hover: Hover) -> Bool {
		return invoked.contains(hover)
	}
	static func invoke (hover: Hover) {
		guard !isInvoked(hover: hover) else {return}
		Hovers.invoked.append(hover)
		Hovers.window.addSubview(hover)
		hover.alpha = 0
		UIView.animate(withDuration: 0.2) {
			hover.alpha = 1
		}
	}
	static func dismiss (hover: Hover) {
		guard isInvoked(hover: hover) else {return}
		UIView.animate(withDuration: 0.2, animations: {
			hover.alpha = 0
		}) { (canceled: Bool) in
			hover.removeFromSuperview();
			Hovers.invoked.remove(at: Hovers.invoked.index(of: hover)!)
		}
		
	}
	
// Admin ===========================================================================================
	static func render() {
		for hover in invoked {
			hover.render()
		}
	}

// Menu ============================================================================================
	static let redDot_ = RedDot()
	static func invokeRedDot() {
		invoke(hover: redDot_)
	}
	
	static let rootMenu_ = RootMenu()
	static func toggleRootMenu() {
		rootMenu_.toggle()
	}
	
	static let aetherMenu_ = AetherMenu()
	static func toggleAetherMenu() {
		aetherMenu_.toggle()
	}
	static func dismissAetherMenu() {
		aetherMenu_.dismiss()
	}
	
	static let linksMenu_ = LinksMenu()
	static func toggleLinksMenu() {
		linksMenu_.toggle()
	}
	static func dismissLinksMenu() {
		linksMenu_.dismiss()
	}
	
	static let helpMenu_ = HelpMenu()
	static func toggleHelpMenu() {
		helpMenu_.toggle()
	}
	static func dismissHelpMenu() {
		helpMenu_.dismiss()
	}
	
	static let tutorialsMenu_ = TutorialsMenu()
	static func toggleTutorialsMenu() {
		tutorialsMenu_.toggle()
	}
	static func dismissTutorialsMenu() {
		tutorialsMenu_.dismiss()
	}

// ToolBars ========================================================================================
	static let bubbleToolBar_: BubbleToolBar = {
		let toolBar = BubbleToolBar(aetherView: Oovium.aetherView)
		toolBar.onSelect = {(tool: Tool) in
			let bubbleTool: BubbleTool = tool as! BubbleTool
			toolBar.aetherView.maker = bubbleTool.maker
			print(String(describing: type(of: bubbleTool.maker)))
		}
		return toolBar
	}()
	static func invokeBubbleToolBar() {
		bubbleToolBar_.invoke()
	}
	
	static let shapeToolBar_: ShapeToolBar = {
		let toolBar = ShapeToolBar(aetherView: Oovium.aetherView)
		return toolBar
	}()
	static func invokeShapeToolBar() {
		shapeToolBar_.invoke()
	}
	
	static let colorToolBar_: ColorToolBar = {
		let toolBar = ColorToolBar(aetherView: Oovium.aetherView)
		return toolBar
	}()
	static func invokeColorToolBar() {
		colorToolBar_.invoke()
	}
	
// AetherPicker ====================================================================================
	static let aetherPicker_ = AetherPicker()
	static func invokeAetherPicker() {
		aetherPicker_.invoke()
	}
	
// Editors =========================================================================================
	static private var chainEditor_ = ChainEditor()
	static func invokeChainEditor(chain: Chain) {
		chainEditor_.chain = chain
		chainEditor_.invoke()
	}
	static func dismissChainEditor() {
		chainEditor_.dismiss()
	}
	
// Settings ========================================================================================
	static private var settingsHover_ = SettingsHover()
	static func invokeSettingsHover() {
		settingsHover_.invoke()
	}
	static func dismissSettingsHover() {
		settingsHover_.dismiss()
	}
	
// Miscellaneous ===================================================================================
	static let messageHover_ = MessageHover()
	static func invokeMessageHover(_ message: String) {
		messageHover_.message = message
		messageHover_.invoke()
	}
}
