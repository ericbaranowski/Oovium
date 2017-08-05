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
}

