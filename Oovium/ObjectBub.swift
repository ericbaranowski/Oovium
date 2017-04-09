//
//  ObjectBub.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ObjectBub: Bubble {
	required init (origin: CGPoint) {
		super.init(hitch: .center, origin: origin, size: CGSize(width: 48, height: 48))
		self.backgroundColor = UIColor.green.withAlphaComponent(0.5)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	override func onCreate () {
		Hovers.sheathEditor.invoke()
	}
}
