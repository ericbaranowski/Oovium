//
//  AetherView.swift
//  Oovium
//
//  Created by Joe Charlier on 4/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

public class AetherView: UIScrollView {
	var aether: Aether = Aether()
	var maker: Maker = ObjectMaker()
	var bubbles: [Bubble] = [Bubble]()
	
	public init() {
		super.init(frame: CGRect.zero)
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(_:)))
		gesture.numberOfTapsRequired = 2
		addGestureRecognizer(gesture)		
	}
	public required init? (coder aDecoder: NSCoder) {fatalError()}
	
	func addBubble (_ bubble: Bubble) {
		bubbles.append(bubble)
		addSubview(bubble)
		bubble.aetherView = self
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
	
	//	[self setContentOffset:CGPointMake(offset.x-dx,offset.y-dy)];
	//	[self setContentOffset:CGPointMake([AetherView homing:offset.x-dx extend:wx+maxLeft-minRight],[AetherView homing:offset.y-dy extend:wy+maxTop-minBottom-20]) animated:animate];
	
// Events ==========================================================================================
	func onDoubleTap (_ gesture: UITapGestureRecognizer) {
		let origin = gesture.location(in: self)
		let bubble = maker.make(aether:aether, at:V2(Double(origin.x), Double(origin.y)))
		addBubble(bubble)
		bubble.create()
	}
}
