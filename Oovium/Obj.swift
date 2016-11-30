//
//  Obj.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Obj: NSObject {
	let def: Def
	var dims: [Dim]
	
	init (def: Def, dims: [Dim]) {
		self.def = def
		self.dims = dims
	}
}
