//
//  Maker.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

protocol Maker {
	func make (origin: CGPoint) -> Bubble;
	func icon () -> UIImage;
}
