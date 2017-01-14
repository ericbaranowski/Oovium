//
//  Edge.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

final class Edge: Domain {
	var textID: Int = 0

// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["textID"]
	}
}
