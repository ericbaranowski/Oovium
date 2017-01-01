//
//  Anchor.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Anchor: Domain {
	var basket: Basket!
	
	public required init () {
		super.init()
	}
	public required init (basket: Basket) {
		self.basket = basket
		super.init()
	}
}
