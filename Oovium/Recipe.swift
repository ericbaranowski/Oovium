//
//  Recipe.swift
//  Oovium
//
//  Created by Joe Charlier on 10/9/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Recipe: NSObject {
	private let steps: [(Recipe)->()]
	private var sp: Int
	
	override public init () {
		steps = []
		sp = 0
	}
	init (steps: [(Recipe)->()]) {
		self.steps = steps
		sp = 0
	}
	
	public func apply () {}
}
