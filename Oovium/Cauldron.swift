//
//  Cauldron.swift
//  Oovium
//
//  Created by Joe Charlier on 10/12/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

enum ParseError: Error {
	case general
}

public class Cauldron: NSObject {
// Tokens ==========================================================================================
	static private func parseOperator (tokens:[Token], i:Int, ops:Ops) throws {
		let token: Token = tokens[i]
		
		if token.type != .operator && token.type != .separator
			{throw ParseError.general}
		
//		switch token.level! {
//			case .add:			ops.aOp(token.tag)
//			case .multiply:		ops.mOp(token.tag)
//			case .power:		ops.pOp(token.tag)
//			case .compare:		ops.cOp(token.tag)
//			case .separator:	ops.end()
//		}
	}
	
	//	if ([tokens count] <= i)
	//		@throw [[ParseException alloc] initWithText:_text at:i];
	//
	//	Token* token = [tokens objectAtIndex:i];
	//
	//	NSString* unary = 0;
	//	if (token == [Math subtract] || token == [Math not]) {
	//		unary = token == [Math subtract] ? @"neg" : @"!";
	//		i++;
	//		if (i == [tokens count])
	//			@throw [[ParseException alloc] initWithText:@"orphaned unary operator" at:i];
	//		token = [tokens objectAtIndex:i];
	//	}
	//
	//	if ([token type] == OOTokenTypeDigit) {
	//		NSString* n = [self getNumber:tokens i:i];
	//		double x = [n doubleValue];
	//		[_constants addObject:[Math createReal:x]];
	//		[self applyTag:@"constant" stack:stack];
	//		if (unary) [self applyTag:unary stack:stack];
	//		return (int)[n length]+(unary?1:0);
	//	} else if (token == [Math leftParen]) {
	//		i++;
	//		int e = [self findEnd:i];
	//		[self parseTokens:_tokens start:i stop:e stack:stack];
	//		if (unary) [self applyTag:unary stack:stack];
	//		return 2+e-i+(unary?1:0);
	//	} else if ([token type] == OOTokenTypeFunction) {
	//		NSString* f = [token tag];
	//		i++;
	//		int e = [self findEnd:i];
	//
	//		[self parseTokens:_tokens start:i stop:e stack:stack];
	//
	//		if (![f isEqualToString:@""])
	//			[self applyTag:f stack:stack];
	//
	//		if (unary) [self applyTag:unary stack:stack];
	//		return 2+e-i+(unary?1:0);
	//	} else if (token == [Math bra]) {
	//		NSArray* p = [self getPebble:i];
	//		[_constants addObject:[Math createFunction:p]];
	//		[self applyTag:@"pebble" stack:stack];
	//		return (int)[p count]+2;
	//	} else if ([token type] == OOTokenTypeVariable) {
	//		NSString* v = [self getVariable:i];
	//		NSUInteger buck = [v rangeOfString:@"$"].location;
	//		NSString* var = buck!=NSNotFound ? [v substringToIndex:buck] : v;
	//		NSString* type = buck!=NSNotFound ? [NSString stringWithFormat:@"%@Var;",[v substringFromIndex:buck+1]] : @"NumberVar;";
	//		[_variables addObject:var];
	//		_indexes[_ip++] = token.ip;
	//		[self addMorph:[Math morphFromKey:type] stack:stack];
	//		[self addMorphC:[MathC morphFromKey:@"NumberVar;"]];
	//
	///*		while ([s length]>i && [s characterAtIndex:i] == '.') {
	//			i++;
	//			NSString* property = getVariable(s,i);
	//			[_constants addObject:[Math createString:property]];
	//			[self applyTag:@"constant" stack:stack];
	//
	//			[self applyTag:@"property" stack:stack];
	//			i += [property length];
	//			i += (([s length]>i && [s characterAtIndex:i]=='|')?1:0);
	//		}*/
	//
	//		if (unary) [self applyTag:unary stack:stack];
	//		return 1+(unary?1:0);
	//	} else if ([token type] == OOTokenTypeConstant) {
	//		if (token == [Math e])
	//			[_constants addObject:[Math createReal:M_E]];
	//		else if (token == [Math i])
	//			[_constants addObject:[Math createComplex:0 b:1]];
	//		else if (token == [Math pi])
	//			[_constants addObject:[Math createReal:M_PI]];
	//		[self applyTag:@"constant" stack:stack];
	//		if (unary) [self applyTag:unary stack:stack];
	//		return 1+(unary?1:0);
	//	} else if (token == [Math quote]) {
	//		NSString* txt = [self getString:i];
	//		[_constants addObject:[Math createString:txt]];
	//		[self applyTag:@"string" stack:stack];
	//		return (int)[txt length]+2;
	//	}
	//
	//	@throw [[ParseException alloc] initWithText:_text at:i];

	static private func parseNumber (tokens: [Token], i:Int) -> String {
		return ""
	}
	static private func parseOperand (tokens:[Token], i:Int, lambda:Lambda) throws -> Int {
		var i = i
		if (tokens.count <= i)
			{throw ParseError.general}
		
		var token: Token = tokens[i]
		
		var unary: Tag?
		if token == Token.subtract || token == Token.not {
			unary = token==Token.subtract ? Tag.negative : Tag.not
			i += 1
			if (i == tokens.count)
				{throw ParseError.general}
			token = tokens[i]
		}
		
		if token.type == .digit {
			let n: String = parseNumber(tokens:tokens, i:i)
			let x: Double = Double(n)!
			lambda.addConstant(x);
			if let unary = unary
				{lambda.applyTag(unary)}
			return n.lengthOfBytes(using: .ascii) + (unary != nil ? 1 : 0)
		} else if token == Token.leftParen {
		} else if token.type == .function {
		} else if token == Token.bra {
		} else if token.type == .variable {
		} else if token.type == .constant {
		} else if token == Token.quote {
		}
		
		throw ParseError.general
	}
	static private func parseTokens (tokens:[Token], start:Int, stop:Int, lambda:Lambda) throws {
		if (tokens.count == 0) {return}
		let ops: Ops = Ops(lambda)
		var i: Int = start
		i += try parseOperand(tokens:tokens, i:i, lambda:lambda)
		while i < stop {
			try parseOperator(tokens:tokens, i:i, ops:ops)
			i += try parseOperand(tokens:tokens, i:i, lambda:lambda)
		}
		ops.end()
	}
	static func parse (tokens: [Token]) throws -> Lambda {
		let lambda: Lambda = Lambda()
		try parseTokens(tokens:tokens, start:0, stop:tokens.count, lambda:lambda)
		return lambda
	}
	
// String ==========================================================================================
	public static func parse (string: String) -> Lambda {
		return Lambda()
	}
}
