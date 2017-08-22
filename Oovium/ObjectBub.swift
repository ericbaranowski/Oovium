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
		let bw = 20*Oo.s
		let bh = 20*Oo.s
		let r: CGFloat = 6*Oo.s

		let x1 = bw-10*Oo.s
		let x2 = bw
		let x3 = bw+10*Oo.s
		
		let y1 = bh-8*Oo.s
		let y2 = bh
		let y3 = bh+8*Oo.s
		
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
	
	lazy var chainLeaf: ChainLeaf = {ChainLeaf(delegate: self)}()
	
	required init (object: Object) {
		self.object = object
		
		super.init(hitch: .center, origin: CGPoint(x: self.object.x, y: self.object.y), size: CGSize(width: 36, height: 36))
	
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
	func onChange() {
		bounds = chainLeaf.bounds
	}
	func onEdit() {
		aetherView?.currentlyEditing = object.chain
		bounds = chainLeaf.bounds
	}
	func onOK() {
		aetherView?.currentlyEditing = nil
		if object.chain.tokens.count != 0 {
			bounds = chainLeaf.bounds
		} else {
			aetherView?.aether.removeAexel(object)
			aetherView?.removeBubble(self)
		}
		object.onOK()
		aetherView?.stretch()
	}
	func referencingThis() -> Bool {
		if let chain = aetherView?.currentlyEditing, chain != object.chain {
			chain.post(token: object.token)
			return true
		} else {
			return false
		}
	}
}
