//
//  Task.swift
//  Oovium
//
//  Created by Joe Charlier on 12/25/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Task: NSObject {
	let name: String
//	let task: (Memory)->(Int?)
	
	public init (name: String/*, task: @escaping (Memory)->(Int?)*/) {
		self.name = name
//		self.task = task
	}
	
	func execute (_ memory: Memory) -> Int? {
		return nil
//		return task(memory)
	}
}
