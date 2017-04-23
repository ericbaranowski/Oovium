//
//  Hovers.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class Hovers {
	static let window = UIApplication.shared.keyWindow!
	
	static var invoked = [Hover]()
	
	static func invoke (hover: Hover) {
		Hovers.invoked.append(hover)
		hover.alpha = 0
		Hovers.window.addSubview(hover)
		UIView.animate(withDuration: 0.2) {
			hover.alpha = 1
		}
	}
	static func dismiss (hover: Hover) {
		UIView.animate(withDuration: 0.2, animations: { 
			hover.alpha = 0
		}) { (canceled: Bool) in
			hover.removeFromSuperview();
			Hovers.invoked.remove(at: Hovers.invoked.index(of: hover)!)
		}
		
	}
	
	static var chainEditor: ChainEditor = {
		return ChainEditor()
	}()
}
