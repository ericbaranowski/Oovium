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
	public var recipeS: RecipeS
	
	public init (head: Tower, tail: Tower, memory: UnsafeMutablePointer<Memory>, memoryS: MemoryS) {
		self.head = head
		self.tail = tail
		
		towers = head.towersDestined(for: self.tail)
		Tower.printTowers(towers)
		recipeS = RecipeS()

		let certain = head.towersStronglylinked(for: self.tail)
		
		printTowers(towers: certain)
		
		print("\(memory)")
		_ = program(recipe: recipeS, towers: certain, memory: memory, memoryS: memoryS, n: 0)
		print("\(recipeS)")
	}
	
	func weave () {
		for tower in towers {tower.clear()}
//		for tower in towers {
//			
//		}
	}
	func strand (head: Tower, tail: Tower, memory: UnsafeMutablePointer<Memory>, memoryS: MemoryS) -> RecipeS {
		let recipeS = RecipeS()
		_ = program(recipe: recipeS, towers: towers, memory: memory, memoryS: memoryS, n: 0)
		return recipeS
	}
	
	func program (recipe: RecipeS, towers: Set<Tower>, memory: UnsafeMutablePointer<Memory>, memoryS: MemoryS, n: Int) -> Int {
		var n = n
		
		var progress: Bool
		repeat {
			progress = false
			
			for tower in towers {
				if tower.ping(memory) == .progress {
					progress = true
					recipeS.add(tower.task!)
					n += 1
					
					if tower.gateTo != nil {
						
						let ifGotoIndex = n
						recipeS.add(IfGotoTask(name: tower.name, index: 0, goto: 0))
						n += 1
						var oldN = n
						var newTowers = head.towersStronglylinked(for: self.tail, override: tower.thenTo).subtracting(towers)
						n = program(recipe: recipe, towers: newTowers, memory:memory, memoryS: memoryS, n:n)
						if oldN != n {
							recipeS.replace(at: ifGotoIndex, with: IfGotoTask(name: tower.name, index: memoryS.index(for: tower.name), goto: n+1))
						} else {
							recipeS.removeLast()
							n -= 1
						}
						
						let gotoIndex = n
						recipeS.add(GotoTask(goto: 0))
						n += 1
						oldN = n
						newTowers = head.towersStronglylinked(for: self.tail, override: tower.elseTo).subtracting(towers)
						n = program(recipe: recipe, towers: newTowers, memory:memory, memoryS: memoryS, n:n)
						if oldN != n {
							recipeS.replace(at: gotoIndex, with: GotoTask(goto: n))
						} else {
							recipeS.removeLast()
							n -= 1
						}
					}
				}
			}
			
		} while (progress)
		
		return n
	}

	static let zero = RealObj(0)
	static let one = RealObj(1)
	public func execute (_ memory: UnsafeMutablePointer<Memory>) {
		var m = memory
		recipeS.execute(m)
	}

	public func printTowers (towers: Set<Tower>) {
		var sb = String()
		sb.append("[ Towers =================================== ]\n")
		for tower in towers  {
			if let task = tower.task {
				sb.append("  \(task.label) : \(task.command)\n")
			}
		}
		sb.append("[ ========================================== ]\n\n")
		print("\(sb)")
	}
	
	
// CustomStringConvertible =========================================================================
	public var description: String {
		var sb = String()
		sb.append("[ Web ====================================== ]\n")
		for tower in towers  {
			if let task = tower.task {
				sb.append("  \(task.label) : \(task.command)\n")
			}
		}
		sb.append("[ ========================================== ]\n\n")
		return sb
	}
}
