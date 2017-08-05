//
//  CronBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class CronMaker: Maker {
	
	// Maker ===========================================================================================
	func icon() -> UIImage {
		return UIImage()
	}
	func make(aether: Aether, at: V2) -> Bubble {
		let cron = aether.createCron(at: at)
		return CronBub(cron)
	}
}

class CronBub: Bubble {
	let cron: Cron
	
	init(_ cron: Cron) {
		self.cron = cron
		super.init(hitch: .center, origin: CGPoint(x: self.cron.x, y: self.cron.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
