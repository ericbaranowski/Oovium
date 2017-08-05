//
//  TypeBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

import UIKit

class TypeMaker: Maker {
	
	// Maker ===========================================================================================
	func icon() -> UIImage {
		return UIImage()
	}
	func make(aether: Aether, at: V2) -> Bubble {
		let type = aether.createType(at: at)
		return TypeBub(type)
	}
}

class TypeBub: Bubble {
	let type: Type
	
	init(_ type: Type) {
		self.type = type
		super.init(hitch: .center, origin: CGPoint(x: self.type.x, y: self.type.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
