//
//  OoviumTests.swift
//  OoviumTests
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import XCTest
@testable import Oovium

class OoviumTests: XCTestCase {
    
//    override func setUp() {
//        super.setUp()
//    }
//    override func tearDown() {
//        super.tearDown()
//    }
	
//    func testPerformanceExample() {
//        self.measure {
//        }
//    }
	
	func testMath() {
		let lambda: Lambda = Lambda(morphs: [RealDef.cons, RealDef.cons, RealDef.add], cons: [RealObj(2), RealObj(2)], vars: [])
		
		let obj: RealObj = lambda.evaluate(vars: [String:Obj?]())[0] as! RealObj
		XCTAssert(obj.value==4.0, "[\(obj.value) != 4.0]")
		
		
	}
	
	func percent (_ k: Int, _ n: Int) -> Double {
		return Double(Int(Double(k)/Double(n)*1000))/10.0
	}
	
	func result (_ o1: Int, _ o2: Int, _ o3: Int, _ d1: Int, _ d2: Int) -> Int {
		let maxD = d1>d2 ? d1 : d2
		let minD = d1>d2 ? d2 : d1
		
		var maxO: Int
		var minO: Int
		if (o1 > o2 && o1 > o3) {
			maxO = o1
			minO = o2>o3 ? o2 : o3
		} else {
			if o2 > o3 {
				maxO = o2
				minO = o1>o3 ? o1 : o3
			} else {
				maxO = o3
				minO = o1>o2 ? o1 : o2
			}
		}
		
		var kills = 0
		if maxO > maxD {
			kills += 1
		}
		if minO > minD {
			kills += 1
		}
		
		return kills
	}

	func testRisk() {
		var k0 = 0
		var k1 = 0
		var k2 = 0
		for o1 in 1...6 {for o2 in 1...6 {for o3 in 1...6 {for d1 in 1...6 {for d2 in 1...6 {
			let kills = result(o1, o2, o3, d1, d2)
			if kills == 0 {
				k0 += 1
			} else if kills == 1 {
				k1 += 1
			} else if kills == 2 {
				k2 += 1
			}
			}}}}}
		
//		k0
//		k1
//		k2
//		k0+k1+k2
		
		let n = 6*6*6*6*6
		
		print("Kill 2: [\(percent(k2,n))%]")
		print("Kill 1: [\(percent(k1,n))%]")
		print("Kill 0: [\(percent(k0,n))%]")
	}
}
