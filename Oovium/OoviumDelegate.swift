//
//  OoviumDelegate.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Crashlytics
import Fabric
import UIKit

@UIApplicationMain
class OoviumDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		print("==================== [ Oovium ] =============================================")

		Fabric.with([Crashlytics.self])
		Oovium.start()

		return true
	}

//	func applicationWillResignActive(_ application: UIApplication) {}
//	func applicationDidEnterBackground(_ application: UIApplication) {}
//	func applicationWillEnterForeground(_ application: UIApplication) {}
//	func applicationDidBecomeActive(_ application: UIApplication) {}
//	func applicationWillTerminate(_ application: UIApplication) {}
}
