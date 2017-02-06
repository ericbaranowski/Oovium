//
//  Aegean.h
//  Oovium
//
//  Created by Joe Charlier on 2/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

//typedef enum {
//	AEMorphVariable,
//	AEMorphConstant,
//	AEMorphAdd,
//	AEMorphSubtract,
//	AEMorphMultiply,
//	AEMorphDivide,
//	AEMorphMod,
//	AEMorphPower,
//	AEMorphEqual,
//	AEMorphNotEqual,
//	AEMorphLesser,
//	AEMorphLesserEqual,
//	AEMorphGreater,
//	AEMorphGreaterEqual,
//	AEMorphNot,
//	AEMorphAnd,
//	AEMorphOr,
//	AEMorphNeg,
//	AEMorphAbs,
//	AEMorphRound,
//	AEMorphFloor,
//	AEMorphSqrt,
//	AEMorphFactorial,
//	AEMorphExp,
//	AEMorphLn,
//	AEMorphLog,
//	AEMorphTen,
//	AEMorphTwo,
//	AEMorphLog2,
//	AEMorphSin,
//	AEMorphCos,
//	AEMorphTan,
//	AEMorphAsin,
//	AEMorphAcos,
//	AEMorphAtan,
//	AEMorphSec,
//	AEMorphCsc,
//	AEMorphCot,
//	AEMorphSinh,
//	AEMorphCosh,
//	AEMorphTanh,
//	AEMorphAsinh,
//	AEMorphAcosh,
//	AEMorphAtanh,
//	AEMorphIf,
//	AEMorphMin,
//	AEMorphMax,
//	AEMorphRandom
//} AEMorph;

typedef unsigned char Byte;

// Dim =====
typedef union {
	long n;
	double x;
	void* p;
} Dim;

// Obj =====
typedef struct {
	Dim a;
	Dim b;
	Dim c;
	//	Byte type;
} Obj;

// Slot ====
typedef struct Slot {
	char name[12];
	Byte fixed;
	Byte loaded;
	Obj obj;
} Slot;

// Memory ==
typedef struct Memory {
	Slot* slots;
	Byte sn;
} Memory;

Memory* AEMemoryCreate(long sn);
void AEMemoryRelease();
void AEMemoryFix(Memory* memory, long index);
void AEMemoryClear(Memory* memory);
void AEMemoryPrint(Memory* memory);
Byte AEMemoryIndexForName(Memory* memory, char* name);

// Scratch =
typedef struct Scratch {
	Obj* stack;
	Byte sp;
	Byte cp;
	Byte vp;
} Scratch;

Scratch* AEScratchCreate();
void AEScratchRelease(Scratch* scratch);

// Morphs ==
typedef enum {
	AEMorphAdd,
	AEMorphEqual,
	AEMorphVariable,
	AEMorphConstant
} AEMorph;

// Lambda ==
typedef struct LambdaC {
	Obj* constants;
	Byte cn;
	
	Byte* variables;
	Byte vn;
	
	Byte* morphs;
	Byte mn;
	
	Byte vi;
	
} LambdaC;

LambdaC* AELambdaCreate(Byte vi, Obj* constants, Byte cn, Byte* variables, Byte vn, Byte* morphs, Byte mn);
void AELambdaRelease(LambdaC* lambda);
void AELambdaPrint(LambdaC* lambda);
void AELambdaExecute (LambdaC* lambda, Scratch* scratch, Memory* memory);

// Task ====
typedef enum AETask {
	AETaskLambda,
	AETaskGoto,
	AETaskIfGoto,
	AETaskFork
} AETask;

typedef struct LambdaTask {
	LambdaC* Lambda;
} LambdaTask;
typedef struct GotoTask {
	Byte go2;
} GotoTask;
typedef struct IfGotoTask {
	Byte index;
	Byte go2;
} IfGotoTask;
typedef struct ForkTask {
	Byte ifIndex;
	Byte thenIndex;
	Byte elseIndex;
	Byte resultIndex;
} ForkTask;

typedef struct Task {
	AETask type;
	union {
		LambdaTask lambda;
		GotoTask go2;
		IfGotoTask ifGoto;
		ForkTask fork;
	};
} Task;

Task* AETaskCreateLambda(LambdaC* lambda);
Task* AETaskCreateGoto(Byte go2);
Task* AETaskCreateIfGoto(Byte index,Byte go2);
Task* AETaskCreateFork(Byte ifIndex, Byte thenIndex, Byte elseIndex, Byte resultIndex);

// Recipe ==
typedef struct Recipe {
	Task** tasks;
	Byte tn;
} Recipe;

Recipe* AERecipeCreate(long tn);
void AERecipeRelease(Recipe* recipe);
void AERecipeExecute(Recipe* recipe, Memory* memory);

void playAegean();
