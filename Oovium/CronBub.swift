//
//  CronBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class CronMaker: Maker {
	
	// Maker ===========================================================================================
	func make(aether: Aether, at: V2) -> Bubble {
		let cron = aether.createCron(at: at)
		return CronBub(cron)
	}
	func drawIcon() {
		
		let p: CGFloat = 2*Oo.s
		let sw: CGFloat = 5.0/1.5*Oo.s
		let cw: CGFloat = 6.0/1.5*Oo.s
		let ah: CGFloat = 7.0/1.5*Oo.s
		let bh: CGFloat = 7.0/1.5*Oo.s
		let ch: CGFloat = 7.0/1.5*Oo.s
		
		let bl: CGFloat = 2.0/1.5*Oo.s
		let ml: CGFloat = 2.0/1.5*Oo.s
		let qw: CGFloat = 2.0/1.5*Oo.s
		let qh: CGFloat = 2.0/1.5*Oo.s
		let ps: CGFloat = 1.0/1.5*Oo.s
		let pw: CGFloat = qw*ps/1.5
		let ph: CGFloat = qh*ps/1.5
		
		let w: CGFloat = 8.0/1.5*Oo.s
		let h: CGFloat = 4.0/1.5*Oo.s
		let r: CGFloat = 4.0/1.5*Oo.s
		
		let x1 = p+11.0/1.5*Oo.s
		let x2 = x1+sw
		let x3 = x2+sw
		let x4 = x3+cw
		let x5 = x4+cw
		let x6 = x5+sw
		let x7 = x6+sw
		let x8 = x4-w
		let x9 = x4+w
		
		let y1 = p+6.0/1.5*Oo.s
		let y2 = y1+ah
		let y3 = y2+bh
		let y4 = y3+ch
		let y5 = y4+ch
		let y6 = y5+bh
		let y7 = y6+ah
		let y8 = y1+5.0/1.5*Oo.s
		let y9 = y8+h
		let y10 = y9+h
		
		let glass = CGMutablePath()
		glass.move(to: CGPoint(x: x1, y: y2))
		glass.addQuadCurve(to: CGPoint(x: x4, y: y1), control: CGPoint(x: x1, y: y1))
		glass.addQuadCurve(to: CGPoint(x: x7, y: y2), control: CGPoint(x: x7, y: y1))
		glass.addCurve(to: CGPoint(x: x6, y: y3), control1: CGPoint(x: x7,		y: y2+bl), control2: CGPoint(x: x6+qw,	y: y3-qh))
		glass.addCurve(to: CGPoint(x: x5, y: y4), control1: CGPoint(x: x6-pw,	y: y3+ph), control2: CGPoint(x: x5,		y: y4-ml))
		glass.addCurve(to: CGPoint(x: x6, y: y5), control1: CGPoint(x: x5,		y: y4+ml), control2: CGPoint(x: x6-pw,	y: y5-ph))
		glass.addCurve(to: CGPoint(x: x7, y: y6), control1: CGPoint(x: x6+qw,	y: y5+qh), control2: CGPoint(x: x7,		y: y6-bl))
		glass.addQuadCurve(to: CGPoint(x: x4, y: y7), control: CGPoint(x: x7, y: y7))
		glass.addQuadCurve(to: CGPoint(x: x1, y: y6), control: CGPoint(x: x1, y: y7))
		glass.addCurve(to: CGPoint(x: x2, y: y5), control1: CGPoint(x: x1,		y: y6-bl), control2: CGPoint(x: x2-qw,	y: y5+qh))
		glass.addCurve(to: CGPoint(x: x3, y: y4), control1: CGPoint(x: x2+pw,	y: y5-ph), control2: CGPoint(x: x3,		y: y4+ml))
		glass.addCurve(to: CGPoint(x: x2, y: y3), control1: CGPoint(x: x3,		y: y4-ml), control2: CGPoint(x: x2+pw,	y: y3+ph))
		glass.addCurve(to: CGPoint(x: x1, y: y2), control1: CGPoint(x: x2-qw,	y: y3-qh), control2: CGPoint(x: x1,		y: y2+bl))
		glass.closeSubpath()
		
		Skin.bubble(path: glass, uiColor: OOColor.cobolt.uiColor, width: 4.0/3.0*Oo.s)
		
		var path = CGMutablePath()
		path.move(to: CGPoint(x: x8, y: y9))
		path.addArc(tangent1End: CGPoint(x: x8, y: y8), tangent2End: CGPoint(x: x4, y: y8), radius: r)
		path.addArc(tangent1End: CGPoint(x: x9, y: y8), tangent2End: CGPoint(x: x9, y: y9), radius: r)
		path.addArc(tangent1End: CGPoint(x: x9, y: y10), tangent2End: CGPoint(x: x4, y: y10), radius: r)
		path.addArc(tangent1End: CGPoint(x: x8, y: y10), tangent2End: CGPoint(x: x8, y: y9), radius: r)
		path.closeSubpath()
		
		Skin.bubble(path: path, uiColor: OOColor.cobolt.uiColor, width: 4.0/3.0*Oo.s)
		
		let ir: CGFloat = 5.0/1.5*Oo.s
		
		let ix1 = x4-ir
		
		let iy1 = y1+26.5/1.5*Oo.s
		
		path = CGMutablePath()
		path.addEllipse(in: CGRect(x: ix1, y: iy1, width: 2*ir, height: 2*ir))
		
		Skin.bubble(path: path, uiColor: OOColor.cobolt.uiColor, width: 4.0/3.0*Oo.s)
	}
}

class CronBub: Bubble, ChainLeafDelegate {
	let cron: Cron

	lazy var startLeaf: ChainLeaf = {ChainLeaf(delegate: self)}()
	lazy var stopLeaf: ChainLeaf = {ChainLeaf(delegate: self)}()
	lazy var stepsLeaf: ChainLeaf = {ChainLeaf(delegate: self)}()
	lazy var rateLeaf: ChainLeaf = {ChainLeaf(delegate: self)}()
	lazy var deltaLeaf: ChainLeaf = {ChainLeaf(delegate: self)}()
	lazy var whileLeaf: ChainLeaf = {ChainLeaf(delegate: self)}()

	init(_ cron: Cron) {
		self.cron = cron
		super.init(hitch: .center, origin: CGPoint(x: self.cron.x, y: self.cron.y), size: CGSize(width: 80, height: 80))
		
		startLeaf.chain = cron.startChain
		startLeaf.uiColor = OOColor.cobolt.uiColor
		startLeaf.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
		addSubview(startLeaf)

		stopLeaf.chain = cron.stopChain
		stopLeaf.uiColor = OOColor.cobolt.uiColor
		stopLeaf.frame = CGRect(x: 40, y: 0, width: 36, height: 36)
		addSubview(stopLeaf)
		
		stepsLeaf.chain = cron.stepsChain
		stepsLeaf.uiColor = OOColor.cobolt.uiColor
		stepsLeaf.frame = CGRect(x: 0, y: 40, width: 36, height: 36)
		addSubview(stepsLeaf)
		
		rateLeaf.chain = cron.rateChain
		rateLeaf.uiColor = OOColor.cobolt.uiColor
		rateLeaf.frame = CGRect(x: 40, y: 40, width: 36, height: 36)
		addSubview(rateLeaf)
		
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// ChainLeafDelegate ===============================================================================
	func onChange() {}
	func onEdit() {}
	func onOK() {}
	func referencingThis() -> Bool {return false}
}
