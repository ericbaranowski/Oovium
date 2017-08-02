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
	public required init(iden: Int, at: V2) {
		ifTower = Tower(name: String(format: "IFI%05d", 0))
		thenTower = Tower(name: String(format: "IFT%05d", 0))
		elseTower = Tower(name: String(format: "IFE%05d", 0))
		resultTower = Tower(name: String(format: "IF%05d", 0))
		super.init(iden:iden, at:at)
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		ifTower = Tower(name: String(format: "IFI%05d", iden))
		thenTower = Tower(name: String(format: "IFT%05d", iden))
		elseTower = Tower(name: String(format: "IFE%05d", iden))
		resultTower = Tower(name: String(format: "IF%05d", iden))
		super.init(iden: iden, type: type, attributes: attributes)
	}

// Aexel ===========================================================================================
	override var freeVars: [String] {
		return []
	}
	
	override func plugIn() {
		ifTower.name = String(format: "IFI%05d", iden)
		ifTower.token = Token.token(type: .variable, tag: ifTower.name)
		
		thenTower.name = String(format: "IFT%05d", iden)
		thenTower.token = Token.token(type: .variable, tag: thenTower.name)
		
		elseTower.name = String(format: "IFE%05d", iden)
		elseTower.token = Token.token(type: .variable, tag: elseTower.name)
		
		resultTower.name = String(format: "IF%05d", iden)
		resultTower.token = Token.token(type: .variable, tag: resultTower.name)
		
		Tower.register(ifTower)
		Tower.register(thenTower)
		Tower.register(elseTower)
		Tower.register(resultTower)
	}
	override func wire (_ memory: UnsafeMutablePointer<Memory>) {
		ifChain.tower = ifTower
		thenChain.tower = thenTower
		elseChain.tower = elseTower
		
		ifTower.wire(chain: ifChain, memory:memory)
		thenTower.wire(chain: thenChain, memory:memory)
		elseTower.wire(chain: elseChain, memory:memory)
		
		let resultName = resultTower.token.tag
		resultTower.index = AEMemoryIndexForName(memory, resultName.toInt8())
//		let forkTask = ForkTask(label: resultName, command: "\(resultName) = ~" ifIndex: ifTower.index, thenIndex: thenTower.index, elseIndex: elseTower.index, resultIndex: resultTower.index)
		let forkTask = AETaskCreateFork(ifTower.index, thenTower.index, elseTower.index, resultTower.index)
		forkTask?.pointee.label = resultName.toInt8()
		forkTask?.pointee.command = "\(resultName) = ~".toInt8()
		resultTower.task = forkTask
		
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
