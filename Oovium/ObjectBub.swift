//
//  ObjectBub.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ObjectMaker: Maker {
	func make (origin: CGPoint) -> Bubble {
		return ObjectBub(origin: origin)
	}
	func icon() -> UIImage {
		return UIImage()
	}
}

class ObjectBub: Bubble, ChainLeafDelegate {
	var object: Object = Object(iden: 0, at: V2(0,0))
	
	let chainLeaf = ChainLeaf()
	
	required init (origin: CGPoint) {
		super.init(hitch: .center, origin: origin, size: CGSize(width: 200, height: 48))
//		self.backgroundColor = UIColor.green.withAlphaComponent(0.5)
	
		chainLeaf.delegate = self
		chainLeaf.frame = bounds
		chainLeaf.chainView.chain = object.chain
		object.chain.delegate = chainLeaf.chainView
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
		object.ok()
	}
}
