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
	
	static var sheathEditor: SheathEditor = {
		return SheathEditor()
	}()
}
