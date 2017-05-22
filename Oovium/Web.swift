//
//  Web.swift
//  Oovium
//
//  Created by Joe Charlier on 12/25/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Web: CustomStringConvertible {
	let head: Tower
	let tail: Tower
	
	var towers: Set<Tower>
	public var recipe: UnsafeMutablePointer<Recipe>!
//	public var recipeS: RecipeS
	
	public init (head: Tower, tail: Tower, memory: UnsafeMutablePointer<Memory>) {
		self.head = head
		self.tail = tail
		
		towers = head.towersDestined(for: self.tail)
		Tower.printTowers(towers)

		let certain = head.towersStronglylinked(for: self.tail)
		Tower.printTowers(certain)
		recipe = compile(memory: memory)
		AERecipePrint(recipe);
		
		print("\(memory)")
		print("\(recipe)")
	}
	
	func compile (memory: UnsafeMutablePointer<Memory>) -> UnsafeMutablePointer<Recipe> {
		var tasks = [UnsafeMutablePointer<Task>]()
		let spider = Spider(memory: memory, needed: head.towersStronglylinked(for: self.tail))
		_ = program(tasks: &tasks, memory: memory, towers: spider.needed, spider: spider, n: 0)
		let recipe = AERecipeCreate(tasks.count)!
		var i = 0
		for task in tasks {
			recipe.pointee.tasks[i] = task
			i += 1
		}
		return recipe
	}
	
	func program (tasks: inout [UnsafeMutablePointer<Task>], memory: UnsafeMutablePointer<Memory>, towers: Set<Tower>, spider: Spider, n: Int) -> Int {
		var spider = spider
		var n = n
		var progress: Bool
		
		repeat {
			progress = false
			
			for tower in towers {
				guard tower.ping(&spider) else {continue}

				progress = true
				tasks.append(tower.task!)
				n += 1
				
				guard tower.gateTo != nil else {continue}
				
				let ifGotoIndex = n
				tasks.append(AETaskCreateIfGoto(0, 0))
				n += 1
				var oldN = n
				var newTowers = head.towersStronglylinked(for: self.tail, override: tower.thenTo)
				var newSpider = Spider(memory: memory, needed: spider.needed.union(newTowers))
				n = program(tasks: &tasks, memory: memory, towers: newTowers.subtracting(spider.needed), spider: newSpider, n: n)
				if oldN != n {
					tasks[ifGotoIndex] = AETaskCreateIfGoto(AEMemoryIndexForName(memory, tower.name.toInt8()), UInt8(n+1))
					tasks[ifGotoIndex].pointee.command = "IF \(tower.name) == FALSE GOTO \(n+1)".toInt8()
				} else {
					tasks.removeLast()
					n -= 1
				}
				
				let gotoIndex = n
				tasks.append(AETaskCreateGoto(0))
				n += 1
				oldN = n
				newTowers = head.towersStronglylinked(for: self.tail, override: tower.elseTo)
				newSpider = Spider(memory: memory, needed: spider.needed.union(newTowers))
				n = program(tasks: &tasks, memory: memory, towers: newTowers.subtracting(spider.needed), spider: newSpider, n: n)
				if oldN != n {
					tasks[gotoIndex] = AETaskCreateGoto(UInt8(n))
					tasks[gotoIndex].pointee.command = "GOTO \(n)".toInt8()
				} else {
					tasks.removeLast()
					n -= 1
				}
			}
			
		} while (progress)
		
		return n
	}
	
	public func execute (_ memory: UnsafeMutablePointer<Memory>) {
		AERecipeExecute(recipe, memory)
	}

// CustomStringConvertible =========================================================================
	public var description: String {
		var sb = String()
		sb.append("[ Web ====================================== ]\n")
//		for tower in towers  {
//			if let taskS = tower.taskS {
//				sb.append("  \(taskS.label) : \(taskS.command)\n")
//			}
//		}
		sb.append("[ ========================================== ]\n\n")
		return sb
	}
}
