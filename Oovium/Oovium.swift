//
//  Oovium.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import UIKit

class Oovium: NSObject {
	static var window_: UIWindow!

	static func start () {
		print("Oovium =============================================================================")
		window_ = UIWindow(frame: UIScreen.main.bounds)
		window_.makeKeyAndVisible()
		window_.backgroundColor = UIColor.red
		
		window_.rootViewController = ViewController()
		
	}
}
