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
	public var recipe: Recipe!
	
	var towers: Set<Tower>!
	
	public init (head: Tower, tail: Tower) {
		self.head = head
		self.tail = tail
		
	}

	public func weave (_ memory: Memory) {
		towers = head.towersDestined(for: self.tail)
		
		recipe = Recipe()
		
		var memory: Memory = Memory([])
		var progress: Bool
		repeat {
			progress = false
			
			for tower in towers {
				if tower.ping(memory) == .progress {
					progress = true
					recipe.add(tower.task!)
				}
			}
			
		} while (progress)
		
		//		print("\(recipe)")
	}
	
	public func execute (_ memory: Memory) -> Obj {
		return recipe.execute(memory)
	}
	
// CustomStringConvertible =========================================================================
	override public var description: String {
		var sb = String()
		sb.append("[ Web ====================================== ]\n")
		var i = 0
		for tower in towers  {
			let name = tower.task!.name
			sb.append("  \(name)\n")
			i += 1
		}
//		sb.append("[ ========================================== ]\n")
		return sb
	}
}
