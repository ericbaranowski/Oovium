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
	
	public init() {
		super.init(frame: CGRect.zero)
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(_:)))
		gesture.numberOfTapsRequired = 2
		addGestureRecognizer(gesture)		
	}
	public required init? (coder aDecoder: NSCoder) {fatalError()}
	
	func addBubble (_ bubble: Bubble) {
		addSubview(bubble)
	}
	
// Events ==========================================================================================
	func onDoubleTap (_ gesture: UITapGestureRecognizer) {
		let origin = gesture.location(in: self)
		let bubble = maker.make(aether:aether, at:V2(Double(origin.x), Double(origin.y)))
		addBubble(bubble)
		bubble.create()
	}
}
