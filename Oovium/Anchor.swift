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
	
	override public init(iden: Int) {
		super.init(iden: iden)
	}
	public required init(attributes: [String:Any]) {
		let iden: Int = attributes["iden"] as! Int
		
		super.init(iden: iden)
	}
	public required init(attributes: [String:Any], parent: Domain) {fatalError()}
//	public required init() {
//		super.init()
//	}
//	public required init (basket: Basket) {
//		self.basket = basket
//		super.init()
//	}
//	
//	public required init(iden: Int, type: String, attributes: [String : Any]) {
//		fatalError("init(iden:type:attributes:) has not been implemented")
//	}
}
