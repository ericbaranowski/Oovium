//
//  Object.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Object: Aexel {
	var chain: Chain!
	
	var tower: Tower
	
	var token: Token {
		return tower.token!
	}
	
// Inits ===========================================================================================
	public required init(iden: Int, at: V2, aether: Aether) {
		tower = Tower(aether: aether, token: Token.token(type: .variable, tag: "Ob_\(iden)"))
		chain = Chain()
		super.init(iden:iden, at:at, aether: aether)
		self.name = tower.name
	}
//	public required init (iden: Int, type: String, attributes: [String:Any]) {
//		let name = "Ob_\(iden)"
//		tower = Tower(name: name)
//		chain = Chain()
//		super.init(iden: iden, type: type, attributes: attributes)
//		self.name = name
//	}
	public required init(attributes: [String:Any], parent: Domain) {
		let aether: Aether = parent as! Aether
		let iden: Int = attributes["iden"] as! Int
		
		tower = Tower(aether: aether, token: Token.token(type: .variable, tag: "Ob_\(iden)"))
		
		super.init(attributes: attributes, parent: parent)
	}
	
// Actions =========================================================================================
	func ok() {
		chain.ok()
	}
	
// Events ==========================================================================================
	func onOK() {
		if let task = tower.task {
			AETaskRelease(task)
		}
		
		tower.task = AETaskCreateLambda(chain.compile(name: tower.name, memory: aether.memory))
		AETaskExecute(tower.task, aether.memory)
		token.display = "\(chain.display)"
		AEMemoryPrint(aether.memory)
	}
//	override func onLoad() {
//		let task = AETaskCreateLambda(chain.compile(name: tower.name, memory: aether.memory))
//		tower.task = task
//	}
//	override func onLoaded() {
//		tower.aether = parent as! Aether
//	}
	
// Aexel ===========================================================================================
	override var freeVars: [String] {
		guard tower.web == nil else {return super.freeVars}
		return [name]
	}
	
	override func plugIn() {
//		tower.name = "Ob_\(iden)"
//		tower.token = Token.token(type: .variable, tag: tower.name)
		Tower.register(tower)
	}
	override func wire (_ memory: UnsafeMutablePointer<Memory>) {
//		chain.tower = tower
		tower.wire(chain:chain, memory:memory)
	}
	override var towers: [Tower] {
		return [tower]
	}
	
	override func generateTokens() {
		
	}
	override func wireTowers() {
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["chain"]
	}
}
