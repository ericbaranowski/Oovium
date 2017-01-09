//
//  Task.swift
//  Oovium
//
//  Created by Joe Charlier on 12/25/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Task {
	var label: String
	var command: String
	var task: ((Memory)->(Int?))!
	
	init () {
		label = ""
		command = ""
	}
	public init (label: String, command: String) {
		self.label = label
		self.command = command
	}
	
	func execute (_ memory: Memory) -> Int? {
		if let task = task {
			return task(memory)
		}
		return nil
	}
	func calculate (_ memory: Memory) -> TowerState {
		task(memory)
		return .calced
	}
}

public class GotoTask: Task {
	func load (goto: Int) {
		label = ""
		command = "GOTO \(goto)"
		task = { (memory: Memory) -> (Int?) in
			return goto
		}
	}
}

public class IfGotoTask: Task {
	func load (name: String, index: Int, goto: Int) {
		label = ""
		command = "IF \(name) == FALSE THEN GOTO \(goto)"
		task = { (memory: Memory) -> (Int?) in
			if memory[index]!.value != 0 {return nil}
			return goto
		}
	}
}

public class LambdaTask: Task {
	public func load (label: String, command: String, lambda: Lambda) {
		self.label = label
		self.command = command
		task = { (memory: Memory)->(Int?) in
			memory.mimic(lambda.vi, obj: lambda.evaluate(memory))
			return nil
		}
	}
}

public class ForkTask: Task {
	public func load (ifIndex: Int, thenIndex: Int, elseIndex: Int, resultIndex: Int) {
		task = { (memory: Memory)->(Int?) in
			if memory[ifIndex]?.value != 0 {
				memory.mimic(resultIndex, obj: memory[thenIndex]!)
			} else {
				memory.mimic(resultIndex, obj: memory[elseIndex]!)
			}
			return nil
		}
	}
}
