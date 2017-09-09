//
//  GridBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class GridMaker: Maker {
	
	// Maker ===========================================================================================
	func make(aetherView: AetherView, at: V2) -> Bubble {
		let grid = aetherView.aether.createGrid(at: at)
		return GridBub(grid)
	}
	func drawIcon() {
		let lw: CGFloat = 15*Oo.s
		let cw: CGFloat = lw
		let rh: CGFloat = 7*Oo.s
		let v: CGFloat = 1*Oo.s
		let r: CGFloat = 4*Oo.s
		let ir: CGFloat = 1*Oo.s
		let hh = 2*r
		
		let x1: CGFloat = 6*Oo.s
		let x2 = x1+r+v
		let x3 = x2+ir+v
		let x4 = x3+r
		let x5 = x4+r
		let x6 = x3+cw/2
		let x7 = x3+cw
		let x8 = x7+ir+v
		let x9 = x8+r+v
		
		let y1: CGFloat = 10*Oo.s
		let y2 = y1+r
		let y3 = y1+hh
		let y4 = y3+rh-r
		let y5 = y3+rh
		let y6 = y5+ir+v
		let y7 = y6+r+v
		
		let path = CGMutablePath()
		path.move(to: CGPoint(x: x6, y: y1))
		path.addArc(tangent1End: CGPoint(x: x9, y: y1), tangent2End: CGPoint(x: x9, y: y2), radius: r)
		path.addArc(tangent1End: CGPoint(x: x9, y: y3), tangent2End: CGPoint(x: x8, y: y3), radius: r)
		path.addArc(tangent1End: CGPoint(x: x7, y: y3), tangent2End: CGPoint(x: x7, y: y4), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x7, y: y5), tangent2End: CGPoint(x: x6, y: y5), radius: r)
		path.addArc(tangent1End: CGPoint(x: x5, y: y5), tangent2End: CGPoint(x: x5, y: y6), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x5, y: y7), tangent2End: CGPoint(x: x4, y: y7), radius: r)
		path.addArc(tangent1End: CGPoint(x: x3, y: y7), tangent2End: CGPoint(x: x3, y: y4), radius: r)
		path.addArc(tangent1End: CGPoint(x: x3, y: y3), tangent2End: CGPoint(x: x2, y: y3), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x1, y: y3), tangent2End: CGPoint(x: x1, y: y2), radius: r)
		path.addArc(tangent1End: CGPoint(x: x1, y: y1), tangent2End: CGPoint(x: x6, y: y1), radius: r)
		path.closeSubpath()
		
		path.move(to: CGPoint(x: x2, y: y3))
		path.addLine(to: CGPoint(x: x8, y: y3))
		path.move(to: CGPoint(x: x3, y: y1))
		path.addLine(to: CGPoint(x: x3, y: y4))
		path.move(to: CGPoint(x: x7, y: y1))
		path.addLine(to: CGPoint(x: x7, y: y4))
		path.move(to: CGPoint(x: x3, y: y5))
		path.addLine(to: CGPoint(x: x6, y: y5))

		Skin.bubble(path: path, uiColor: UIColor.purple, width: 4.0/3.0*Oo.s)
	}
}

class GridBub: Bubble {
	let grid: Grid
	
	let gridLeaf: GridLeaf
	
	init(_ grid: Grid) {
		self.grid = grid
		
		gridLeaf = GridLeaf()
		
		super.init(hitch: .center, origin: CGPoint(x: self.grid.x, y: self.grid.y), size: CGSize(width: 36, height: 36))
		
		gridLeaf.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
		add(leaf: gridLeaf)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
