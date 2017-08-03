//
//  ChainView.swift
//  Oovium
//
//  Created by Joe Charlier on 4/10/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol ChainViewDelegate {
	var color: UIColor {get}
	
	func onChange()
	func onEdit()
	func onOK()
}

class ChainView: UIView, UIKeyInput, ChainDelegate {
	var chain: Chain!
	var delegate: ChainViewDelegate!
	var anchor: Position
	var at: CGPoint
	
	init() {
		anchor = .topLeft
		at = CGPoint(x: 0, y: 0)
		super.init(frame: CGRect.zero)
		self.backgroundColor = UIColor.clear
	}
	public required init? (coder aDecoder: NSCoder) {fatalError()}
	
	
	func calcWidth() -> CGFloat {
		
		let sb = NSMutableString()
		var x: CGFloat = 0
		var token: Token
		let to = chain.tokens.count
		let pen = Pen(font: UIFont.systemFont(ofSize: 19))
		
		var i: Int = 0
		while i < to {
			repeat {
				token = chain.tokens[i]
				sb.append(token.display)
				i += 1
			} while (i < to)
			if sb.length > 0 {
				x += sb.size(attributes: pen.attributes).width
				sb.setString("")
			}
			if token.type == .variable {}
		}

		return x
	}
	
// Actions =========================================================================================
	func edit() {
		chain.edit()
	}
	func ok() {
		chain.ok()
	}
	
// UIView ==========================================================================================
	private func drawTokens(at x: CGFloat, from: Int, to: Int) -> CGFloat {
		var x: CGFloat = x
		let sb = NSMutableString()
		var pos: Int = from
		var token: Token
		while (pos < to) {
			repeat {
				token = chain.tokens[pos]
				if token.type == .variable {break}
				sb.append(token.display)
				pos += 1
			} while (pos < to)
			if sb.length > 0 {
				Skin.bubble(text: sb as String, x: x, y: 0, uiColor: delegate.color)
				let pen = Pen(font: UIFont.systemFont(ofSize: 19))
				x += sb.size(attributes: pen.attributes).width
				sb.setString("")
			}
			if token.type == .variable {
//				x += Skin.
				pos += 1
			}
		}
		return x
	}
	override func draw(_ rect: CGRect) {
		if !chain.open {
			Skin.bubble(text: "\(chain!)", x: 8, y: 8, uiColor: UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1))
		} else {
			let x: CGFloat = drawTokens(at: 6, from: 0, to: chain.cursor)
			// Cursor
//			if

			_ = drawTokens(at: x, from: chain.cursor, to: chain.tokens.count)
		}
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
		self.frame = CGRect(x: 0, y: 0, width: 12+calcWidth(), height: 25)
		delegate.onChange()
		setNeedsDisplay()
	}
	func onEdit() {
		Hovers.invokeChainEditor(chain: chain)
		delegate.onEdit()
	}
	func onOK() {
		Hovers.dismissChainEditor()
		delegate.onOK()
		setNeedsDisplay()
	}
	
// Static ==========================================================================================
	static var chainEditor = ChainEditor()
}
