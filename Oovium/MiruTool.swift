//
//  MiruTool.swift
//  Oovium
//
//  Created by Joe Charlier on 8/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class MiruTool: BubbleTool {
	
	init() {
		super.init(maker: MiruMaker())
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
