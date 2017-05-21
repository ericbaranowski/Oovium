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
		recipe = compile(towers: towers, memory: memory)
		
		printTowers(towers: certain)
		print("\(memory)")
		print("\(recipe)")
	}
	
	func compile (towers: Set<Tower>, memory: UnsafeMutablePointer<Memory>) -> UnsafeMutablePointer<Recipe> {
		var tasks = [UnsafeMutablePointer<Task>]()
		_ = program(tasks: &tasks, towers: towers, memory: memory, n: 0)
		let recipe = AERecipeCreate(tasks.count)!
		var i = 0
		for task in tasks {
			recipe.pointee.tasks[i] = task
			i += 1
		}
		return recipe
	}
	
	func program (tasks: inout [UnsafeMutablePointer<Task>], towers: Set<Tower>, memory: UnsafeMutablePointer<Memory>, n: Int) -> Int {
		var n = n
		var progress: Bool
		
		repeat {
			progress = false
			
			for tower in towers {
				guard tower.ping(memory) == .progress else {continue}

				progress = true
				tasks.append(tower.task!)
				n += 1
				
				guard tower.gate != nil else {continue}
				
				let ifGotoIndex = n
				tasks.append(AETaskCreateIfGoto(0, 0))
				n += 1
				var oldN = n
				var newTowers = head.towersStronglylinked(for: self.tail, override: tower.thenTo).subtracting(towers)
				n = program(tasks: &tasks, towers: newTowers, memory: memory, n: n)
				if oldN != n {
					tasks[ifGotoIndex] = AETaskCreateIfGoto(AEMemoryIndexForName(memory, tower.name.toInt8()), UInt8(n+1))
				} else {
					tasks.removeLast()
					n -= 1
				}
				
				let gotoIndex = n
				tasks.append(AETaskCreateGoto(0))
				n += 1
				oldN = n
				newTowers = head.towersStronglylinked(for: self.tail, override: tower.elseTo).subtracting(towers)
				n = program(tasks: &tasks, towers: newTowers, memory: memory, n: n)
				if oldN != n {
					tasks[gotoIndex] = AETaskCreateGoto(UInt8(n))
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

	public func printTowers (towers: Set<Tower>) {
		var sb = String()
		sb.append("[ Towers =================================== ]\n")
//		for tower in towers  {
//			if let task = tower.task {
//				sb.append("  \(taskS.label) : \(taskS.command)\n")
//			}
//		}
		sb.append("[ ========================================== ]\n\n")
		print("\(sb)")
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
