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
	func make(aether: Aether, at: V2) -> Bubble {
		let type = aether.createType(at: at)
		return TypeBub(type)
	}
	func drawIcon() {
		
		let w: CGFloat = 34
		let p: CGFloat = 3
		let or: CGFloat = 4
		let r: CGFloat = 2
		let lh: CGFloat = 7
		let n: CGFloat = 2
		let q: CGFloat = 3
		
		let x1: CGFloat = 9
		let x2 = x1+q
		let x4 = w/2
		let x7 = w-p
		let x6 = x7-q
		
		let y1: CGFloat = 7+p-1
		let y2 = y1+or
		let y3 = y2+or
		let y4 = y3+n*lh
		
		let path = CGMutablePath()
		path.move(to: CGPoint(x: x6, y: y3))
		path.addArc(tangent1End: CGPoint(x: x6, y: y4), tangent2End: CGPoint(x: x4, y: y4), radius: r)
		path.addArc(tangent1End: CGPoint(x: x2, y: y4), tangent2End: CGPoint(x: x2, y: y3), radius: r)
		path.addLine(to: CGPoint(x: x2, y: y3))
		path.closeSubpath()

		for i in 1..<Int(n) {
			path.move(to: CGPoint(x: x2, y: y3+CGFloat(i)*lh))
			path.addLine(to: CGPoint(x: x6, y: y3+CGFloat(i)*lh))
		}
		
		path.move(to: CGPoint(x: x4, y: y1))
		path.addArc(tangent1End: CGPoint(x: x7, y: y1), tangent2End: CGPoint(x: x7, y: y2), radius: or)
		path.addArc(tangent1End: CGPoint(x: x7, y: y3), tangent2End: CGPoint(x: x4, y: y3), radius: or)
		path.addArc(tangent1End: CGPoint(x: x1, y: y3), tangent2End: CGPoint(x: x1, y: y2), radius: or)
		path.addArc(tangent1End: CGPoint(x: x1, y: y1), tangent2End: CGPoint(x: x4, y: y1), radius: or)
		path.closeSubpath()

		Skin.bubble(path: path, uiColor: OOColor.lavender.uiColor)
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
