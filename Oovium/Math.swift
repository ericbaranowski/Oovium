//
//  Math.swift
//  Oovium
//
//  Created by Joe Charlier on 11/29/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

//CGFloat AEMathEvaluate (ScratchC* scratch) {
//	
//	for (int i=0;i<scratch->mn;i++) {
//		switch (scratch->morphs[i]) {
//		case OOMorphVariable:
//			AEScratchPush(scratch, AEScratchVariable(scratch));
//			break;
//		case OOMorphConstant:
//			AEScratchPush(scratch, AEScratchConstant(scratch));
//			break;
//		case OOMorphAdd:
//			AEScratchPush(scratch, AEScratchPop(scratch)+AEScratchPop(scratch));
//			break;
//		case OOMorphSubtract: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, a-b);
//			break;
//			}
//		case OOMorphMultiply:
//			AEScratchPush(scratch, AEScratchPop(scratch)*AEScratchPop(scratch));
//			break;
//		case OOMorphDivide: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, a/b);
//			break;
//			}
//		case OOMorphMod: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, fmod(a,b));
//			break;
//			}
//		case OOMorphPower: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			if (a >= 0)
//			AEScratchPush(scratch, pow(a,b));
//			else
//			AEScratchPush(scratch, NAN);
//			break;
//			}
//		case OOMorphEqual:
//			AEScratchPush(scratch, AEScratchPop(scratch)==AEScratchPop(scratch));
//			break;
//		case OOMorphNotEqual:
//			AEScratchPush(scratch, AEScratchPop(scratch)!=AEScratchPop(scratch));
//			break;
//		case OOMorphLesser: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, a<b);
//			break;
//			}
//		case OOMorphLesserEqual: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, a<=b);
//			break;
//			}
//		case OOMorphGreater: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, a>b);
//			break;
//			}
//		case OOMorphGreaterEqual: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, a>=b);
//			break;
//			}
//		case OOMorphNot: {
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, !a);
//			break;
//			}
//		case OOMorphAnd: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, a && b);
//			break;
//			}
//		case OOMorphOr: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, a || b);
//			break;
//			}
//		case OOMorphNeg:
//			AEScratchPush(scratch, -AEScratchPop(scratch));
//			break;
//		case OOMorphAbs:
//			AEScratchPush(scratch, fabs(AEScratchPop(scratch)));
//			break;
//		case OOMorphRound:
//			AEScratchPush(scratch, round(AEScratchPop(scratch)));
//			break;
//		case OOMorphFloor:
//			AEScratchPush(scratch, floor(AEScratchPop(scratch)));
//			break;
//		case OOMorphSqrt: {
//			CGFloat a = AEScratchPop(scratch);
//			if (a >= 0)
//			AEScratchPush(scratch, sqrt(a));
//			else
//			AEScratchPush(scratch, NAN);
//			break;
//			}
//		case OOMorphFactorial: {
//			int i = AEScratchPop(scratch);
//			CGFloat n = 1;
//			while (i>1) n*=i--;
//			AEScratchPush(scratch, n);
//			break;
//			}
//		case OOMorphExp:
//			AEScratchPush(scratch, exp(AEScratchPop(scratch)));
//			break;
//		case OOMorphLn:
//			AEScratchPush(scratch, log(AEScratchPop(scratch)));
//			break;
//		case OOMorphLog:
//			AEScratchPush(scratch, log10(AEScratchPop(scratch)));
//			break;
//		case OOMorphTen:
//			AEScratchPush(scratch, pow(10,AEScratchPop(scratch)));
//			break;
//		case OOMorphTwo:
//			AEScratchPush(scratch, pow(2,AEScratchPop(scratch)));
//			break;
//		case OOMorphLog2:
//			AEScratchPush(scratch, log2(AEScratchPop(scratch)));
//			break;
//		case OOMorphSin:
//			AEScratchPush(scratch, sin(AEScratchPop(scratch)));
//			break;
//		case OOMorphCos:
//			AEScratchPush(scratch, cos(AEScratchPop(scratch)));
//			break;
//		case OOMorphTan:
//			AEScratchPush(scratch, tan(AEScratchPop(scratch)));
//			break;
//		case OOMorphAsin:
//			AEScratchPush(scratch, asin(AEScratchPop(scratch)));
//			break;
//		case OOMorphAcos:
//			AEScratchPush(scratch, acos(AEScratchPop(scratch)));
//			break;
//		case OOMorphAtan:
//			AEScratchPush(scratch, atan(AEScratchPop(scratch)));
//			break;
//		case OOMorphSec:
//			AEScratchPush(scratch, 1/cos(AEScratchPop(scratch)));
//			break;
//		case OOMorphCsc:
//			AEScratchPush(scratch, 1/sin(AEScratchPop(scratch)));
//			break;
//		case OOMorphCot:
//			AEScratchPush(scratch, 1/tan(AEScratchPop(scratch)));
//			break;
//		case OOMorphSinh:
//			AEScratchPush(scratch, sinh(AEScratchPop(scratch)));
//			break;
//		case OOMorphCosh:
//			AEScratchPush(scratch, cosh(AEScratchPop(scratch)));
//			break;
//		case OOMorphTanh:
//			AEScratchPush(scratch, tanh(AEScratchPop(scratch)));
//			break;
//		case OOMorphAsinh:
//			AEScratchPush(scratch, asinh(AEScratchPop(scratch)));
//			break;
//		case OOMorphAcosh:
//			AEScratchPush(scratch, acosh(AEScratchPop(scratch)));
//			break;
//		case OOMorphAtanh:
//			AEScratchPush(scratch, atanh(AEScratchPop(scratch)));
//			break;
//		case OOMorphIf: {
//			CGFloat e = AEScratchPop(scratch);
//			CGFloat t = AEScratchPop(scratch);
//			CGFloat i = AEScratchPop(scratch);
//			AEScratchPush(scratch,i?t:e);
//			break;
//			}
//		case OOMorphMin: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, a<b?a:b);
//			break;
//			}
//		case OOMorphMax: {
//			CGFloat b = AEScratchPop(scratch);
//			CGFloat a = AEScratchPop(scratch);
//			AEScratchPush(scratch, a>b?a:b);
//			break;
//			}
//		case OOMorphRandom: {
//			u_int32_t n = AEScratchPop(scratch);
//			AEScratchPush(scratch, arc4random() % n);
//			break;
//			}
//		}
//	}
//
//	return AEScratchTop(scratch);
//}

class Math {
	static let addRR: (Lambda)->() = {(lambda: Lambda)->() in
		let x = lambda.pop() as! RealObj
		let y = lambda.pop() as! RealObj
		lambda.push(x+y)
	}
	static let addCC: (Lambda)->() = {(lambda: Lambda)->() in
		let x = lambda.pop() as! ComplexObj
		let y = lambda.pop() as! ComplexObj
		lambda.push(x+y)
	}
	static let addRC: (Lambda)->() = {(lambda: Lambda)->() in
		var x: ComplexObj
		var y: ComplexObj
		
		var t = lambda.pop()
		x = t is ComplexObj ? t as! ComplexObj : ComplexObj((t as! RealObj).x)

		t = lambda.pop()
		y = t is ComplexObj ? t as! ComplexObj : ComplexObj((t as! RealObj).x)

		lambda.push(x+y)
	}
}
