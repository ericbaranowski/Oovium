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
	static var aetherView: AetherView!

	static func start() {
		Math.start()
		
		window_ = UIWindow(frame: UIScreen.main.bounds)
		window_.makeKeyAndVisible()

		if !Local.hasAether(name: "Apple") {
			var aether = Aether()
			aether.name = "Apple"
			Local.storeAether(aether: aether)
			
			aether = Aether()
			aether.name = "Banana"
			Local.storeAether(aether: aether)
			
			aether = Aether()
			aether.name = "Coconut"
			Local.storeAether(aether: aether)
		}

		let currentAether = Storage.get(key: "currentAether") ?? {
			let name = "Banana"
			Storage.set(key: "currentAether", value: name)
			return name
		}()
		
		let aether = Local.loadAether(name: currentAether)
		aetherView = AetherView(aether: aether)
		
		window_.rootViewController = OoviumController(aetherView: aetherView)
		
		Hovers.initialize()
		Hovers.invokeRedDot()
		Hovers.invokeBubbleToolBar()
		Hovers.invokeAetherPicker()
	}
}
