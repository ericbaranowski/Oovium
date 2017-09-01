//
//  SheathHover.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ChainEditor: KeyPad {
	var chain: Chain!
	var cyanOn: Bool = false
	
	lazy private var cyanKeyPad: CyanKeyPad = {CyanKeyPad(chainEditor: self)}()
	private let numSchematic = Schematic(rows: 6, cols: 4)
	private let sciSchematic = Schematic(rows: 5, cols: 3)
	private let invSchematic = Schematic(rows: 5, cols: 3)
	private let misSchematic = Schematic(rows: 5, cols: 3)
	
	init() {
		super.init(anchor: .bottomRight,offset: UIOffset(horizontal: -6, vertical: -6), size: CGSize(width: 174, height: 214), fixedOffset: UIOffset(horizontal: 0, vertical: 0), schematic: numSchematic)

		renderNumSchematic()
		renderSciSchematic()
		renderInvSchematic()
		renderMisSchematic()
		
		self.schematic = numSchematic
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
	private func renderNumSchematic() {
		let lemon = UIColor(red: 0.95, green: 0.85, blue: 0.55, alpha: 1)
		let banana = UIColor(red: 1, green: 0.85, blue: 0.27, alpha: 1)
		let orange = UIColor(red: 1, green: 0.6, blue: 0.18, alpha: 1)
		
		
		numSchematic.add(row: 0, col: 0, key: Key(text: "", uiColor: UIColor.cyan, {
			self.toggleCyanKeyPad()
		}))
		numSchematic.add(row: 0, col: 1, key: Key(text: "(,)", uiColor: banana, {self.chain.post(token: Token.comma)}))
		numSchematic.add(row: 0, col: 2, w: 2, h: 1, key: Key(text: "\u{232B}", uiColor: lemon, {self.chain.backspace()}))
		
		numSchematic.add(row: 1, col: 0, key: Key(text: "\"", uiColor: OOColor.peach.uiColor, {self.chain.post(token: Token.quote)}))
		numSchematic.add(row: 1, col: 1, key: Key(text: "^", uiColor: banana, {self.chain.post(token: Token.power)}))
		numSchematic.add(row: 1, col: 2, key: Key(text: "\u{00F7}", uiColor: banana, {self.chain.post(token: Token.divide)}))
		numSchematic.add(row: 1, col: 3, key: Key(text: "\u{00D7}", uiColor: banana, {self.chain.post(token: Token.multiply)}))
		
		numSchematic.add(row: 2, col: 0, key: Key(text: "7", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: "7"))}))
		numSchematic.add(row: 2, col: 1, key: Key(text: "8", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: "8"))}))
		numSchematic.add(row: 2, col: 2, key: Key(text: "9", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: "9"))}))
		numSchematic.add(row: 2, col: 3, key: Key(text: "\u{2212}", uiColor: banana, {self.chain.post(token: Token.subtract)}))
		
		numSchematic.add(row: 3, col: 0, key: Key(text: "4", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: "4"))}))
		numSchematic.add(row: 3, col: 1, key: Key(text: "5", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: "5"))}))
		numSchematic.add(row: 3, col: 2, key: Key(text: "6", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: "6"))}))
		numSchematic.add(row: 3, col: 3, key: Key(text: "+", uiColor: banana, {self.chain.post(token: Token.add)}))
		
		numSchematic.add(row: 4, col: 0, key: Key(text: "1", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: "1"))}))
		numSchematic.add(row: 4, col: 1, key: Key(text: "2", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: "2"))}))
		numSchematic.add(row: 4, col: 2, key: Key(text: "3", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: "3"))}))
		numSchematic.add(row: 4, col: 3, w: 1, h: 2, key: Key(text: "=", uiColor: lemon, {self.chain.ok()}))
		
		numSchematic.add(row: 5, col: 0, w: 2, h: 1, key: Key(text: "0", uiColor: orange, {self.chain.post(token: Token.token(type: .operator, tag: "0"))}))
		numSchematic.add(row: 5, col: 2, key: Key(text: ".", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: "."))}))
	}
	private func renderSciSchematic() {
		let cherry = UIColor(red: 1, green: 0.77, blue: 0.68, alpha: 1)
		let grape = UIColor(red: 0.8, green: 0.4, blue: 0.8, alpha: 1)
		let kiwi = UIColor(red: 0.75, green: 0.8, blue: 0.38, alpha: 1)
		let font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 20)!
		
		sciSchematic.add(row: 0, col: 0, key: Key(text: "\u{221A}", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "sqrt"))
		}))
		sciSchematic.add(row: 0, col: 1, key: Key(text: "n!", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "fac"))
		}))
		sciSchematic.add(row: 0, col: 2, key: Key(text: "inv", uiColor: grape, {
			self.presentInvSchematic()
		}))

		sciSchematic.add(row: 1, col: 0, key: Key(text: "ln", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "ln"))
		}))
		sciSchematic.add(row: 1, col: 1, key: Key(text: "log", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "log"))
		}))
		sciSchematic.add(row: 1, col: 2, key: Key(text: "log\u{2082}", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "log2"))
		}))

		sciSchematic.add(row: 2, col: 0, key: Key(text: "sin", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "sin"))
		}))
		sciSchematic.add(row: 2, col: 1, key: Key(text: "cos", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "cos"))
		}))
		sciSchematic.add(row: 2, col: 2, key: Key(text: "tan", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "tan"))
		}))

		sciSchematic.add(row: 3, col: 0, key: Key(text: "sinh", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "sinh"))
		}))
		sciSchematic.add(row: 3, col: 1, key: Key(text: "cosh", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "cosh"))
		}))
		sciSchematic.add(row: 3, col: 2, key: Key(text: "tanh", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "tanh"))
		}))

		sciSchematic.add(row: 4, col: 0, key: Key(text: "\u{03C0}", uiColor: kiwi, font: font, {
			self.chain.post(token: Token.token(type: .constant, tag: "\u{03C0}"))
		}))
		sciSchematic.add(row: 4, col: 1, key: Key(text: "e", uiColor: kiwi, font: font, {
			self.chain.post(token: Token.token(type: .constant, tag: "e"))
		}))
		sciSchematic.add(row: 4, col: 2, key: Key(text: "i", uiColor: kiwi, font: font, {
			self.chain.post(token: Token.token(type: .constant, tag: "i"))
		}))
	}
	private func renderInvSchematic() {
		let cherry = UIColor(red: 1, green: 0.77, blue: 0.68, alpha: 1)
		let grape = UIColor(red: 0.8, green: 0.4, blue: 0.8, alpha: 1)
		let kiwi = UIColor(red: 0.75, green: 0.8, blue: 0.38, alpha: 1)
		let font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 20)!
		
		invSchematic.add(row: 0, col: 0, key: Key(text: "\u{221A}", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "sqrt"))
		}))
		invSchematic.add(row: 0, col: 1, key: Key(text: "n!", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "fac"))
		}))
		invSchematic.add(row: 0, col: 2, key: Key(text: "inv", uiColor: grape, {
			self.presentSciSchematic()
		}))
		
		invSchematic.add(row: 1, col: 0, key: Key(text: "e\u{207F}", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "exp"))
		}))
		invSchematic.add(row: 1, col: 1, key: Key(text: "10\u{207F}", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "ten"))
		}))
		invSchematic.add(row: 1, col: 2, key: Key(text: "2\u{207F}", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "two"))
		}))
		
		invSchematic.add(row: 2, col: 0, key: Key(text: "asin", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "asin"))
		}))
		invSchematic.add(row: 2, col: 1, key: Key(text: "acos", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "acos"))
		}))
		invSchematic.add(row: 2, col: 2, key: Key(text: "atan", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "atan"))
		}))
		
		invSchematic.add(row: 3, col: 0, key: Key(text: "asinh", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "asinh"))
		}))
		invSchematic.add(row: 3, col: 1, key: Key(text: "acosh", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "acosh"))
		}))
		invSchematic.add(row: 3, col: 2, key: Key(text: "atanh", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "atanh"))
		}))
		
		invSchematic.add(row: 4, col: 0, key: Key(text: "\u{03C0}", uiColor: kiwi, font: font, {
			self.chain.post(token: Token.token(type: .constant, tag: "\u{03C0}"))
		}))
		invSchematic.add(row: 4, col: 1, key: Key(text: "e", uiColor: kiwi, font: font, {
			self.chain.post(token: Token.token(type: .constant, tag: "e"))
		}))
		invSchematic.add(row: 4, col: 2, key: Key(text: "i", uiColor: kiwi, font: font, {
			self.chain.post(token: Token.token(type: .constant, tag: "i"))
		}))
	}
	private func renderMisSchematic() {
		let cherry = UIColor(red: 1, green: 0.77, blue: 0.68, alpha: 1)
		let blueberry = UIColor(red: 0.33, green: 0.53, blue: 0.77, alpha: 1)
		let plum = UIColor(red: 0.71, green: 0.65, blue: 0.87, alpha: 1)
		let almond = UIColor(red: 0.93, green: 0.93, blue: 0.7, alpha: 1)
		let font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 20)!

		misSchematic.add(row: 0, col: 0, key: Key(text: "round", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "round"))
		}))
		misSchematic.add(row: 0, col: 1, key: Key(text: "floor", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "floor"))
		}))
		misSchematic.add(row: 0, col: 2, key: Key(text: "lex", uiColor: blueberry, {
			self.presentSciSchematic()
		}))
		
		misSchematic.add(row: 1, col: 0, key: Key(text: "if", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "if"))
		}))
		misSchematic.add(row: 1, col: 1, key: Key(text: "min", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "min"))
		}))
		misSchematic.add(row: 1, col: 2, key: Key(text: "max", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .function, tag: "max"))
		}))
		
		misSchematic.add(row: 2, col: 0, key: Key(text: "=", uiColor: plum, {
			self.chain.post(token: Token.token(type: .operator, tag: "="))
		}))
		misSchematic.add(row: 2, col: 1, key: Key(text: "<", uiColor: plum, {
			self.chain.post(token: Token.token(type: .operator, tag: "<"))
		}))
		misSchematic.add(row: 2, col: 2, key: Key(text: ">", uiColor: plum, {
			self.chain.post(token: Token.token(type: .operator, tag: ">"))
		}))
		
		misSchematic.add(row: 3, col: 0, key: Key(text: "\u{2260}", uiColor: plum, {
			self.chain.post(token: Token.token(type: .operator, tag: "\u{2260}"))
		}))
		misSchematic.add(row: 3, col: 1, key: Key(text: "\u{2264}", uiColor: plum, {
			self.chain.post(token: Token.token(type: .operator, tag: "\u{2264}"))
		}))
		misSchematic.add(row: 3, col: 2, key: Key(text: "\u{2265}", uiColor: plum, {
			self.chain.post(token: Token.token(type: .operator, tag: "\u{2265}"))
		}))
		
		misSchematic.add(row: 4, col: 0, key: Key(text: "\u{2211}", uiColor: cherry, {
			self.chain.post(token: Token.token(type: .constant, tag: "\u{2211}"))
		}))
		misSchematic.add(row: 4, col: 1, key: Key(text: "[ ]", uiColor: almond, {
		}))
		misSchematic.add(row: 4, col: 2, key: Key(text: "k", uiColor: almond, font: font, {
			self.chain.post(token: Token.token(type: .constant, tag: "k"))
		}))
	}
	
	
	func toggleCyanKeyPad() {
		cyanOn = !cyanOn
		cyanKeyPad.toggle()
	}
	func presentNumSchematic() {
		schematic = numSchematic
	}
	func presentSciSchematic() {
		schematic = sciSchematic
	}
	func presentInvSchematic() {
		schematic = invSchematic
	}
	func presentMisSchematic() {
		schematic = misSchematic
	}
	
// Hover ===========================================================================================
	override func onInvoke() {
		if cyanOn {
			cyanKeyPad.invoke()
		}
	}
	override func onDismiss() {
		cyanKeyPad.dismiss()
	}
	override func rescale() {
		super.rescale()
		cyanKeyPad.rescale()
	}
}
