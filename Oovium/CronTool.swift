//
//  CronTool.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class CronTool: BubbleTool {
	
	init() {
		super.init(maker: CronMaker())
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
