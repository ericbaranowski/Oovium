//
//  main.swift
//  Oov
//
//  Created by Joe Charlier on 4/22/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import Foundation

print("Oovium =====================================================================")

Math.start()

while (true) {
	print("Oov> ", separator: "", terminator: "")
	let response = readLine();
	if let response = response {
		if response == "exit" {break}
		
		let chain: Chain = Chain(string: response)
		do {
			try chain.compile()
			let lambda = chain.lambda
			lambda.vi = 0
			let memory = AEMemoryCreate(1)!
			lambda.compile(memory: memory)
			let lambdaC = lambda.lambdaC
			let scratch = AEScratchCreate()
			AELambdaExecute(lambdaC, scratch, memory)
			let x: Double = AEMemoryFirstValue(memory)
			print(" = \(x)")
			
		} catch {
			print("[\(response)] is an invalid command")
			print(error)
		}
		
	}
}
