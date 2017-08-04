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
		let pen = Pen(font: UIFont(name: "HelveticaNeue", size: 16)!)
		var x: CGFloat = 0

		if !chain.open {
			x = ("\(chain!)" as NSString).size(attributes: pen.attributes).width
			
		} else {
			let sb = NSMutableString()
			var token: Token
			let to = chain.tokens.count
			
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
			x += 3
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
				let pen = Pen(font: UIFont(name: "HelveticaNeue", size: 16)!)
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
			Skin.bubble(text: "\(chain!)", x: 0, y: 0, uiColor: UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1))
		} else {
			let x: CGFloat = drawTokens(at: 0, from: 0, to: chain.cursor)
			// Cursor
			if chain.tokens.count > 0 {
				let path = CGMutablePath()
				path.move(to: CGPoint(x: x+1, y: 1))
				path.addLine(to: CGPoint(x: x+1, y: 20))
				let c = UIGraphicsGetCurrentContext()!
				c.setStrokeColor(UIColor.white.cgColor)
				c.setLineWidth(2)
				c.addPath(path)
				c.drawPath(using: .stroke)
			}

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
		self.frame = CGRect(x: 12.75, y: 7, width: calcWidth(), height: 21)
		setNeedsDisplay()
		delegate.onChange()
	}
	func onEdit() {
		self.frame = CGRect(x: 12.75, y: 7, width: calcWidth(), height: 21)
		setNeedsDisplay()
		Hovers.invokeChainEditor(chain: chain)
		delegate.onEdit()
	}
	func onOK() {
		delegate.onOK()
		self.frame = CGRect(x: 12.75, y: 7, width: calcWidth(), height: 21)
		setNeedsDisplay()
		Hovers.dismissChainEditor()
	}
	
// Static ==========================================================================================
	static var chainEditor = ChainEditor()
}
