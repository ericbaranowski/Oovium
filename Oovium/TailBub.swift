//
//  TailBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class TailMaker: Maker {
	
	// Maker ===========================================================================================
	func make(aether: Aether, at: V2) -> Bubble {
		let tail = aether.createTail(at: at)
		return TailBub(tail)
	}
	func drawIcon() {
		let r: CGFloat = 4.0/1.5
		let p: CGFloat = 3.0/1.5
		let n = 1.0
		
		let or: CGFloat = 4.5/1.5
		
		let rw: CGFloat = 16.0/1.5
		let tw: CGFloat = 12.0/1.5
		let cw: CGFloat = 12.0/1.5
		let sh: CGFloat = 6.0/1.5
		
		let low: CGFloat = 80.0/4/1.5
		let liw:CGFloat = 16.0/1.5
		let row: CGFloat = 80.0/4/1.5
		let riw: CGFloat = 65.0/4/1.5
		
		let vo: CGFloat = 35.0/4/1.5
		let ro: CGFloat = -4.0/1.5
		
		let x3 = p+max(tw,max(cw,low))+7.0/1.5
		let x6 = x3-cw
		let x7 = x3+cw
		let x8 = x3-low
		let x9 = x3-liw
		let x10 = x3+riw
		let x11 = x3+row
		let x12 = x3+ro
		let x14 = x12+rw
		let x13 = (x12+x14)/3
		let x15 = x3-vo
		let x16 = x15+50.0/4/1.5
		var x17 = x15+60.0/4/1.5

		let y4: CGFloat = p+7.0/1.5
		let y5 = y4+or
		let y6 = y5+or
		let y7 = y6+sh
		let y8 = y7+or
		let y9 = y8+or
		let y10 = y9+sh
		let y11 = y10+or
		let y12 = y11+or
		let y13 = (y4+y8)/2
		let y14 = (y6+y8)/2
		let y15 = (y4+y11)/2
		let y16 = (y6+y11)/2
		
		let path = CGMutablePath()
		path.move(to: CGPoint(x: x3, y: y4))
		path.addArc(tangent1End: CGPoint(x: x7, y: y4), tangent2End: CGPoint(x: x7, y: y5), radius: r)
		path.addArc(tangent1End: CGPoint(x: x7, y: y6), tangent2End: CGPoint(x: x3, y: y6), radius: r)
		path.addArc(tangent1End: CGPoint(x: x6, y: y6), tangent2End: CGPoint(x: x6, y: y5), radius: r)
		path.addArc(tangent1End: CGPoint(x: x6, y: y4), tangent2End: CGPoint(x: x3, y: y4), radius: r)
		path.closeSubpath()
		
		// Result ======================================
		path.move(to: CGPoint(x: x12, y: y8))
		path.addArc(tangent1End: CGPoint(x: x12, y: y7), tangent2End: CGPoint(x: x13, y: y7), radius: r)
		path.addArc(tangent1End: CGPoint(x: x14, y: y7), tangent2End: CGPoint(x: x14, y: y8), radius: r)
		path.addArc(tangent1End: CGPoint(x: x14, y: y9), tangent2End: CGPoint(x: x13, y: y9), radius: r)
		path.addArc(tangent1End: CGPoint(x: x12, y: y9), tangent2End: CGPoint(x: x12, y: y8), radius: r)
		path.closeSubpath()
		
		// Vertebrae ===================================
		
		for i in 0..<Int(n) {
			let i: CGFloat = CGFloat(i)
			x17 = x15 + (30.0-2*p)/1.5
			path.move(to: CGPoint(x: x15, y: y11+2*or*i))
			path.addArc(tangent1End: CGPoint(x: x15, y: y10+2*or*i), tangent2End: CGPoint(x: x16, y: y10+2*or*i), radius: r)
			path.addArc(tangent1End: CGPoint(x: x17, y: y10+2*or*i), tangent2End: CGPoint(x: x17, y: y11+2*or*i), radius: r)
			path.addArc(tangent1End: CGPoint(x: x17, y: y12+2*or*i), tangent2End: CGPoint(x: x16, y: y12+2*or*i), radius: r)
			path.addArc(tangent1End: CGPoint(x: x15, y: y12+2*or*i), tangent2End: CGPoint(x: x15, y: y11+2*or*i), radius: r)
			path.closeSubpath()
		}
		
		let arrow = CGMutablePath()
		arrow.move(to: CGPoint(x: x3, y: y4))
		arrow.addQuadCurve(to: CGPoint(x: x8, y: y15), control: CGPoint(x: x8, y: y4))
		arrow.addQuadCurve(to: CGPoint(x: x16, y: y11), control: CGPoint(x: x8, y: y11))
		arrow.addQuadCurve(to: CGPoint(x: x9, y: y16), control: CGPoint(x: x9, y: y16))
		arrow.addQuadCurve(to: CGPoint(x: x3, y: y6), control: CGPoint(x: x9, y: y6))
		arrow.addQuadCurve(to: CGPoint(x: x10, y: y14), control: CGPoint(x: x10, y: y14))
		arrow.addQuadCurve(to: CGPoint(x: x12+9, y: y8), control: CGPoint(x: x10, y: y8))
		arrow.addQuadCurve(to: CGPoint(x: x11, y: y13), control: CGPoint(x: x11, y: y13))
		arrow.addQuadCurve(to: CGPoint(x: x3, y: y4), control: CGPoint(x: x11, y: y4))
		arrow.closeSubpath()
		
		let color = RGB.tint(color: UIColor.blue, percent: 0.5)
		let c = UIGraphicsGetCurrentContext()!
		c.setFillColor(color.alpha(0.4).cgColor)
		c.setStrokeColor(color.alpha(0.9).cgColor)
		c.addPath(arrow)
		c.drawPath(using: .fillStroke)
		
		Skin.bubble(path: path, uiColor: UIColor.blue)
	}
}

class TailBub: Bubble {
	let tail: Tail
	
	init(_ tail: Tail) {
		self.tail = tail
		super.init(hitch: .center, origin: CGPoint(x: self.tail.x, y: self.tail.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
