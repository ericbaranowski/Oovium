//
//  String+MH.swift
//  Oovium
//
//  Created by Joe Charlier on 2/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

public extension String {
	var length : Int {
		return self.characters.count
	}
	subscript (i: Int) -> Character {
		return self[index(startIndex, offsetBy: i)]
	}
	subscript (r: CountableClosedRange<Int>) -> String {
		let start = index(self.startIndex, offsetBy: r.lowerBound)
		let end = index(startIndex, offsetBy: r.upperBound)
		return self[start...end]
	}
}
