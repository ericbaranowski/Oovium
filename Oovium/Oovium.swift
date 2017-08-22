//
//  Oovium.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import UIKit

class Oovium {
	static var window_: UIWindow!
	static var aetherView_: AetherView!
	static var aetherView: AetherView {
		set {aetherView_ = newValue}
		get {return aetherView_}
	}

	static func start() {
		Math.start()
		
		window_ = UIWindow(frame: UIScreen.main.bounds)
		window_.makeKeyAndVisible()
		
		window_.rootViewController = OoviumController()
		
		Hovers.invokeRedDot()
		Hovers.invokeBubbleToolBar()
		Hovers.invokeShapeToolBar()
		Hovers.invokeColorToolBar()
		Hovers.invokeAetherPicker()
	}
}
