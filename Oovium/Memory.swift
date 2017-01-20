//
//  Memory.swift
//  Oovium
//
//  Created by Joe Charlier on 12/11/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public struct Memory: CustomStringConvertible {
	var index = [String:Int]()
//	private var slots = [Slot]()
	
	private var names = [String]()
	private var fixed = [Bool]()
	private var loaded = [Bool]()
	private var values = [Obj]()
	
	public init (_ names: [String]) {
//		super.init()
		for name in names {
			append(name:name)
		}
	}
	
	public subscript (i: Int) -> Obj? {
		set {
			values[i] = newValue!
			loaded[i] = true
		}
		get {
			if loaded[i] {
				return values[i]
			} else {
				return nil
			}
		}
	}
	public subscript (name: String) -> Obj? {
		get {
			if let i = index[name] {
				return values[i]
			} else {
				return nil
			}
		}
	}
	
	public mutating func mimic (_ i: Int, obj: Obj) {
//		slot.value.mimic(obj)
		values[i] = obj
		loaded[i] = true
	}
//	public func mimic (_ i: Int, n: Int) {
//		let slot = slots[i]
////		(slot.value as! RealObj).mimic(int: n)
//		slot.value = RealObj(Double(n))
//		slot.loaded = true
//	}
	
	public mutating func fix (_ i: Int) {
		fixed[i] = true
	}
	public mutating func fix (_ i: Int, obj:Obj) {
		fixed[i] = true
		values[i] = obj
	}
	
//	func append (slot: Slot) {
//		index[slot.name] = slots.count
//		slots.append(slot)
//	}
	mutating func append (name: String) {
		index[name] = names.count
		names.append(name)
		fixed.append(false)
		loaded.append(false)
		values.append(RealObj.zero)
	}
	
	public func index (for name: String) -> Int {
		if let n = index[name] {
			return n
		} else {
			return -1
		}
	}
	
	public func isLoaded (_ i: Int) -> Bool {
		return loaded[i]
	}
	public mutating func load (_ i: Int, with value: Obj) {
		loaded[i] = true
		values[i] = value
	}

	public mutating func clear () {
		for i in 0..<count {
			loaded[i] = fixed[i]
		}
	}
	public var count: Int {
		return names.count
	}
	
// CustomStringConvertible =========================================================================
	public var description: String {
		var sb = String()
		sb.append("[ Memory ==================== ]\n")
		for i in 0..<count  {
			let index = String(format: "%2d", i)
			let set: String = fixed[i] ? "O" : " "
			let load: String = loaded[i] ? "O" : " "
			let name: String  = names[i].padding(toLength: 12, withPad: " ", startingAt: 0)
			let value: String = loaded[i] ? "\(values[i])" : "-"
			sb.append("  [\(index)][\(set)][\(load)][\(name)][\(value)]\n")
		}
		sb.append("[ =========================== ]\n\n")
		return sb
	}
}
