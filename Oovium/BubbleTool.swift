//
//  BubbleTool.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class BubbleTool: Tool {
	let maker: Maker
	
	init(maker: Maker) {
		self.maker = maker
		super.init(frame: CGRect.zero)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
	lazy var image: UIImage = {
		UIGraphicsBeginImageContextWithOptions(CGSize(width: 40, height: 40), false, 0.0)
		
		self.maker.drawIcon()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image!
	}()

// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		image.draw(at: CGPoint.zero)
	}
}
