//
//  UIColor+AE.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

extension UIColor {
	func alpha(_ alpha: CGFloat) -> UIColor {
		return withAlphaComponent(alpha)
	}
}
