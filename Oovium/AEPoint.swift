//
//  AEPoint.swift
//  Oovium
//
//  Created by Joe Charlier on 4/8/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

enum AEPoint {
	case center, top, bottom, left, right, topLeft, topRight, bottomLeft, bottomRight
	
	func isRight() -> Bool {
		return self == .topRight || self == .right || self == .bottomRight
	}
	func isLeft() -> Bool {
		return self == .topLeft || self == .left || self == .bottomLeft
	}
	func isTop() -> Bool {
		return self == .topLeft || self == .top || self == .topRight
	}
	func isBottom() -> Bool {
		return self == .bottomLeft || self == .bottom || self == .bottomRight
	}
}
