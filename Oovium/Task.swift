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
	func execute (memory: inout Memory) -> Int?
	func calculate (memory: inout Memory) -> TowerState
}

struct LambdaTask: Task {
	var lambda: Lambda!
	
	init (lambda: Lambda) {
		self.lambda = lambda
	}
	
	// Task ========================================================================================
	var type: TaskType {
		get {return .lambda}
	}
	var label: String {
		get {return ""}
	}
	var command: String {
		get {return ""}
	}
	func execute (memory: inout Memory) -> Int? {
		memory.mimic(lambda.vi, obj: lambda.execute(memory: &memory))
		return nil
	}
	func calculate (memory: inout Memory) -> TowerState {
		_ = execute(memory: &memory)
		return .calced
	}
}
struct GotoTask: Task {
	let goto: Int!
	
	init (goto: Int) {
		self.goto = goto
	}

	// Task ========================================================================================
	var type: TaskType {
		get {return .goto}
	}
	var label: String {
		get {return ""}
	}
	var command: String {
		get {return ""}
	}
	func execute (memory: inout Memory) -> Int? {
		return goto
	}
	func calculate (memory: inout Memory) -> TowerState {
		_ = execute(memory: &memory)
		return .calced
	}
}
struct IfGotoTask: Task {
	let index: Int!
	let goto: Int!
	
	init (index: Int, goto: Int) {
		self.index = index
		self.goto = goto
	}

	// Task ========================================================================================
	var type: TaskType {
		get {return .ifGoto}
	}
	var label: String {
		get {return ""}
	}
	var command: String {
		get {return ""}
	}
	func execute (memory: inout Memory) -> Int? {
		if (memory[index]! as! RealObj).x != 0 {return nil}
		return goto
	}
	func calculate (memory: inout Memory) -> TowerState {
		_ = execute(memory: &memory)
		return .calced
	}
}
struct ForkTask: Task {
	let ifIndex: Int!
	let thenIndex: Int!
	let elseIndex: Int!
	let resultIndex: Int!
	
	init (ifIndex: Int, thenIndex: Int, elseIndex: Int, resultIndex: Int) {
		self.ifIndex = ifIndex
		self.thenIndex = thenIndex
		self.elseIndex = elseIndex
		self.resultIndex = resultIndex
	}

	// Task ========================================================================================
	var type: TaskType {
		get {return .fork}
	}
	var label: String {
		get {return ""}
	}
	var command: String {
		get {return ""}
	}
	func execute (memory: inout Memory) -> Int? {
		if (memory[ifIndex]! as! RealObj).x != 0 {
			memory.mimic(resultIndex, obj: memory[thenIndex]!)
		} else {
			memory.mimic(resultIndex, obj: memory[elseIndex]!)
		}
		return nil
	}
	func calculate (memory: inout Memory) -> TowerState {
		_ = execute(memory: &memory)
		return .calced
	}
}
