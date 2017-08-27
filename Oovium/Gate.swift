//
//  Gate.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Gate: Aexel {
	var ifChain: Chain!
	var thenChain: Chain!
	var elseChain: Chain!
	
	var ifTower: Tower
	var thenTower: Tower
	var elseTower: Tower
	var resultTower: Tower

// Inits ===========================================================================================
	public required init(iden: Int, at: V2, aether: Aether) {
		ifTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "GtI_\(iden)"))
		thenTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "GtT_\(iden)"))
		elseTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "GtE_\(iden)"))
		resultTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "GtR_\(iden)"))
		
//		ifChain = Chain()
//		thenChain = Chain()
//		elseChain = Chain()
		
		super.init(iden:iden, at:at, aether: aether)
	}
//	public required init (iden: Int, type: String, attributes: [String:Any]) {
//		ifTower = Tower(name: "GtI_\(iden)")
//		thenTower = Tower(name: "GtT_\(iden)")
//		elseTower = Tower(name: "GtE_\(iden)")
//		resultTower = Tower(name: "GtR_\(iden)")
//		
//		ifChain = Chain()
//		thenChain = Chain()
//		elseChain = Chain()
//		
//		super.init(iden: iden, type: type, attributes: attributes)
//	}
	public required init(attributes: [String:Any], parent: Domain) {
		let aether: Aether = parent as! Aether
		let iden: Int = attributes["iden"] as! Int
		
		ifTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "GtI_\(iden)"))
		thenTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "GtT_\(iden)"))
		elseTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "GtE_\(iden)"))
		resultTower = Tower(aether: aether, token: Token.token(type: .variable, tag: "GtR_\(iden)"))
		
		super.init(attributes: attributes, parent: parent)
	}

// Aexel ===========================================================================================
	override var freeVars: [String] {
		return []
	}
	
	override func plugIn() {
//		ifTower.name = "GtI_\(iden)"
//		ifTower.token = Token.token(type: .variable, tag: ifTower.name)
//		
//		thenTower.name = "GtT_\(iden)"
//		thenTower.token = Token.token(type: .variable, tag: thenTower.name)
//		
//		elseTower.name = "GtR_\(iden)"
//		elseTower.token = Token.token(type: .variable, tag: elseTower.name)
//		
//		resultTower.name = "GtR_\(iden)"
//		resultTower.token = Token.token(type: .variable, tag: resultTower.name)
		
		Tower.register(ifTower)
		Tower.register(thenTower)
		Tower.register(elseTower)
		Tower.register(resultTower)
	}
	override func wire (_ memory: UnsafeMutablePointer<Memory>) {
//		ifChain.tower = ifTower
//		thenChain.tower = thenTower
//		elseChain.tower = elseTower
		
		ifTower.wire(chain: ifChain, memory:memory)
		thenTower.wire(chain: thenChain, memory:memory)
		elseTower.wire(chain: elseChain, memory:memory)
		
//		let resultName = resultTower.token.tag
//		resultTower.index = AEMemoryIndexForName(memory, resultName.toInt8())
////		let forkTask = ForkTask(label: resultName, command: "\(resultName) = ~" ifIndex: ifTower.index, thenIndex: thenTower.index, elseIndex: elseTower.index, resultIndex: resultTower.index)
//		let forkTask = AETaskCreateFork(ifTower.index, thenTower.index, elseTower.index, resultTower.index)
//		forkTask?.pointee.label = resultName.toInt8()
//		forkTask?.pointee.command = "\(resultName) = ~".toInt8()
//		resultTower.task = forkTask
		
		ifTower.attach(resultTower)
		ifTower.gateTo = resultTower
		ifTower.thenTo = thenTower
		ifTower.elseTo = elseTower
		thenTower.gate = ifTower
		elseTower.gate = ifTower
		
		thenTower.attach(resultTower)
		elseTower.attach(resultTower)
	}
	override var towers: [Tower] {
		return [ifTower, thenTower, elseTower, resultTower]
	}
	
// Domain ==========================================================================================
	override func properties() -> [String] {
		return super.properties() + ["ifChain", "thenChain", "elseChain"]
	}
}
