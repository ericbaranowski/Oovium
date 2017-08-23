//
//  MechBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class MechMaker: Maker {
	// Maker ===========================================================================================
	func make(aether: Aether, at: V2) -> Bubble {
		let mech = aether.createMech(at: at)
		return MechBub(mech)
	}
	func drawIcon() {
		let w: CGFloat = 27.0*Oo.s
		let p: CGFloat = 3.0*Oo.s
		let or: CGFloat = 4.0*Oo.s
		let r: CGFloat = 1.0*Oo.s
		let lh: CGFloat = 7.0*Oo.s
		let n: CGFloat = 1.0
		
		let x1: CGFloat = 8.0*Oo.s
		let x2 = x1+r
		let x3 = x1+2*r
		let x4 = x1+w/2
		let x5 = x1+w-p-2*r
		let x6 = x1+w-p-r
		let x7 = x1+w-p
		
		let y1 = p+6.0*Oo.s
		let y2 = y1+lh/2.0
		let y3 = y1+lh
		let y4 = y3+r+n*lh/2
		let y5 = y3+2*r+n*lh
		let y6 = y5+lh/2
		let y7 = y5+lh
		
		let path = CGMutablePath()
		path.move(to: CGPoint(x: x4, y: y1))
		path.addArc(tangent1End: CGPoint(x: x7, y: y1), tangent2End: CGPoint(x: x7, y: y2), radius: or)
		path.addArc(tangent1End: CGPoint(x: x7, y: y3), tangent2End: CGPoint(x: x6, y: y3), radius: r)
		path.addArc(tangent1End: CGPoint(x: x5, y: y3), tangent2End: CGPoint(x: x5, y: y4), radius: r)
		path.addArc(tangent1End: CGPoint(x: x5, y: y5), tangent2End: CGPoint(x: x6, y: y5), radius: r)
		path.addArc(tangent1End: CGPoint(x: x7, y: y5), tangent2End: CGPoint(x: x7, y: y6), radius: r)
		path.addArc(tangent1End: CGPoint(x: x7, y: y7), tangent2End: CGPoint(x: x4, y: y7), radius: or)
		path.addArc(tangent1End: CGPoint(x: x1, y: y7), tangent2End: CGPoint(x: x1, y: y6), radius: or)
		path.addArc(tangent1End: CGPoint(x: x1, y: y5), tangent2End: CGPoint(x: x2, y: y5), radius: r)
		path.addArc(tangent1End: CGPoint(x: x3, y: y5), tangent2End: CGPoint(x: x3, y: y4), radius: r)
		path.addArc(tangent1End: CGPoint(x: x3, y: y3), tangent2End: CGPoint(x: x2, y: y3), radius: r)
		path.addArc(tangent1End: CGPoint(x: x1, y: y3), tangent2End: CGPoint(x: x1, y: y2), radius: r)
		path.addArc(tangent1End: CGPoint(x: x1, y: y1), tangent2End: CGPoint(x: x4, y: y1), radius: or)
		path.closeSubpath()

		for i in 0..<Int(n+1) {
			path.move(to: CGPoint(x: x3, y: y3+r+CGFloat(i)*lh))
			path.addLine(to: CGPoint(x: x5, y: y3+r+CGFloat(i)*lh))
		}
		
		Skin.bubble(path: path, uiColor: UIColor.blue, width: 4.0/3.0*Oo.s)
	}
}

class MechBub: Bubble {
	let mech: Mech
	
	init(_ mech: Mech) {
		self.mech = mech
		super.init(hitch: .center, origin: CGPoint(x: self.mech.x, y: self.mech.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
