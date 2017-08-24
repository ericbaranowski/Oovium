//
//  AetherCell.swift
//  Oovium
//
//  Created by Joe Charlier on 8/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class AetherCell: UITableViewCell {
	var aetherName: String = ""
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.backgroundColor = UIColor.clear
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {

		let p: CGFloat = 5.0/3.0*Oo.s
		let q: CGFloat = 13*Oo.s-p
//		let sp: CGFloat = 4
		let w: CGFloat = rect.width
//		let lw: CGFloat = 56
//		let sq: CGFloat = sp*sqrt(2)
		let ir: CGFloat = 3*Oo.s
		let or: CGFloat = 3*Oo.s
		
		let x1 = p+4*Oo.s
		let x2 = x1
		let x3 = x2
		let x4 = w/2
		let x7 = w-p-4*Oo.s
		let x6 = x7
		let x5 = x6
		
//		let x13 = x7-lw
//		let x12 = x13
//		let x11 = x12
//		let x10 = x13-sq
//		let x9 = x10
//		let x8 = x9
//		let x14 = (x6+x12)/2
		
		let y1 = p
		let y2 = y1+q
		let y3 = y2+q
		
		let path = CGMutablePath()
		path.move(to: CGPoint(x: x2, y: y2))
		path.addArc(tangent1End: CGPoint(x: x3, y: y1), tangent2End: CGPoint(x: x4, y: y1), radius: or)
		path.addArc(tangent1End: CGPoint(x: x7, y: y1), tangent2End: CGPoint(x: x6, y: y2), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x5, y: y3), tangent2End: CGPoint(x: x4, y: y3), radius: or)
		path.addArc(tangent1End: CGPoint(x: x3, y: y3), tangent2End: CGPoint(x: x2, y: y2), radius: ir)
		path.closeSubpath()

		Skin.aetherCell(path: path)
		Skin.aetherCell(text: aetherName, rect: CGRect(x: x2, y: 4*Oo.s, width: x6-x2, height: y3-y1))
	}
}
