//
//  AetherView.swift
//  Oovium
//
//  Created by Joe Charlier on 4/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

public class AetherView: UIScrollView {
	var aether: Aether
	var maker: Maker = ObjectMaker()
	var bubbles: [Bubble] = [Bubble]()
	var currentlyEditing: Chain?
	
	public init(aether: Aether) {
		self.aether = aether
		
		super.init(frame: CGRect.zero)
		
		showsVerticalScrollIndicator = false
		showsHorizontalScrollIndicator = false
		
		var gesture = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(_:)))
		gesture.numberOfTapsRequired = 2
		addGestureRecognizer(gesture)
		
		gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
		addGestureRecognizer(gesture)
	}
	public required init? (coder aDecoder: NSCoder) {fatalError()}
	
	func addBubble(_ bubble: Bubble) {
		bubbles.append(bubble)
		addSubview(bubble)
		bubble.aetherView = self
		stretch()
	}
	func removeBubble(_ bubble: Bubble) {
		if let i = bubbles.index(of: bubble) {
			bubbles.remove(at: i)
		}
		bubble.removeFromSuperview()
		bubble.aetherView = nil
		stretch()
	}
	func removeAllBubbles() {
		for bubble in bubbles {
			bubble.aetherView = nil
			bubble.removeFromSuperview()
		}
		bubbles.removeAll()
	}
	
	func loadAether(name: String) {
		Local.storeAether(aether: aether)
		removeAllBubbles()
		
		aether = Local.loadAether(name: name)
		Hovers.aetherPicker_.aetherButton.setNeedsDisplay()
		Hovers.retractAetherPicker()
		Storage.set(key: "currentAether", value: name)
		
		for aexel in aether.aexels {
			switch aexel.type {
				case "object":	addBubble(ObjectBub(aexel as! Object))
				case "gate":	addBubble(GateBub(aexel as! Gate))
				case "mech":	addBubble(MechBub(aexel as! Mech))
				case "tail":	addBubble(TailBub(aexel as! Tail))
				case "auto":	addBubble(AutoBub(aexel as! Auto))
				case "grid":	addBubble(GridBub(aexel as! Grid))
				case "type":	addBubble(TypeBub(aexel as! Type))
				case "miru":	addBubble(MiruBub(aexel as! Miru))
				case "cron":	addBubble(CronBub(aexel as! Cron))
				case "text":	addBubble(TextBub(aexel as! Text))
				case "also":	addBubble(AlsoBub(aexel as! Also))
				default:		print("invalid type")
			}
		}
		stretch()
	}
	
// Stretch =========================================================================================
	func homing(current: CGFloat, extent: CGFloat) -> CGFloat {
		return min(max(current, 0), extent)
	}
	func stretch(animated: Bool) {
		let wx = width
		let wy = height
		
		guard bubbles.count > 0 else {
			contentSize = CGSize(width: wx, height: wy)
			contentOffset = CGPoint.zero
			return
		}
		
		var maxLeft: CGFloat = 0
		var minRight: CGFloat = CGFloat.greatestFiniteMagnitude
		var maxTop: CGFloat = 0
		var minBottom: CGFloat = CGFloat.greatestFiniteMagnitude

		for bubble in bubbles {
			maxLeft	  = max(maxLeft,   bubble.left + max(0, bubble.width-124))
			minRight  = min(minRight,  bubble.left + min(bubble.width, 120))
			maxTop	  = max(maxTop,	   bubble.top + max(0, bubble.height-70))
			minBottom = min(minBottom, bubble.top + min(bubble.height, 66))
		}
		
		let offset = contentOffset
		contentSize = CGSize(width: wx*2+maxLeft-minRight, height: wy*2+maxTop-minBottom)
		let dx = minRight-wx
		let dy = minBottom-wy
		for bubble in bubbles {
			bubble.frame = CGRect(x: bubble.left-dx, y: bubble.top-dy, width: bubble.width, height: bubble.height)
		}
//		for doodle in doodles {
//			doodle.frame = CGRect(x: doodle.left-dx, y: doodle.top-dy, width: doodle.width, height: doodle.height)
//		}
		contentOffset = CGPoint(x: offset.x-dx, y: offset.y-dy)
		setContentOffset(CGPoint(x: homing(current: offset.x-dx, extent: wx+maxLeft-minRight), y: homing(current: offset.y-dy, extent: wy+maxTop-minBottom)), animated: animated)
	}
	func stretch() {
		stretch(animated: true)
	}
	
// Events ==========================================================================================
	func onTap() {
		Hovers.retract()
	}
	func onDoubleTap (_ gesture: UITapGestureRecognizer) {
		let origin = gesture.location(in: self)
		let bubble = maker.make(aether:aether, at:V2(Double(origin.x), Double(origin.y)))
		addBubble(bubble)
		bubble.create()
		Hovers.bubbleToolBar_.recoil()
	}
}
