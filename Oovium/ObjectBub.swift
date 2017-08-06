//
//  ObjectBub.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ObjectMaker: Maker {
// Maker ===========================================================================================
	func make(aether: Aether, at: V2) -> Bubble {
		let object = aether.createObject(at: at)
		return ObjectBub(object:object)
	}
	func drawIcon() {
		let bw = 20
		let bh = 20
		let r: CGFloat = 6

		let x1 = bw-10
		let x2 = bw
		let x3 = bw+10
		
		let y1 = bh-8
		let y2 = bh
		let y3 = bh+8
		
		let path = CGMutablePath()
		path.move(to: CGPoint(x: x1, y: y2))
		path.addArc(tangent1End: CGPoint(x: x1, y: y1), tangent2End: CGPoint(x: x2, y: y1), radius: r)
		path.addArc(tangent1End: CGPoint(x: x3, y: y1), tangent2End: CGPoint(x: x3, y: y2), radius: r)
		path.addArc(tangent1End: CGPoint(x: x3, y: y3), tangent2End: CGPoint(x: x2, y: y3), radius: r)
		path.addArc(tangent1End: CGPoint(x: x1, y: y3), tangent2End: CGPoint(x: x1, y: y2), radius: r)
		path.closeSubpath()
		
		Skin.bubble(path: path, uiColor: UIColor.green)
	}
}

class ObjectBub: Bubble, ChainLeafDelegate {
	var object: Object
	
	let chainLeaf = ChainLeaf()
	
	required init (object: Object) {
		self.object = object
		
		super.init(hitch: .center, origin: CGPoint(x: self.object.x, y: self.object.y), size: CGSize(width: 36, height: 36))
//		self.backgroundColor = UIColor.green.withAlphaComponent(0.5)
	
		chainLeaf.delegate = self
		chainLeaf.frame = bounds
		chainLeaf.chainView.chain = object.chain
		self.object.chain.delegate = chainLeaf.chainView
		addSubview(chainLeaf)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	override func onCreate() {
		chainLeaf.edit()
	}
	
// ChainLeafDelegate ===============================================================================
	func onEdit() {
	}
	func onOK() {
		object.onOK()
		aetherView?.stretch()
	}
}
