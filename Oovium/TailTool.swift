//
//  TailTool.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class TailTool: BubbleTool {
	
	init() {
		super.init(maker: TailMaker())
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
