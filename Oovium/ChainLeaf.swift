//
//  ChainLeaf.swift
//  Oovium
//
//  Created by Joe Charlier on 4/16/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol ChainLeafDelegate {
	func onChange()
	func onEdit()
	func onOK()
	func referencingThis() -> Bool
}

class ChainLeaf: Leaf, ChainViewDelegate {
	let chainView: ChainView = ChainView()
	var delegate: ChainLeafDelegate
	var uiColor: UIColor = UIColor.green
	
	var chain: Chain {
		set {
			chainView.chain = newValue
			newValue.delegate = chainView
		}
		get {
			return chainView.chain
		}
	}
	
	init(delegate: ChainLeafDelegate) {
		self.delegate = delegate
		
		super.init()
		
		self.backgroundColor = UIColor.clear
		chainView.frame = CGRect(x: 18, y: 12, width: 200, height: 21)
		chainView.delegate = self
		addSubview(chainView)
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
		addGestureRecognizer(gesture)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
	func edit() {
		chainView.edit()
	}
	func ok() {
		chainView.ok()
	}
	
// Events ==========================================================================================
	func onTap(_ gesture: UITapGestureRecognizer) {
		if !delegate.referencingThis() {
			if chainView.chain.open {
				ok()
			} else {
				edit()
			}
		}
	}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let path = CGPath(roundedRect: rect.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
		Skin.bubble(path: path, uiColor: uiColor, width: 4.0/3.0*Oo.s)
	}

// ChainViewDelegate ===============================================================================
	var color: UIColor {
		return uiColor
	}
	
	func onChange() {
		let newWidth = max(chainView.width+24, 36)
		self.frame = CGRect(x: 0, y: 0, width: newWidth, height: 35)
		setNeedsDisplay()
		delegate.onChange()
	}
	func onEdit() {
		let newWidth = max(chainView.width+24, 36)
		self.frame = CGRect(x: 0, y: 0, width: newWidth, height: 35)
		uiColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
		setNeedsDisplay()
		delegate.onEdit()
	}
	func onOK() {
		delegate.onOK()
		let newWidth = max(chainView.calcWidth()+24, 36)
		self.frame = CGRect(x: 0, y: 0, width: newWidth, height: 35)
		uiColor = UIColor.green
		setNeedsDisplay()
		delegate.onChange()
	}
}
