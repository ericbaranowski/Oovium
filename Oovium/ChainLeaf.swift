//
//  ChainLeaf.swift
//  Oovium
//
//  Created by Joe Charlier on 4/16/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol ChainLeafDelegate {
	func onEdit()
	func onOK()
}

class ChainLeaf: Leaf, ChainViewDelegate {
	let chainView: ChainView = ChainView()
	var delegate: ChainLeafDelegate?
	var uiColor: UIColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
	
	override init() {
		super.init()
		
		self.backgroundColor = UIColor.clear
		chainView.frame = CGRect(x: 0, y: 0, width: 200, height: 48)
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
		if chainView.chain.open {
			ok()
		} else {
			edit()
		}
	}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let path = CGPath(roundedRect: rect.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil)
		Skin.bubble(path: path, uiColor: uiColor)
	}

// ChainViewDelegate ===============================================================================
	func onEdit() {
		uiColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
		setNeedsDisplay()
		delegate?.onEdit()
	}
	func onOK() {
		uiColor = UIColor.green
		setNeedsDisplay()
		delegate?.onOK()
	}
}
