//
//  OOTextField.swift
//  Oovium
//
//  Created by Joe Charlier on 9/2/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class OOTextField: UITextField {
	let backColor: UIColor
	let foreColor: UIColor
	let radius: CGFloat
	
	var image: UIImage? = nil
	
	init(frame: CGRect, backColor: UIColor, foreColor: UIColor, textColor: UIColor) {
		self.backColor = backColor
		self.foreColor = foreColor
		self.radius = (frame.size.height-5)/2
		
		super.init(frame: frame)
		
		self.textColor = textColor
		font = UIFont(name: "Verdana", size: 15)
		borderStyle = .bezel
		autocapitalizationType = .none
		autocorrectionType = .no
		textAlignment = .center
		keyboardAppearance = .dark
		inputAssistantItem.leadingBarButtonGroups.removeAll()
		inputAssistantItem.trailingBarButtonGroups.removeAll()
	}
	convenience init(frame: CGRect, backColor: UIColor, foreColor: UIColor) {
		self.init(frame: frame, backColor: backColor, foreColor: foreColor, textColor: UIColor.black)
	}
	override convenience init(frame: CGRect) {
		self.init(frame: frame, backColor: UIColor(red: 0.7, green: 0.7, blue: 0.3, alpha: 1), foreColor: UIColor(red: 0.5, green: 0.5, blue: 0.1, alpha: 1))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		
		if image == nil {
			UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
			let c = UIGraphicsGetCurrentContext()!
			backColor.setFill()
			foreColor.setStroke()
			c.addPath(CGPath(roundedRect: rect.insetBy(dx: 2, dy: 2), cornerWidth: radius, cornerHeight: radius, transform: nil))
			c.drawPath(using: .fillStroke)
			image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
		}
		
		image!.draw(in: rect)
	}
	override var frame: CGRect {
		didSet {
			image = nil
		}
	}
}
