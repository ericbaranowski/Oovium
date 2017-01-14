//
//  Recipe.swift
//  Oovium
//
//  Created by Joe Charlier on 10/9/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Recipe {
	private var tasks: [Task]
	private var tp: Int = 0
	
	public init () {
		tasks = []
	}
	init (tasks: [Task]) {
		self.tasks = tasks
	}
	
	func add (_ task: Task) {
		tasks.append(task)
	}
	func removeLast () {
		tasks.removeLast()
	}
	
	func execute (_ memory: Memory) {
		tp = 0
		while tp < tasks.count {
			let task = tasks[tp]
			let goto = task.execute(memory)
			tp = goto ?? tp+1
		}
	}
	
	public var description: String {
		var sb = String()
		sb.append("[ Recipe ============================================= ]\n")
		var i = 0
		for task in tasks  {
			let index = String(format: "%2d", i)
			let label = String(format: "%12s", (task.label as NSString).utf8String!)
			let command = String(format: "%-32s", (task.command as NSString).utf8String!)
			sb.append("  \(index)> \(label) : \(command)\n")
			i += 1
		}
		sb.append("[ ==================================================== ]\n\n")
		return sb
	}
}
