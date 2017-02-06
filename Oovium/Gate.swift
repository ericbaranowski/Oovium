//
//  Gate.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

public final class Gate: Aexel {
	var ifTokens: String = ""
	var thenTokens: String = ""
	var elseTokens: String = ""

	var ifChain = Chain()
	var thenChain = Chain()
	var elseChain = Chain()
	
	var ifTower = Tower()
	var thenTower = Tower()
	var elseTower = Tower()
	var resultTower = Tower()
	
// Aexel ===========================================================================================
	override func plugIn () {
		ifTower.name = String(format: "IFI%05d", iden)
		ifTower.token = Token.token(type: .variable, tag: Tag.tag(key: ifTower.name))
		
		thenTower.name = String(format: "IFT%05d", iden)
		thenTower.token = Token.token(type: .variable, tag: Tag.tag(key: thenTower.name))
		
		elseTower.name = String(format: "IFE%05d", iden)
		elseTower.token = Token.token(type: .variable, tag: Tag.tag(key: elseTower.name))
		
		resultTower.name = String(format: "IF%05d", iden)
		resultTower.token = Token.token(type: .variable, tag: Tag.tag(key: resultTower.name))
		
		aether.link(ifTower)
		aether.link(thenTower)
		aether.link(elseTower)
		aether.link(resultTower)
	}
	override func wire (_ memory: UnsafeMutablePointer<Memory>, memoryS: MemoryS) {
		ifChain = Chain(string: ifTokens)
		thenChain = Chain(string: thenTokens)
		elseChain = Chain(string: elseTokens)
		
		ifTower.wire(chain: ifChain, memory:memory, memoryS: memoryS)
		thenTower.wire(chain: thenChain, memory:memory, memoryS: memoryS)
		elseTower.wire(chain: elseChain, memory:memory, memoryS: memoryS)
		
		let resultName = resultTower.token.tag.key
		resultTower.index = memoryS.index(for: resultName)
		let forkTask = ForkTask(/*label: resultName, command: "\(resultName) = ~"*/ifIndex: ifTower.index, thenIndex: thenTower.index, elseIndex: elseTower.index, resultIndex: resultTower.index)
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
	override func towers () -> [Tower] {
		return [ifTower, thenTower, elseTower, resultTower]
	}
	
// Domain ==========================================================================================
	override func properties () -> [String] {
		return super.properties() + ["ifTokens", "thenTokens", "elseTokens"]
	}
}
