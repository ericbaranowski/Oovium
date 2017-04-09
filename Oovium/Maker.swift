//
//  Maker.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol Maker {
	func icon () -> UIImage;
	func make (origin: CGPoint) -> Bubble;
}
