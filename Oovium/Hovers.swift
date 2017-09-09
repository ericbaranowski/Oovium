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
	
	static var hovers = Set<Hover>()
	static var invoked = [Hover]()
	
	static func isInvoked(hover: Hover) -> Bool {
		return invoked.contains(hover)
	}
	static func invoke (hover: Hover) {
		guard !isInvoked(hover: hover) else {return}
		Hovers.invoked.append(hover)
		Hovers.window.addSubview(hover)
		hover.alpha = 0
		UIView.animate(withDuration: 0.2, animations: { 
			hover.alpha = 1
		}) { (canceled: Bool) in
			hover.onFadeIn()
		}
	}
	static func dismiss (hover: Hover) {
		guard isInvoked(hover: hover) else {return}
		Hovers.invoked.remove(at: Hovers.invoked.index(of: hover)!)
		UIView.animate(withDuration: 0.2, animations: {
			hover.alpha = 0
		}) { (canceled: Bool) in
			hover.removeFromSuperview();
		}
	}
	
// Admin ===========================================================================================
	static func initialize() {
		hovers.insert(redDot_)
		hovers.insert(rootMenu_)
		hovers.insert(aetherMenu_)
		hovers.insert(helpMenu_)
		hovers.insert(messagesMenu_)
		hovers.insert(linksMenu_)
		hovers.insert(tutorialsMenu_)
		
		hovers.insert(bubbleToolBar_)
		hovers.insert(shapeToolBar_)
		hovers.insert(colorToolBar_)

		hovers.insert(aetherPicker_)
		hovers.insert(chainEditor_)
		hovers.insert(settingsHover_)
		hovers.insert(messageHover_)
	}
	static func rescale() {
		for hover in hovers {
			hover.rescale()
		}
	}
	static func retract() {
		for hover in invoked {
			hover.retract()
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
	static func dismissRootMenu() {
		rootMenu_.dismiss()
	}
	
	static let aetherMenu_ = AetherMenu()
	static func toggleAetherMenu() {
		aetherMenu_.toggle()
	}
	static func dismissAetherMenu() {
		aetherMenu_.dismiss()
	}
	
	static let helpMenu_ = HelpMenu()
	static func toggleHelpMenu() {
		helpMenu_.toggle()
	}
	static func dismissHelpMenu() {
		helpMenu_.dismiss()
	}
	
	static let messagesMenu_ = MessagesMenu()
	static func toggleMessagesMenu() {
		messagesMenu_.toggle()
	}
	static func dismissMessagesMenu() {
		messagesMenu_.dismiss()
	}
	
	static let linksMenu_ = LinksMenu()
	static func toggleLinksMenu() {
		linksMenu_.toggle()
	}
	static func dismissLinksMenu() {
		linksMenu_.dismiss()
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
		}
		return toolBar
	}()
	static func invokeBubbleToolBar() {
		bubbleToolBar_.invoke()
	}
	
	static let shapeToolBar_: ShapeToolBar = {
		let toolBar = ShapeToolBar(aetherView: Oovium.aetherView)
		toolBar.onSelect = {(tool: Tool) in
			let shapeTool: ShapeTool = tool as! ShapeTool
			toolBar.aetherView.shape = shapeTool.shape
		}
		return toolBar
	}()
	static func invokeShapeToolBar() {
		shapeToolBar_.invoke()
	}
	static func dismissShapeToolBar() {
		shapeToolBar_.dismiss()
	}
	static func contractShapeToolBar() {
		shapeToolBar_.contract()
	}
	
	static let colorToolBar_: ColorToolBar = {
		let toolBar = ColorToolBar(aetherView: Oovium.aetherView)
		toolBar.onSelect = {(tool: Tool) in
			let colorTool: ColorTool = tool as! ColorTool
			toolBar.aetherView.color = colorTool.color
		}
		return toolBar
	}()
	static func invokeColorToolBar() {
		colorToolBar_.invoke()
	}
	static func dismissColorToolBar() {
		colorToolBar_.dismiss()
	}
	static func contractColorToolBar() {
		colorToolBar_.contract()
	}
	
// AetherPicker ====================================================================================
	static let aetherPicker_ = AetherPicker()
	static func invokeAetherPicker() {
		aetherPicker_.invoke()
	}
	static func retractAetherPicker() {
		aetherPicker_.retract()
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
	
// Contexts ========================================================================================
	static let multiContext = MultiContext()
	static let objectContext = ObjectContext()
	static let typeContext = TypeContext()
	static let textContext = TextContext()
	static let textMultiContext = TextMultiContext()
	
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
