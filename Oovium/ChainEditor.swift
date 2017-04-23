//
//  SheathHover.swift
//  Oovium
//
//  Created by Joe Charlier on 4/9/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class ChainEditor: KeyPad {
	var chain = Chain()
	
	init() {
		super.init(size: CGSize(width: 204, height: 251))
		
		let lemon = UIColor(red: 0.95, green: 0.85, blue: 0.55, alpha: 1)
		let banana = UIColor(red: 1, green: 0.85, blue: 0.27, alpha: 1)
		let orange = UIColor(red: 1, green: 0.6, blue: 0.18, alpha: 1)
		
		let schematic = Schematic(rows: 6, cols: 4)
		
		schematic.add(row: 0, col: 0, key: Key(text: "", uiColor: UIColor.cyan, {self.toggleIndexer()}))
		schematic.add(row: 0, col: 1, key: Key(text: "(,)", uiColor: banana, {self.chain.post(token: Token.comma)}))
		schematic.add(row: 0, col: 2, w: 2, h: 1, key: Key(text: "\u{232B}", uiColor: lemon, {self.chain.backspace()}))
		
		schematic.add(row: 1, col: 0, key: Key(text: "\"", uiColor: OOColor.peach.uiColor, {self.chain.post(token: Token.quote)}))
		schematic.add(row: 1, col: 1, key: Key(text: "^", uiColor: banana, {self.chain.post(token: Token.power)}))
		schematic.add(row: 1, col: 2, key: Key(text: "\u{00F7}", uiColor: banana, {self.chain.post(token: Token.divide)}))
		schematic.add(row: 1, col: 3, key: Key(text: "\u{00D7}", uiColor: banana, {self.chain.post(token: Token.multiply)}))

		schematic.add(row: 2, col: 0, key: Key(text: "7", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: Tag.tag(key: "7")))}))
		schematic.add(row: 2, col: 1, key: Key(text: "8", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: Tag.tag(key: "8")))}))
		schematic.add(row: 2, col: 2, key: Key(text: "9", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: Tag.tag(key: "9")))}))
		schematic.add(row: 2, col: 3, key: Key(text: "\u{2212}", uiColor: banana, {self.chain.post(token: Token.subtract)}))

		schematic.add(row: 3, col: 0, key: Key(text: "4", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: Tag.tag(key: "4")))}))
		schematic.add(row: 3, col: 1, key: Key(text: "5", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: Tag.tag(key: "5")))}))
		schematic.add(row: 3, col: 2, key: Key(text: "6", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: Tag.tag(key: "6")))}))
		schematic.add(row: 3, col: 3, key: Key(text: "+", uiColor: banana, {self.chain.post(token: Token.add)}))

		schematic.add(row: 4, col: 0, key: Key(text: "1", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: Tag.tag(key: "1")))}))
		schematic.add(row: 4, col: 1, key: Key(text: "2", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: Tag.tag(key: "2")))}))
		schematic.add(row: 4, col: 2, key: Key(text: "3", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: Tag.tag(key: "3")))}))
		schematic.add(row: 4, col: 3, w: 1, h: 2, key: Key(text: "=", uiColor: lemon, {self.chain.ok()}))

		schematic.add(row: 5, col: 0, w: 2, h: 1, key: Key(text: "0", uiColor: orange, {self.chain.post(token: Token.token(type: .operator, tag: Tag.tag(key: "0")))}))
		schematic.add(row: 5, col: 2, key: Key(text: ".", uiColor: orange, {self.chain.post(token: Token.token(type: .digit, tag: Tag.tag(key: ".")))}))
		
		self.schematic = schematic
}
	required init? (coder aDecoder: NSCoder) {fatalError()}

	func toggleIndexer() {}
}
