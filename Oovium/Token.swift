//
//  Token.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

/* ======================================================================================
Token is the atomic unit of entry in Oovium; it works in concert with Chain.  The key
is constructed from the token type and the tag: "type:tag".  Tokens are obtained from
the Math appliance.  Each key is unique within the Math token registry.

The tag is the unique identifier of the various Token types, such as a function name.
For Functions and Operators each tag will map to one or more Morphs.  When compiling
the chain the specific Morph will be chosen based on the Types of the input parameters.

parse is the exact string that is used to build up the string to be sent on to Pebble.
Often parse and tag are equal, but for Variables in particular will have the type name
appended to it in order to allow Pebble to select the appropriate Morph.

display is the string representing the Token that is to appear to the user on screen.
Mostly, this the same as tag and parse, but for Variable it could be the Variable's
user defined name or else it's formatted value.

params is determined by looking it up in the Tag registry of the Math appliance.

- jjc 11/5/2010
====================================================================================== */

import Foundation

//public enum TokenType: String {
//	case digit = "dgt"
//	case `operator` = "opr"
//	case separator = "sep"
//	case function = "fnc"
//	case variable = "var"
//	case property = "pty"
//	case constant = "cns"
//	case character = "chr"
//}
@objc public enum TokenType: Int {
	case digit
	case `operator`
	case separator
	case function
	case variable
	case property
	case constant
	case character
}
@objc public enum TokenLevel: Int {
	case add
	case multiply
	case power
	case compare
	case separator
}

public final class Token: Hashable, CustomStringConvertible {
	public let type: TokenType
	public let tag: String
	public let params: Int
	public let level: TokenLevel?
	public let tower: Tower?
	var display: String
	
	var key: String {
		return "\(type.rawValue):\(tag)"
	}
	
	private init (type: TokenType, tag: String) {
		self.type = type
		self.tag = tag
		self.params = 1
		self.level = .add
		self.tower = nil
		self.display = tag
	}
	private init (type: TokenType, tag: String, params: Int, level: TokenLevel) {
		self.type = type
		self.tag = tag
		self.params = params
		self.level = level
		self.tower = nil
		self.display = tag
	}
	
// Hashable ========================================================================================
	public static func == (left: Token, right: Token) -> Bool {
		return left.key == right.key
	}
	public var hashValue: Int {
		return key.hashValue
	}
	
// CustomStringConvertible =========================================================================
	public var description: String {
		return "\(type.rawValue):\(tag)"
	}
	
// Static ==========================================================================================
	static var tokens: [String:Token] = [String:Token]()
	
	public static func token (type: TokenType, tag:String) -> Token {
		let key: String = "\(type.rawValue):\(tag)"
		var token: Token? = tokens[key]
		if token == nil {
			token = Token(type:type, tag:tag)
			tokens[key] = token
		}
		return token!
	}
	public static func token (type: TokenType, tag: String, params: Int, level: TokenLevel) -> Token {
		let key: String = "\(type.rawValue):\(tag)"
		var token: Token? = tokens[key]
		if token == nil {
			token = Token(type:type, tag:tag, params:params, level:level)
			tokens[key] = token
		}
		return token!
	}
	static func token (key: String) -> Token {
		let colon = key.range(of: ":")!.lowerBound
		let type: TokenType = TokenType(rawValue: Int(key.substring(to: colon))!)!
		let tag = key.substring(from: key.index(after:colon))
		return token(type: type, tag: tag)
	}
	
	static let constant: Token			= token(type: .constant,	tag:"constant", params: 0, level: .separator)
	static let variable: Token			= token(type: .variable,	tag:"variable")
	
	static let add: Token				= token(type: .operator, 	tag:"+",	params: 2, level: .add)
	static let subtract: Token			= token(type: .operator,	tag:"−",	params: 2, level: .add)
	static let multiply: Token			= token(type: .operator,	tag:"×",	params: 2, level: .multiply)
	static let divide: Token			= token(type: .operator,	tag:"÷",	params: 2, level: .multiply)
	static let dot: Token				= token(type: .operator,	tag:"⋅",	params: 2, level: .multiply)
	static let mod: Token				= token(type: .operator,	tag:"%",	params: 2, level: .multiply)
	static let power: Token				= token(type: .operator,	tag:"^",	params: 2, level: .power)
	static let equal: Token				= token(type: .operator,	tag:"=",	params: 2, level: .compare)
	static let less: Token				= token(type: .operator,	tag:"<",	params: 2, level: .compare)
	static let greater: Token			= token(type: .operator,	tag:">",	params: 2, level: .compare)
	static let notEqual: Token			= token(type: .operator,	tag:"≠",	params: 2, level: .compare)
	static let lessOrEqual: Token		= token(type: .operator,	tag:"≤",	params: 2, level: .compare)
	static let greaterOrEqual: Token	= token(type: .operator,	tag:"≥",	params: 2, level: .compare)
	static let and: Token				= token(type: .operator,	tag:"&",	params: 2, level: .compare)
	static let or: Token				= token(type: .operator,	tag:"|",	params: 2, level: .compare)
	static let not: Token				= token(type: .operator,	tag:"!",	params: 1, level: .compare)
	static let neg: Token				= token(type: .operator,	tag:"neg",	params: 1, level: .compare)
	static let leftParen: Token			= token(type: .separator,	tag:"(",	params: 1, level: .separator)
	static let comma: Token				= token(type: .separator,	tag:",",	params: 1, level: .separator)
	static let rightParen: Token		= token(type: .separator,	tag:")",	params: 1, level: .separator)
	static let bra: Token				= token(type: .separator,	tag:"[",	params: 1, level: .separator)
	static let ket: Token				= token(type: .separator,	tag:"]",	params: 1, level: .separator)
	static let quote: Token				= token(type: .separator,	tag:"\"",	params: 1, level: .separator)
	
	static let e: Token					= token(type:.constant, tag:"e")
	static let i: Token					= token(type:.constant, tag:"i")
	static let pi: Token				= token(type:.constant, tag:"π")

	// Legacy
//	public var ip: Int!
}
