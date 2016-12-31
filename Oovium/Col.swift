//
//  Col.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

enum OOAggregate {
	case none, sum, average, running, count, match
}
enum OOJustify {
	case left, center, right
}

class Col: Domain {
	var name: String = ""
	var def: Def = RealDef.def
	var orderNo: Int = 0
	var tokens: String = ""
	var aggregate: OOAggregate = .none
	var justify: OOJustify = .right
	var format: String = ""
}
