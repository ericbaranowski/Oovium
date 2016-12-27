//
//  Recipe.swift
//  Oovium
//
//  Created by Joe Charlier on 10/9/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Recipe: NSObject {
	private var tasks: [Task]
	private var tp: Int = 0
	
	override public init () {
		tasks = []
	}
	init (tasks: [Task]) {
		self.tasks = tasks
	}
	
	func add (_ task: Task) {
		tasks.append(task)
	}
	
	func execute (_ memory: Memory) -> Obj {
		tp = 0
		while tp < tasks.count {
			let task = tasks[tp]
			let goto = task.execute(memory)
			tp = goto ?? tp+1
		}
		return RealObj(0)
	}
	
	override public var description: String {
		var sb = String()
		sb.append("[ Recipe =================================== ]\n")
		var i = 0
		for task in tasks  {
			let index = String(format: "%2d", i)
			let name = task.name
			sb.append("  [\(index)][\(name)]\n")
			i += 1
		}
		return sb
	}
}
