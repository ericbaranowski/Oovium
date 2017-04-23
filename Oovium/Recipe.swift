//
//  Recipe.swift
//  Oovium
//
//  Created by Joe Charlier on 10/9/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class RecipeS: CustomStringConvertible {
	private var tasks: [Task]
	
	public init() {
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
	func removeLast() {
		tasks.removeLast()
	}
	
	public func execute (_ memory: UnsafeMutablePointer<Memory>) {
//		let A = (memory.get(2) as! RealObj).x
//		let B = (memory.get(3) as! RealObj).x
//		let C = (memory.get(4) as! RealObj).x
//		let D = (memory.get(5) as! RealObj).x
//		let E = (memory.get(6) as! RealObj).x
//		let F = (memory.get(7) as! RealObj).x
//		let G = (memory.get(8) as! RealObj).x
//		let H = (memory.get(9) as! RealObj).x
//		let SELF: RealObj = memory.get(10) as! RealObj
//		let SUM = A+B+C+D+E+F+G+H
////		memory[0] = SUM == 2 ? SELF : (SUM == 3 ? Web.one : Web.zero)
//		memory.set(0, obj: SUM == 2 ? SELF : (SUM == 3 ? Web.one : Web.zero))
		
		var tp = 0
		while tp < tasks.count {
			tp = tasks[tp].execute(memory: memory) ?? tp+1
		}
	}
	public func compile() -> UnsafeMutablePointer<Recipe> {
		let recipe: UnsafeMutablePointer<Recipe> = AERecipeCreate(tasks.count)!
		var i: Int = 0
		for task in tasks {
			switch task.type {
				case .lambda:
					recipe.pointee.tasks[i] = AETaskCreateLambda((task as! LambdaTask).lambda)
				case .goto:
					recipe.pointee.tasks[i] = AETaskCreateGoto(UInt8((task as! GotoTask).goto))
				case .ifGoto:
					recipe.pointee.tasks[i] = AETaskCreateIfGoto(UInt8((task as! IfGotoTask).index), UInt8((task as! IfGotoTask).goto))
				case .fork:
					recipe.pointee.tasks[i] = AETaskCreateFork(UInt8((task as! ForkTask).ifIndex), UInt8((task as! ForkTask).thenIndex), UInt8((task as! ForkTask).elseIndex), UInt8((task as! ForkTask).resultIndex))
			}
			i += 1
		}
		return recipe
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
