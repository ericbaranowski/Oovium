//
//  Recipe.swift
//  Oovium
//
//  Created by Joe Charlier on 10/9/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Recipe: CustomStringConvertible {
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
	func replace (at: Int, with task: Task) {
		tasks[at] = task
	}
	func removeLast () {
		tasks.removeLast()
	}
	
	func execute (_ memory: inout Memory) {
//		let A = (memory[2] as! RealObj).x
//		let B = (memory[3] as! RealObj).x
//		let C = (memory[4] as! RealObj).x
//		let D = (memory[5] as! RealObj).x
//		let E = (memory[6] as! RealObj).x
//		let F = (memory[7] as! RealObj).x
//		let G = (memory[8] as! RealObj).x
//		let H = (memory[9] as! RealObj).x
//		let SELF: RealObj = memory[10] as! RealObj
//		let SUM = A+B+C+D+E+F+G+H
//		memory.mimic(0, obj: SUM == 2 ? SELF : (SUM == 3 ? Web.one : Web.zero))
		tp = 0
		while tp < tasks.count {
			tp = tasks[tp].execute(memory: &memory) ?? tp+1
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
