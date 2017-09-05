//
//  Shape.swift
//  Oovium
//
//  Created by Joe Charlier on 8/7/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

@objc enum OOShape: Int {
	case ellipse, rounded, rectangle, diamond

	static let ellipseShape_ = EllipseShape()
	static let roundedShape_ = RoundedShape()
	static let rectangleShape_ = RectangleShape()
	static let diamondShape_ = DiamondShape()
	
	var shape: Shape {
		switch self {
			case .ellipse:
				return OOShape.ellipseShape_
			case .rounded:
				return OOShape.roundedShape_
			case .rectangle:
				return OOShape.rectangleShape_
			case .diamond:
				return OOShape.diamondShape_
		}
	}
}

class Shape {
	func drawIcon(color: UIColor) {}
	func bounds(size: CGSize) -> CGRect {return CGRect.zero}
	func draw(rect: CGRect, uiColor: UIColor) {}
}
