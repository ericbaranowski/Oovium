//
//  Satyr.swift
//  Oovium
//
//  Created by Joe Charlier on 12/27/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

class Satyr<T:Hashable> {
	var array = [Set<T>]()
	
	func union () -> Set<T> {
		var result = Set<T>()

		for set in array {
			result.formUnion(set)
		}
		return result
	}
	func intersection () -> Set<T> {
		guard array.count > 0 else {return Set<T>()}
		
		var result = array[0]
		
		for set in array {
			result.formIntersection(set)
		}
		return result
	}
	
	func incorporate (_ other: Satyr) {
		if other.array.count == 0 {return}
		
		else if other.array.count > 1 {
			var clones = [Set<T>]()
			for _ in 1..<other.array.count {
				for set in array {
					clones.append(set)
				}
			}
			array.append(contentsOf: clones)
		}
		
		var i = 0
		while i < array.count {
			for set in other.array {
				array[i].formUnion(set)
				i += 1
			}
		}
	}
}
