//
//  Memory.swift
//  Oovium
//
//  Created by Joe Charlier on 12/11/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public class Memory: NSObject {
	var index = [String:Int]()
	public var slots = [Slot]()
	
	public init (_ names: [String]) {
		super.init()
		for name in names {
			append(name:name)
		}
	}
	
	public subscript (i: Int) -> Obj? {
		get {
			return slots[i].value
		}
	}
	public subscript (name: String) -> Obj? {
		get {
			if let i = index[name] {
				return slots[i].value
			} else {
				return nil
			}
		}
	}
	
	public func mimic (_ i: Int, obj: Obj) {
		let slot = slots[i]
		slot.value.mimic(obj)
		slot.loaded = true
	}
	
	public func fix (_ i: Int, obj:Obj) {
		let slot = slots[i]
		slot.value = obj
		slot.fixed = true
	}
	
	func append (slot: Slot) {
		index[slot.name] = slots.count
		slots.append(slot)
	}
	func append (name: String) {
		append(slot:Slot(name))
	}
	
	public func index (for name: String) -> Int {
		if let n = index[name] {
			return n
		} else {
			return -1
		}
	}
	
	public func isLoaded (_ i: Int) -> Bool {
		return slots[i].loaded
	}
	public func load (_ i: Int, with value: Obj) {
		slots[i].loaded = true
		slots[i].value = value
	}

	public func clear () {
		for slot in slots {
			slot.clear()
		}
	}
	public var count: Int {
		return slots.count
	}
	
// CustomStringConvertible =========================================================================
	override public var description: String {
		var sb = String()
		sb.append("[ Memory ==================== ]\n")
		var i = 0
		for slot in slots  {
			let index = String(format: "%2d", i)
			let set = slot.fixed ? "O" : " "
			let loaded = slot.loaded ? "O" : " "
			let name = slot.name.padding(toLength: 12, withPad: " ", startingAt: 0)
			let value = slot.loaded ? "\(slot.value)" : "-"
			sb.append("  [\(index)][\(set)][\(loaded)][\(name)][\(value)]\n")
			i += 1
		}
		sb.append("[ =========================== ]\n\n")
		return sb
	}
}
