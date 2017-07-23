//
//  ObjectBub.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ObjectMaker: Maker {
	func make(aether: Aether, at: V2) -> Bubble {
		let object = aether.createObject(at: at)
		return ObjectBub(object:object)
	}
	func icon() -> UIImage {
		return UIImage()
	}
}

class ObjectBub: Bubble, ChainLeafDelegate {
	var object: Object
	
	let chainLeaf = ChainLeaf()
	
	required init (object: Object) {
		self.object = object
		
		super.init(hitch: .center, origin: CGPoint(x: self.object.x, y: self.object.y), size: CGSize(width: 200, height: 48))
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
	}
}
