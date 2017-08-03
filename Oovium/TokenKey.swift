//
//  TokenKey.swift
//  Oovium
//
//  Created by Joe Charlier on 4/10/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

class TokenKey: Key {
	let token: Token
	
//	init (token: Token) {
//		self.token = token
//		super.init(te)
//	}
	required init?(coder aDecoder: NSCoder) {fatalError()}
}
