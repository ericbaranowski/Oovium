//
//  ObjectMaker.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ObjectMaker: Maker {
	func make (origin: CGPoint) -> Bubble {
		return ObjectBub(origin: origin)
	}
	func icon () -> UIImage {
		return UIImage()
	}
}
