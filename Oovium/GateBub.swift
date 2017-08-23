//
//  GateBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class GateMaker: Maker {
// Maker ===========================================================================================
	func make(aether: Aether, at: V2) -> Bubble {
		let gate = aether.createGate(at: at)
		return GateBub(gate)
	}
	func drawIcon() {
		let bw: CGFloat = 20.0*Oo.s
		let p: CGFloat = 2.0*Oo.s
		let iw: CGFloat = (bw-2.0*p)/1.5
		let tw: CGFloat = (bw-2.0*p)/1.5
		let ew: CGFloat = (bw-2.0*p)/1.5
		let h: CGFloat = (7.0*Oo.s-p)/1.5
		let b: CGFloat = 4.0*Oo.s/1.5
		let r: CGFloat = 3.0*Oo.s
		
		let x1 = p+6.0/1.5*Oo.s
		let x3 = x1+iw
		let x2 = (x1+x3)/2.0
		let x4 = 36.0*Oo.s/1.5
		let x6 = x4+tw
		let x5 = (x4+x6)/2.0
		let x7 = 29.0*Oo.s/1.5
		let x9 = x7+ew
		let x8 = (x7+x9)/2.0
		
		let y4 = p+10.0/1.5*Oo.s
		let y5 = y4+h
		let y6 = y5+h
		let y1 = y6+b
		let y2 = y1+h
		let y3 = y2+h
		let y7 = y3+b
		let y8 = y7+h
		let y9 = y8+h
		
		let path = CGMutablePath()
		path.move(to: CGPoint(x: x1, y: y2))
		path.addArc(tangent1End: CGPoint(x: x1, y: y1), tangent2End: CGPoint(x: x2, y: y1), radius: r)
		path.addArc(tangent1End: CGPoint(x: x3, y: y1), tangent2End: CGPoint(x: x3, y: y2), radius: r)
		path.addArc(tangent1End: CGPoint(x: x3, y: y3), tangent2End: CGPoint(x: x2, y: y3), radius: r)
		path.addArc(tangent1End: CGPoint(x: x1, y: y3), tangent2End: CGPoint(x: x1, y: y2), radius: r)
		path.closeSubpath()

		path.move(to: CGPoint(x: x4, y: y5))
		path.addArc(tangent1End: CGPoint(x: x4, y: y4), tangent2End: CGPoint(x: x5, y: y4), radius: r)
		path.addArc(tangent1End: CGPoint(x: x6, y: y4), tangent2End: CGPoint(x: x6, y: y5), radius: r)
		path.addArc(tangent1End: CGPoint(x: x6, y: y6), tangent2End: CGPoint(x: x5, y: y6), radius: r)
		path.addArc(tangent1End: CGPoint(x: x4, y: y6), tangent2End: CGPoint(x: x4, y: y5), radius: r)
		path.closeSubpath()

		path.move(to: CGPoint(x: x7, y: y8))
		path.addArc(tangent1End: CGPoint(x: x7, y: y7), tangent2End: CGPoint(x: x8, y: y7), radius: r)
		path.addArc(tangent1End: CGPoint(x: x9, y: y7), tangent2End: CGPoint(x: x9, y: y8), radius: r)
		path.addArc(tangent1End: CGPoint(x: x9, y: y9), tangent2End: CGPoint(x: x8, y: y9), radius: r)
		path.addArc(tangent1End: CGPoint(x: x7, y: y9), tangent2End: CGPoint(x: x7, y: y8), radius: r)
		path.closeSubpath()
		
		let arrow = CGMutablePath()
		arrow.move(to: CGPoint(x: x5, y: y5))
		arrow.addQuadCurve(to: CGPoint(x: x2, y: y2), control: CGPoint(x: x2, y: y5))
		arrow.addQuadCurve(to: CGPoint(x: x8, y: y8), control: CGPoint(x: x2, y: y8))
		arrow.addQuadCurve(to: CGPoint(x: x3, y: y2), control: CGPoint(x: x7, y: y8))
		arrow.addQuadCurve(to: CGPoint(x: x5, y: y5), control: CGPoint(x: x3, y: y5))
		arrow.closeSubpath()

		let c = UIGraphicsGetCurrentContext()!
		c.setFillColor(OOColor.marine.uiColor.alpha(0.4).cgColor)
		c.setStrokeColor(OOColor.marine.uiColor.alpha(0.7).cgColor)
		c.addPath(arrow)
		c.drawPath(using: .fillStroke)
		
		Skin.bubble(path: path, uiColor: OOColor.marine.uiColor, width: 4.0/3.0*Oo.s)
	}
}

class GateBub: Bubble {
	let gate: Gate
	
	init(_ gate: Gate) {
		self.gate = gate
		super.init(hitch: .center, origin: CGPoint(x: self.gate.x, y: self.gate.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
