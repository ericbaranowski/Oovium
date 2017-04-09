//
//  AetherView.swift
//  Oovium
//
//  Created by Joe Charlier on 4/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

public class AetherView: UIScrollView {
	
	
	public init () {
		super.init(frame: CGRect.zero)
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(_:)))
		gesture.numberOfTapsRequired = 2
		addGestureRecognizer(gesture)
	}
	public required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	func onDoubleTap (_ gesture: UITapGestureRecognizer) {
		print("double tap")
	}
}
