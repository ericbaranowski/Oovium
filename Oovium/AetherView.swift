//
//  AetherView.swift
//  Oovium
//
//  Created by Joe Charlier on 4/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

public class AetherView: UIScrollView, UIGestureRecognizerDelegate {
	var aether: Aether
	
	var maker: Maker = ObjectMaker()
	var shape: OOShape = .ellipse
	var color: OOColor = .orange
	
	var bubbles: [Bubble] = [Bubble]()
	var currentlyEditing: Chain?
	
	var editing: Editable? = nil
	var anchored: Bool = false
	
	var selected: [Bubble] = [Bubble]()
	
	public init(aether: Aether) {
		self.aether = aether
		
		super.init(frame: UIScreen.main.bounds)
		
		openAether(aether)
		
		scrollsToTop = false
		showsVerticalScrollIndicator = false
		showsHorizontalScrollIndicator = false
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(_:)))
		tapGesture.numberOfTapsRequired = 2
		addGestureRecognizer(tapGesture)
		
		addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
		
		let anchorStart = AnchorStart(aetherView: self)
		anchorStart.delegate = self
		addGestureRecognizer(anchorStart)
		
		let anchorStop = AnchorStop(aetherView: self)
		anchorStop.delegate = self
		addGestureRecognizer(anchorStop)
		
		let anchorTap = AnchorTap(aetherView: self)
		anchorTap.delegate = self
		addGestureRecognizer(anchorTap)
		
//		NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillShow), name: .UIKeyboardWillShow, object: nil)
//		NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDidShow), name: .UIKeyboardDidShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillHide), name: .UIKeyboardWillHide, object: nil)
//		NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDidHide), name: .UIKeyboardDidHide, object: nil)
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
	
	private func closeCurrentAether() {
		aether.xOffset = Double(contentOffset.x)
		aether.yOffset = Double(contentOffset.y)
		Local.storeAether(aether: aether)
		removeAllBubbles()
	}
	private func openAether(_ aether: Aether) {
		Hovers.aetherPicker_.aetherButton.setNeedsDisplay()
		Storage.set(key: "currentAether", value: aether.name)
		
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
		setContentOffset(CGPoint(x: aether.xOffset, y: aether.yOffset), animated: false)
	}
	func swapToAether(name: String) {
		Hovers.retractAetherPicker()
		closeCurrentAether()
		aether = Local.loadAether(name: name)
		openAether(aether)
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
	
// Selected ========================================================================================
	private func selectedIsHomogeneous() -> Bool {
		let root = selected.first!
		for i in 1..<selected.count {
			if type(of: root) != type(of:selected[i]) {
				return false
			}
		}
		return true
	}
	private func invokeContext() {
		if selected.count == 0 {
//			Hovers.dis
		} else if selected.count == 1 {
			let context = selected.first!.context
			context.invoke()
		} else {
			if selectedIsHomogeneous() {
				let context = selected.first!.context
				context.invoke()
			} else {
				Hovers.multiContext.invoke()
			}
		}
	}
	func select(bubbles: [Bubble]) {
		for bubble in bubbles {
			bubble.select()
			selected.append(bubble)
		}
		invokeContext()
	}
	func select(bubble: Bubble) {
		select(bubbles: [bubble])
	}
	func unselect(bubble: Bubble) {
		bubble.unselect()
		invokeContext()
	}
	
// Events ==========================================================================================
	func onAnchorStart() {
		anchored = true
	}
	func onAnchorStop() {
		anchored = false
	}
	
	func onTap() {
		Hovers.retract()
	}
	func onDoubleTap (_ gesture: UITapGestureRecognizer) {
		let origin = gesture.location(in: self)
		let bubble = maker.make(aetherView: self, at: V2(Double(origin.x),Double(origin.y)))
		addBubble(bubble)
		bubble.create()
		Hovers.bubbleToolBar_.recoil()
	}
//	func onKeyboardWillShow() {}
//	func onKeyboardDidShow() {}
	func onKeyboardWillHide() {
		if let editing = editing {
			editing.ok()
		}
	}
//	func onKeyboardDidHide() {}
	
// UIGestureRecognizerDelegate =====================================================================
	public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
