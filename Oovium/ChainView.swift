//
//  ChainView.swift
//  Oovium
//
//  Created by Joe Charlier on 4/10/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol ChainViewDelegate {
	func onEdit()
	func onOK()
}

class ChainView: UIView, UIKeyInput, ChainDelegate {
	var chain: Chain!
	var delegate: ChainViewDelegate?
	
	init() {
		super.init(frame: CGRect.zero)
		self.backgroundColor = UIColor.clear
	}
	public required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Actions =========================================================================================
	func edit() {
		chain.edit()
	}
	func ok() {
		chain.ok()
	}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		Skin.bubble(text: "\(chain!)", x: 8, y: 8, uiColor: UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1))
	}

// UIKeyInput ======================================================================================
	var hasText: Bool {
		return true
	}
	func insertText(_ text: String) {
	}
	func deleteBackward() {
		chain.backspace()
	}
	
// ChainDelegate ===================================================================================
	func onChange() {
		setNeedsDisplay()
	}
	func onEdit() {
		Hovers.invokeChainEditor(chain: chain)
		delegate?.onEdit()
	}
	func onOK() {
		Hovers.dismissChainEditor()
		delegate?.onOK()
		setNeedsDisplay()
	}
	
// Static ==========================================================================================
	static var chainEditor = ChainEditor()
}
