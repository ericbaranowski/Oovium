//
//  Task.swift
//  Oovium
//
//  Created by Joe Charlier on 12/25/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public enum TaskType {
	case lambda, goto, ifGoto, fork
}

public protocol Task {
	var type: TaskType {get}
	var label: String {get}
	var command: String {get}
	func execute (memory: UnsafeMutablePointer<Memory>) -> Int?
	func calculate (memory: UnsafeMutablePointer<Memory>) -> TowerState
}

struct LambdaTask: Task {
	var lambda: UnsafeMutablePointer<LambdaC>!
	var label: String
	var command: String
	
	init (label: String, command: String, lambda: UnsafeMutablePointer<LambdaC>) {
		self.label = label
		self.command = command
		self.lambda = lambda
	}
	
	// Task ========================================================================================
	var type: TaskType {
		get {return .lambda}
	}
	func execute (memory: UnsafeMutablePointer<Memory>) -> Int? {
//		memory[lambda.vi] = lambda.execute(memory: &memory)
//		memory.slots[lambda.vi].obj = lambda.execute(memory: &memory)
		
//		AELambdaPrint(lambda)
//		AEMemoryPrint(memory);
		
		let scratch = AEScratchCreate()
		AELambdaExecute(lambda, scratch, memory)
		AEScratchRelease(scratch)

//		AEMemoryPrint(memory);
		return nil
	}
	func calculate (memory: UnsafeMutablePointer<Memory>) -> TowerState {
		_ = execute(memory: memory)
		return .calced
	}
}
struct GotoTask: Task {
	let goto: Int!
	var label: String
	var command: String
	
	init (goto: Int) {
		self.label = ""
		self.command = "GOTO \(goto)"
		self.goto = goto
	}

	// Task ========================================================================================
	var type: TaskType {
		get {return .goto}
	}
	func execute (memory: UnsafeMutablePointer<Memory>) -> Int? {
		return goto
	}
	func calculate (memory: UnsafeMutablePointer<Memory>) -> TowerState {
		_ = execute(memory: memory)
		return .calced
	}
}
struct IfGotoTask: Task {
	let index: Int!
	let goto: Int!
	var label: String
	var command: String
	
	init (name: String, index: Int, goto: Int) {
		self.label = ""
		self.command = "IF \(name) == FALSE THEN GOTO \(goto)"
		self.index = index
		self.goto = goto
	}

	// Task ========================================================================================
	var type: TaskType {
		get {return .ifGoto}
	}
	func execute (memory: UnsafeMutablePointer<Memory>) -> Int? {
		if memory.pointee.slots[index].obj.a.x != 0 {return nil}
		return goto
	}
	func calculate (memory: UnsafeMutablePointer<Memory>) -> TowerState {
		_ = execute(memory: memory)
		return .calced
	}
}
struct ForkTask: Task {
	let ifIndex: Int!
	let thenIndex: Int!
	let elseIndex: Int!
	let resultIndex: Int!
	var label: String
	var command: String
	
	init (ifIndex: Int, thenIndex: Int, elseIndex: Int, resultIndex: Int) {
		self.label = ""
		self.command = ""
		self.ifIndex = ifIndex
		self.thenIndex = thenIndex
		self.elseIndex = elseIndex
		self.resultIndex = resultIndex
	}

	// Task ========================================================================================
	var type: TaskType {
		get {return .fork}
	}
	func execute (memory: UnsafeMutablePointer<Memory>) -> Int? {
		if memory.pointee.slots[ifIndex].obj.a.x != 0 {
//			memory[resultIndex] = memory[thenIndex]
			memory.pointee.slots[resultIndex].obj.a.x = memory.pointee.slots[thenIndex].obj.a.x
		} else {
//			memory[resultIndex] = memory[elseIndex]
			memory.pointee.slots[resultIndex].obj.a.x = memory.pointee.slots[elseIndex].obj.a.x
		}
		return nil
	}
	func calculate (memory: UnsafeMutablePointer<Memory>) -> TowerState {
		_ = execute(memory: memory)
		return .calced
	}
}
