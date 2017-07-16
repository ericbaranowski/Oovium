//
//  Chain.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

fileprivate class Ops {
	private let chain: Chain
	
	private var pOp: Token?
	private var mOp: Token?
	private var aOp: Token?
	private var cOp: Token?
	
	init (_ chain: Chain) {
		self.chain = chain
	}
	
	private func doPOP (_ token: Token?) {
		if let pOp = pOp {chain.applyTag(pOp)}
		pOp = token
	}
	private func doMOP (_ token: Token?) {
		if let mOp = mOp {chain.applyTag(mOp)}
		mOp = token
	}
	private func doAOP (_ token: Token?) {
		if let aOp = aOp {chain.applyTag(aOp)}
		aOp = token
	}
	private func doCOP (_ token: Token?) {
		if let cOp = cOp {chain.applyTag(cOp)}
		cOp = token
	}
	
	func pOp (_ token: Token) {
		doPOP(token)
	}
	func mOp (_ token: Token) {
		doPOP(nil)
		doMOP(token)
	}
	func aOp (_ token: Token) {
		doPOP(nil)
		doMOP(nil)
		doAOP(token)
	}
	func cOp (_ token: Token) {
		doPOP(nil)
		doMOP(nil)
		doAOP(nil)
		doCOP(token)
	}
	func end() {
		doPOP(nil)
		doMOP(nil)
		doAOP(nil)
		doCOP(nil)
	}
}

enum ParseError: Error {
	case general
}

protocol ChainDelegate {
	func onChange()
	func onEdit()
	func onOK()
}

public final class Chain: NSObject/*, CustomStringConvertible*/ {
	var tokens = [Token]()
	var tower: Tower
	var delegate: ChainDelegate?
	var open: Bool = false
	var lambda: UnsafeMutablePointer<Lambda>?
	
	public init (tokens: String, tower: Tower) {
		self.tower = tower
		let keys = tokens.components(separatedBy: ";")
		for key in keys {
			self.tokens.append(Token.token(key: key))
		}
	}
	init (string: String) {
		tower = Tower(name: "")
		for c in string.characters {
			if c == "0" {self.tokens.append(Token.token(type: .digit, tag: "0"))}
			else if c == "1" {self.tokens.append(Token.token(type: .digit, tag: "1"))}
			else if c == "2" {self.tokens.append(Token.token(type: .digit, tag: "2"))}
			else if c == "3" {self.tokens.append(Token.token(type: .digit, tag: "3"))}
			else if c == "4" {self.tokens.append(Token.token(type: .digit, tag: "4"))}
			else if c == "5" {self.tokens.append(Token.token(type: .digit, tag: "5"))}
			else if c == "6" {self.tokens.append(Token.token(type: .digit, tag: "6"))}
			else if c == "7" {self.tokens.append(Token.token(type: .digit, tag: "7"))}
			else if c == "8" {self.tokens.append(Token.token(type: .digit, tag: "8"))}
			else if c == "9" {self.tokens.append(Token.token(type: .digit, tag: "9"))}
			else if c == "." {self.tokens.append(Token.token(type: .digit, tag: "."))}
			else if c == "+" {self.tokens.append(Token.add)}
			else if c == "-" {self.tokens.append(Token.subtract)}
			else if c == "*" {self.tokens.append(Token.multiply)}
			else if c == "/" {self.tokens.append(Token.divide)}
			else if c == "^" {self.tokens.append(Token.power)}
		}
	}
	
//	- (NSString*) dehydrate {
//	if (![_tokens count]) return @"";
//	NSMutableString* tokens = [[NSMutableString alloc] init];
//	for (AEToken* token in _tokens)
//	[tokens appendFormat:@"%@;",[token key]];
//	[tokens deleteCharactersInRange:NSMakeRange([tokens length]-1,1)];
//	return tokens;
//	}
	
	func post (token: Token) {
		tokens.append(token)
		delegate?.onChange()
	}
	func backspace() {
		guard tokens.count > 0 else {return}
		tokens.removeLast()
		delegate?.onChange()
	}
	func token() {
	}
	func edit() {
		open = true
		delegate?.onEdit()
	}
	func ok() {
//	func ok(_ memory: UnsafeMutablePointer<Memory>) {
		open = false
//		lambda = compile(memory: memory)
		tower.signal()
		delegate?.onOK()
	}

	var store: String {
			var sb = String()
			for token in tokens {
				sb.append("\(token.key);")
			}
			sb.remove(at: sb.index(before: sb.endIndex))
			return sb
	}
	var display: String {
		var sb = String()
		for token in tokens {
			sb.append("\(token.tag)")
		}
		return sb
	}
	
//	private func add (morph: @escaping (Lambda)->()) {
//	private func add (morph: Morph) {
//		lambda.addMorph(morph)
//	}
//	private func apply (tag: Tag) {
//		lambda.applyTag(tag)
//	}
	
// Parsing =========================================================================================
	private var morphs = [Int]()
	private var variables = [String]()
//	private var varIndexes = [Int]()
	private var constants = [Double]()
	private var stack = [String](repeating: "", count: 10)
	private var sp = 0
	
	// Stack
	private func push (_ key: String) {
		stack[sp] = key;
		sp += 1
	}
	private func pop() -> String {
		sp -= 1
		return stack[sp]
	}
	private func peek() -> String {
		return stack[sp-1]
	}
	
	private func addMorph (_ morph: Morph) {
		morphs.append(morph.rawValue)
		push("num")
	}
	private func addConstant (_ x: Double) {
		constants.append(x)
		applyTag(Token.constant)
	}

	fileprivate func applyTag (_ token: Token) {
		var key = "\(token.tag);"
		var defKeys = [String]()
		for _ in 0..<token.params {
			defKeys.append(pop())
		}
		for i in 0..<token.params {
			key += "\(defKeys[token.params-1-i]);"
		}
		addMorph(Math.morph(key: key))
	}
	
	private func parseOperator (tokens:[Token], i:Int, ops:Ops) throws {
		let token: Token = tokens[i]
		
		if token.type != .operator && token.type != .separator
		{throw ParseError.general}
		
		switch token.level! {
		case .add:			ops.aOp(token)
		case .multiply:		ops.mOp(token)
		case .power:		ops.pOp(token)
		case .compare:		ops.cOp(token)
		case .separator:	ops.end()
		}
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
	
	private func parseNumber (tokens: [Token], i:Int) -> String {
		var sb = String()
		for i in i..<tokens.count {
			let token = tokens[i]
			if token.type != .digit {break}
			sb.append(token.tag)
		}
		return sb;
	}
	private func parseOperand (tokens:[Token], i:Int) throws -> Int {
		var i = i
		if (tokens.count <= i)
		{throw ParseError.general}
		
		var token: Token = tokens[i]
		
		var unary: Token?
		if token == Token.subtract || token == Token.not {
			unary = token==Token.subtract ? Token.neg : Token.not
			i += 1
			if (i == tokens.count)
			{throw ParseError.general}
			token = tokens[i]
		}
		
		if token.type == .digit {
			let n: String = parseNumber(tokens:tokens, i:i)
			let x: Double = Double(n)!
			addConstant(x);
			if let unary = unary {
				applyTag(unary)
			}
			return n.lengthOfBytes(using: .ascii) + (unary != nil ? 1 : 0)
		} else if token == .leftParen {
		} else if token.type == .function {
		} else if token == .bra {
		} else if token.type == .variable {
			let v: String = token.tag
			let buck = v.range(of:"$")?.lowerBound
			let name = buck != nil ? v.substring(to: buck!) : v
			let type = buck != nil ? "\(v.substring(from: v.index(buck!, offsetBy: 1)))Var;" : "var;num;"
			variables.append(name)
			addMorph(Math.morph(key: type))
//			add(morph: Math.morph(key: type))
			
			if unary != nil {applyTag(unary!)}
//			if unary != nil {apply(tag: unary!)}
			return 1 + (unary != nil ? 1 : 0)
			
		} else if token.type == .constant {
		} else if token == Token.quote {
		}
		
		throw ParseError.general
	}
	private func parseTokens (tokens:[Token], start:Int, stop:Int) throws {
		if (tokens.count == 0) {return}
		let ops: Ops = Ops(self)
		var i: Int = start
		i += try parseOperand(tokens:tokens, i:i)
		while i < stop {
			try parseOperator(tokens:tokens, i:i, ops:ops)
			i += 1
			i += try parseOperand(tokens:tokens, i:i)
		}
		ops.end()
	}
	private func parse (tokens: [Token]) throws {
		try parseTokens(tokens:tokens, start:0, stop:tokens.count)
	}
	
	public func compile (memory: UnsafeMutablePointer<Memory>) -> UnsafeMutablePointer<Lambda> {
		do {
			try parse(tokens: self.tokens)
		} catch {
			print("\(error)")
		}
		
		let vi = AEMemoryIndexForName(memory, tower.name.toInt8())
		
//		varIndexes = [Int]()
//		for name in variables {
//			varIndexes.append(Int(AEMemoryIndexForName(memory, name.toInt8())))
//		}
		
		let vn = variables.count
		let v: UnsafeMutablePointer<UInt8>! = UnsafeMutablePointer<UInt8>.allocate(capacity: vn)
		for i in 0..<vn {
			v[i] = UInt8(AEMemoryIndexForName(memory, variables[i].toInt8()))
		}
		
		let cn = constants.count
		let c: UnsafeMutablePointer<Obj>! = UnsafeMutablePointer<Obj>.allocate(capacity: cn)
		for i in 0..<cn {
			c[i].a.x = constants[i]
		}
		
		let mn = morphs.count
		let m: UnsafeMutablePointer<UInt8>! = UnsafeMutablePointer<UInt8>.allocate(capacity: mn)
		for i in 0..<mn {
			m[i] = UInt8(morphs[i])
		}

		lambda = AELambdaCreate(UInt8(vi), c, UInt8(cn), v, UInt8(vn), m, UInt8(mn))
		
		c.deallocate(capacity: cn)
		v.deallocate(capacity: vn)
		m.deallocate(capacity: mn)
		return lambda!
	}
	
// CustomStringConvertible =========================================================================
	override public var description: String {
		var sb = String()
		for token in tokens {
			sb.append("\(token.tag)")
		}
		return sb
	}
}
