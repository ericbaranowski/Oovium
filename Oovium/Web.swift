//
//  Web.swift
//  Oovium
//
//  Created by Joe Charlier on 12/25/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Web: NSObject {
	let head: Tower
	let tail: Tower
	
	var towers: Set<Tower>
	public var recipe: Recipe
	
	public init (head: Tower, tail: Tower, memory: Memory) {
		self.head = head
		self.tail = tail
		
		towers = head.towersDestined(for: self.tail)
		recipe = Recipe()

		super.init()

		let certain = head.towersStronglylinked(for: self.tail)
		
		printTowers(towers: certain)
		
		_ = program(recipe: recipe, towers: certain, memory: memory, n: 0)
	}
	
	func program (recipe: Recipe, towers: Set<Tower>, memory: Memory, n: Int) -> Int {
		var n = n
		
		var progress: Bool
		repeat {
			progress = false
			
			for tower in towers {
				if tower.ping(memory) == .progress {
					progress = true
					recipe.add(tower.task!)
					n += 1
					
					if tower.gateTo != nil {
						
						var ifGotoTask = IfGotoTask()
						recipe.add(ifGotoTask)
						n += 1
						var oldN = n
						for branch in tower.downstream {
							if branch.name?.range(of: "IFT") == nil {continue}
							let newTowers = head.towersStronglylinked(for: self.tail, override: branch).subtracting(towers)
							n = program(recipe: recipe, towers: newTowers, memory:memory, n:n)
						}
						if oldN != n {
							ifGotoTask.load(name: tower.name!, index: memory.index(for: tower.name!), goto: n+1)
						} else {
							recipe.removeLast()
							n -= 1
						}
						
						var gotoTask = GotoTask()
						recipe.add(gotoTask)
						n += 1
						oldN = n
						for branch in tower.downstream {
							if branch.name?.range(of: "IFE") == nil {continue}
							let newTowers = head.towersStronglylinked(for: self.tail, override: branch).subtracting(towers)
							n = program(recipe: recipe, towers: newTowers, memory:memory, n:n)
						}
						if oldN != n {
							gotoTask.load(goto: n)
						} else {
							recipe.removeLast()
							n -= 1
						}
					}
				}
			}
			
		} while (progress)
		
		return n
	}

	public func execute (_ memory: Memory) {
		recipe.execute(memory)
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
	override public var description: String {
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
