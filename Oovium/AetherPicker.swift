//
//  AetherPicker.swift
//  Oovium
//
//  Created by Joe Charlier on 8/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class AetherPicker: Hover, UITableViewDelegate, UITableViewDataSource {
	var aetherNames: [String]
	
	let aetherButton: PathButton
	var listMask: MaskView!
	let aetherList: UITableView
	var expanded: Bool = false
	
	var expandedSize: CGSize
	var contractedSize: CGSize
	
	init() {
		aetherNames = Local.aetherNames()
		
		let p: CGFloat = 2*Oo.s
		let q: CGFloat = 13*Oo.s
		let sp: CGFloat = 4*Oo.s
		let bw: CGFloat = 60*Oo.s
		let lw: CGFloat = 18*Oo.s
		let h: CGFloat = 216*Oo.s
		
		let sq: CGFloat = sp*sqrt(2)
		let r: CGFloat = q-sp/2
		let w: CGFloat = 3*sq+2*lw+2*bw+2*r+2*p
		let c: CGFloat = 1
		
		let ir: CGFloat = 2*Oo.s
		let or: CGFloat = 8*Oo.s
		let rr: CGFloat = 4*Oo.s
		
		let x1 = p
		let x2 = x1+q
		let x3 = x2+q
		let x4 = w/2
		let x7 = w-p
		let x6 = x7-q
		let x5 = x6-q
		
		let x8 = x1+sq
		let x9 = x8+r
		let x10 = x9+r
		let x11 = x9+bw
		let x13 = x11+bw
		let x12 = x13-r
		let x14 = x13+r
		
		let y1 = p
		let y2 = y1+q
		let y3 = y2+q
		let y4 = h/2
		let y5 = h-p
		let y6 = y1+r
		let y7 = y6+r
		
		var path = CGMutablePath()
		path.move(to: CGPoint(x: x9, y: y6))
		path.addArc(tangent1End: CGPoint(x: x8, y: y1), tangent2End: CGPoint(x: x11, y: y1), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x14, y: y1), tangent2End: CGPoint(x: x13, y: y6), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x12, y: y7), tangent2End: CGPoint(x: x11, y: y7), radius: or)
		path.addArc(tangent1End: CGPoint(x: x10, y: y7), tangent2End: CGPoint(x: x9, y: y6), radius: or)
		path.closeSubpath()
		
		aetherButton = PathButton(frame: CGRect(x: 0, y: 0, width: x14+p, height: y7+p), path: path)

		aetherList = UITableView(frame: CGRect(x: x1, y: y1, width: w-2*p, height: h-2*p))
		
		expandedSize = CGSize(width: w/Oo.s, height: h/Oo.s)
		contractedSize = CGSize(width: (x14+p)/Oo.s, height: (y7+p)/Oo.s)

		super.init(anchor: .topLeft, offset: UIOffset(horizontal: 0, vertical: 0), size: contractedSize, fixedOffset: UIOffset(horizontal: 3, vertical: 23))
		
		aetherButton.add(for: .touchUpInside) {
			self.toggleExpanded()
		}
		addSubview(aetherButton)

		aetherList.delegate = self
		aetherList.dataSource = self
		aetherList.register(AetherCell.self, forCellReuseIdentifier: "cell")
		aetherList.separatorStyle = .none
		aetherList.backgroundColor = UIColor.clear
		aetherList.rowHeight = 26*Oo.s
		aetherList.contentInset = UIEdgeInsets(top: y3+2*Oo.s, left: 0, bottom: 0, right: 0)
		aetherList.allowsSelection = false
		aetherList.alpha = 0
		
		path = CGMutablePath()
		path.move(to: CGPoint(x: x1, y: y4))
		path.addArc(tangent1End: CGPoint(x: x1-c, y: y1+c), tangent2End: CGPoint(x: x2-c, y: y2+c), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x3-c, y: y3+c), tangent2End: CGPoint(x: x4  , y: y3+c), radius: or)
		path.addArc(tangent1End: CGPoint(x: x5+c, y: y3+c), tangent2End: CGPoint(x: x6+c, y: y2+c), radius: or)
		path.addArc(tangent1End: CGPoint(x: x7+c, y: y1+c), tangent2End: CGPoint(x: x7+c, y: y4), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x7+c, y: y5-c), tangent2End: CGPoint(x: x4  , y: y5-c), radius: rr)
		path.addArc(tangent1End: CGPoint(x: x1  , y: y5-c), tangent2End: CGPoint(x: x1  , y: y4), radius: rr)
		path.closeSubpath()
		
		listMask = MaskView(frame: CGRect(x: 0, y: 0, width: x7+p, height: y5+p), content: aetherList, path: path)
		addSubview(listMask)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
	func toggleExpanded() {
		expanded = !expanded
		
		UIView.animate(withDuration: 0.2, animations: {
			self.aetherList.alpha = self.expanded ? 1 : 0
		})
		
		size = expanded ? expandedSize : contractedSize
		setNeedsDisplay()
	}
	
// Hover ===========================================================================================
	override func retract() {
		if expanded {
			toggleExpanded()
		}
	}
	override func render() {
		super.render()
	}
	override func rescale() {
		super.rescale()

		let p: CGFloat = 2*Oo.s
		let q: CGFloat = 13*Oo.s
		let sp: CGFloat = 4*Oo.s
		let bw: CGFloat = 60*Oo.s
		let lw: CGFloat = 18*Oo.s
		let h: CGFloat = 216*Oo.s
		
		let sq: CGFloat = sp*sqrt(2)
		let r: CGFloat = q-sp/2
		let w: CGFloat = 3*sq+2*lw+2*bw+2*r+2*p
		let c: CGFloat = 1
		
		let ir: CGFloat = 2*Oo.s
		let or: CGFloat = 8*Oo.s
		let rr: CGFloat = 4*Oo.s
		
		let x1 = p
		let x2 = x1+q
		let x3 = x2+q
		let x4 = w/2
		let x7 = w-p
		let x6 = x7-q
		let x5 = x6-q
		
		let x8 = x1+sq
		let x9 = x8+r
		let x10 = x9+r
		let x11 = x9+bw
		let x13 = x11+bw
		let x12 = x13-r
		let x14 = x13+r

		let y1 = p
		let y2 = y1+q
		let y3 = y2+q
		let y4 = h/2
		let y5 = h-p
		let y6 = y1+r
		let y7 = y6+r
		
		expandedSize = CGSize(width: w/Oo.s, height: h/Oo.s)
		contractedSize = CGSize(width: (x14+p)/Oo.s, height: (y7+p)/Oo.s)

		var path = CGMutablePath()
		path.move(to: CGPoint(x: x9, y: y6))
		path.addArc(tangent1End: CGPoint(x: x8, y: y1), tangent2End: CGPoint(x: x11, y: y1), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x14, y: y1), tangent2End: CGPoint(x: x13, y: y6), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x12, y: y7), tangent2End: CGPoint(x: x11, y: y7), radius: or)
		path.addArc(tangent1End: CGPoint(x: x10, y: y7), tangent2End: CGPoint(x: x9, y: y6), radius: or)
		path.closeSubpath()
		
		aetherButton.frame = CGRect(x: 0, y: 0, width: x14+p, height: y7+p)
		aetherButton.path = path

		aetherList.rowHeight = 26*Oo.s
		aetherList.contentInset = UIEdgeInsets(top: y3+2*Oo.s, left: 0, bottom: 0, right: 0)
		
		path = CGMutablePath()
		path.move(to: CGPoint(x: x1, y: y4))
		path.addArc(tangent1End: CGPoint(x: x1-c, y: y1+c), tangent2End: CGPoint(x: x2-c, y: y2+c), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x3-c, y: y3+c), tangent2End: CGPoint(x: x4  , y: y3+c), radius: or)
		path.addArc(tangent1End: CGPoint(x: x5+c, y: y3+c), tangent2End: CGPoint(x: x6+c, y: y2+c), radius: or)
		path.addArc(tangent1End: CGPoint(x: x7+c, y: y1+c), tangent2End: CGPoint(x: x7+c, y: y4), radius: ir)
		path.addArc(tangent1End: CGPoint(x: x7+c, y: y5-c), tangent2End: CGPoint(x: x4  , y: y5-c), radius: rr)
		path.addArc(tangent1End: CGPoint(x: x1  , y: y5-c), tangent2End: CGPoint(x: x1  , y: y4), radius: rr)
		path.closeSubpath()
		
		listMask.frame = CGRect(x: 0, y: 0, width: x7+p, height: y5+p)
		aetherList.frame = listMask.bounds
		listMask.path = path
		
		aetherList.reloadData()
	}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		let p: CGFloat = 2*Oo.s
		let q: CGFloat = 13*Oo.s
		let sp: CGFloat = 4*Oo.s
		let bw: CGFloat = 60*Oo.s
		let lw: CGFloat = 18*Oo.s
		let h: CGFloat = 216*Oo.s
		let sq: CGFloat = sp*sqrt(2)
		let r: CGFloat = q-sp/2
		let w: CGFloat = 3*sq+2*lw+2*bw+2*r+2*p
//		let c: CGFloat = 1
		
		let ir: CGFloat = 2*Oo.s
		let or: CGFloat = 8*Oo.s
		let rr: CGFloat = 4*Oo.s
		
		let x1 = p
		let x2 = x1+q
		let x3 = x2+q
		let x4 = w/2
		let x7 = w-p
		let x6 = x7-q
		let x5 = x6-q
		
		let x8 = x1+sq
		let x9 = x8+r
//		let x10 = x9+r
		let x11 = x9+bw
		let x13 = x11+bw
		let x12 = x13-r
//		let x14 = x13+r
		
		let x15 = x12+sq
		let x16 = x15+r
		let x17 = x16+r
		let x18 = x16+lw
		let x20 = x18+lw
		let x19 = x20-r
		let x21 = x20+r
		
		let y1 = p
		let y2 = y1+q
		let y3 = y2+q
		let y4 = h/2
		let y5 = h-p
		let y6 = y1+r
		let y7 = y6+r
		
		var path = CGMutablePath()
//		path.move(to: CGPoint(x: x9, y: y6))
//		path.addArc(tangent1End: CGPoint(x: x8, y: y1), tangent2End: CGPoint(x: x11, y: y1), radius: ir)
//		path.addArc(tangent1End: CGPoint(x: x14, y: y1), tangent2End: CGPoint(x: x13, y: y6), radius: ir)
//		path.addArc(tangent1End: CGPoint(x: x12, y: y7), tangent2End: CGPoint(x: x11, y: y7), radius: or)
//		path.addArc(tangent1End: CGPoint(x: x10, y: y7), tangent2End: CGPoint(x: x9, y: y6), radius: or)
//		path.closeSubpath()

		if expanded {
			path.move(to: CGPoint(x: x16, y: y6))
			path.addArc(tangent1End: CGPoint(x: x17, y: y1), tangent2End: CGPoint(x: x18, y: y1), radius: or)
			path.addArc(tangent1End: CGPoint(x: x21, y: y1), tangent2End: CGPoint(x: x20, y: y6), radius: ir)
			path.addArc(tangent1End: CGPoint(x: x19, y: y7), tangent2End: CGPoint(x: x18, y: y7), radius: or)
			path.addArc(tangent1End: CGPoint(x: x15, y: y7), tangent2End: CGPoint(x: x16, y: y6), radius: ir)
			path.closeSubpath()
		}
		
		Skin.aetherPicker(path: path)
		
		if expanded {
			path = CGMutablePath()
			path.move(to: CGPoint(x: x1, y: x4))
			path.addArc(tangent1End: CGPoint(x: x1, y: y1), tangent2End: CGPoint(x: x2, y: y2), radius: ir)
			path.addArc(tangent1End: CGPoint(x: x3, y: y3), tangent2End: CGPoint(x: x4, y: y3), radius: or)
			path.addArc(tangent1End: CGPoint(x: x5, y: y3), tangent2End: CGPoint(x: x6, y: y2), radius: or)
			path.addArc(tangent1End: CGPoint(x: x7, y: y1), tangent2End: CGPoint(x: x7, y: y4), radius: ir)
			path.addArc(tangent1End: CGPoint(x: x7, y: y5), tangent2End: CGPoint(x: x4, y: y5), radius: rr)
			path.addArc(tangent1End: CGPoint(x: x1, y: y5), tangent2End: CGPoint(x: x1, y: y4), radius: rr)
			path.closeSubpath()
			
			Skin.bubble(path: path, uiColor: UIColor.orange, width: 4.0/3.0*Oo.s)

			let pen: Pen = Pen(font: UIFont(name: "HelveticaNeue", size: 14*Oo.s)!)
			pen.color = UIColor.green
			pen.alignment = .center
			Skin.panel(text: NSLocalizedString("new", comment: ""), rect: CGRect(x: x16, y: y1+2.5, width: x20-x16, height: y7-y1), pen: pen)
		}
		
//		UIColor* color = [UIColor greenColor];
//		if (![Oovium aetherView].readOnly || _expanded)
//		[[Oovium skin] panelText:(_expanded?NSLocalizedString(@"new",@""):@"\u22C5\u22C5\u22C5") rect:CGRectMake(x16,y1+2,x20-x16,y7-y1) color:color font:[UIFont systemFontOfSize:s*14] align:NSTextAlignmentCenter field:OOFieldNone];
//		[[Oovium skin] panelText:[[Oovium currentAether] name] rect:CGRectMake(x9,y1+3,x13-x9,y7-y1) color:color font:[UIFont systemFontOfSize:s*14] align:NSTextAlignmentCenter field:OOFieldNone];
	}
	
// UITableViewDelegate =============================================================================
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			print("delete")
		}
	}
	
// UITableViewDataSource ===========================================================================
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return aetherNames.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: AetherCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! AetherCell
		cell.aetherName = aetherNames[indexPath.row]
		return cell
	}
}
