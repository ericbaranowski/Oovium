//
//  OoviumController.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import UIKit

class OoviumController: UIViewController {
	let aetherView: AetherView
	
	init(aetherView: AetherView) {
		self.aetherView = aetherView
		super.init(nibName: nil, bundle: nil)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}

// UIViewController ================================================================================
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let imageView = UIImageView(image: UIImage(named: "BackiPad"))
		imageView.frame = view.bounds
		view.addSubview(imageView)
		
		aetherView.frame = view.bounds
		view.addSubview(aetherView)
		
		UIView.animate(withDuration: 8) {
			imageView.alpha = 0.2
		}
	}
}

