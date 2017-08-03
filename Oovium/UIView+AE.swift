//
//  UIView+AE.swift
//  Aexels
//
//  Created by Joe Charlier on 2/18/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

public extension UIView {
	
	private var parent: CGSize {
		if let parent = superview {
			return parent.bounds.size
		} else {
			return UIScreen.main.bounds.size
		}
	}
	
	public func center (offset: UIOffset, size: CGSize) {
		self.frame = CGRect(x: (parent.width-size.width)/2+offset.horizontal, y: (parent.height-size.height)/2+offset.vertical, width: size.width, height: size.height)
	}
	public func right (offset: UIOffset, size: CGSize) {
		self.frame = CGRect(x: parent.width-size.width+offset.horizontal, y: (parent.height-size.height)/2+offset.vertical, width: size.width, height: size.height)
	}
	public func left (offset: UIOffset, size: CGSize) {
		self.frame = CGRect(x: offset.horizontal, y: (parent.height-size.height)/2+offset.vertical, width: size.width, height: size.height)
	}
	public func top (offset: UIOffset, size: CGSize) {
		self.frame = CGRect(x: (parent.width-size.width)/2+offset.horizontal, y: offset.vertical, width: size.width, height: size.height)
	}
	public func bottom (offset: UIOffset, size: CGSize) {
		self.frame = CGRect(x: (parent.width-size.width)/2+offset.horizontal, y: parent.height-size.height+offset.vertical, width: size.width, height: size.height)
	}
	public func topLeft (offset: UIOffset, size: CGSize) {
		self.frame = CGRect(x: offset.horizontal, y: offset.vertical, width: size.width, height: size.height)
	}
	public func topRight (offset: UIOffset, size: CGSize) {
		self.frame = CGRect(x: parent.width-size.width+offset.horizontal, y: offset.vertical, width: size.width, height: size.height)
	}
	public func bottomLeft (offset: UIOffset, size: CGSize) {
		self.frame = CGRect(x: offset.horizontal, y: parent.height-size.height+offset.vertical, width: size.width, height: size.height)
	}
	public func bottomRight (offset: UIOffset, size: CGSize) {
		self.frame = CGRect(x: parent.width-size.width+offset.horizontal, y: parent.height-size.height+offset.vertical, width: size.width, height: size.height)
	}
	
	public var top: CGFloat {
		return frame.origin.y
	}
	public var bottom: CGFloat {
		return frame.origin.y + frame.size.height
	}
	public var left: CGFloat {
		return frame.origin.x
	}
	public var right: CGFloat {
		return frame.origin.x + frame.size.width
	}
	public var width: CGFloat {
		return bounds.size.width
	}
	public var height: CGFloat {
		return bounds.size.height
	}
}
