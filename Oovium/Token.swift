//
//  Token.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

/* ======================================================================================
Token is the atomic unit of entry in Oovium; it works in concert with Sheath.  The key
is constructed from the token type and the tag: "type:tag".  Tokens are obtained from
the Math appliance.  Each key is unique within the Math token registry.

The tag is the unique identifier of the various Token types, such as a function name.
For Functions and Operators each tag will map to one or more Morphs.  When compiling
the pebble the specific Morph will be chosen based on the Types of the input parameters.

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

public class Token: NSObject {
	public let type: TokenType
	public let tag: Tag
	public let level: TokenLevel?
	
	var key: String {
		get {
			return "\(type.rawValue):\(tag.key)"
		}
	}
	
	public init (type: TokenType, tag: Tag) {
		self.type = type
		self.tag = tag
		self.level = .add
	}
	public init (type: TokenType, tag: Tag, level: TokenLevel) {
		self.type = type
		self.tag = tag
		self.level = level
	}
	
	static var tokens: [String:Token] = [String:Token]()
	
	public static func token (type: TokenType, tag:Tag) -> Token {
		let key: String = "\(type.rawValue):\(tag.key)"
		var token: Token? = tokens[key]
		if token == nil {
			token = Token(type:type, tag:tag)
			tokens[key] = token
		}
		return token!
	}
	static func token (key: String) -> Token {
		let colon = key.range(of: ":")!.lowerBound
		let type: TokenType = TokenType(rawValue: Int(key.substring(to: colon))!)!
		let tag = Tag.tag(key: key.substring(from: key.index(after:colon)))
		return token(type: type, tag: tag)
	}
	
	static let add: Token				= token(type:.operator, tag:Tag.add)
	static let subtract: Token			= token(type:.operator, tag:Tag.subtract)
	static let multiply: Token			= token(type:.operator, tag:Tag.multiply)
	static let divide: Token			= token(type:.operator, tag:Tag.divide)
	static let dot: Token				= token(type:.operator, tag:Tag.dot)
	static let mod: Token				= token(type:.operator, tag:Tag.mod)
	static let power: Token				= token(type:.operator, tag:Tag.power)
	static let equal: Token				= token(type:.operator, tag:Tag.equal)
	static let less: Token				= token(type:.operator, tag:Tag.less)
	static let greater: Token			= token(type:.operator, tag:Tag.greater)
	static let notEqual: Token			= token(type:.operator, tag:Tag.notEqual)
	static let lessOrEqual: Token		= token(type:.operator, tag:Tag.lessOrEqual)
	static let greaterOrEqual: Token	= token(type:.operator, tag:Tag.greaterOrEqual)
	static let not: Token				= token(type:.operator, tag:Tag.not)
	static let and: Token				= token(type:.operator, tag:Tag.and)
	static let or: Token				= token(type:.operator, tag:Tag.or)
	static let leftParen: Token			= token(type:.separator, tag:Tag.leftParen)
	static let comma: Token				= token(type:.separator, tag:Tag.comma)
	static let rightParen: Token		= token(type:.separator, tag:Tag.rightParen)
	static let bra: Token				= token(type:.separator, tag:Tag.bra)
	static let ket: Token				= token(type:.separator, tag:Tag.ket)
	static let quote: Token				= token(type:.separator, tag:Tag.quote)
	
	static let e: Token					= token(type:.constant, tag:Tag.e)
	static let i: Token					= token(type:.constant, tag:Tag.i)
	static let pi: Token				= token(type:.constant, tag:Tag.pi)
	
	// Legacy
	public var ip: Int!
}
