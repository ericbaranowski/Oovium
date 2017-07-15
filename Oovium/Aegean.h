//
//  Aegean.h
//  Oovium
//
//  Created by Joe Charlier on 2/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

typedef unsigned char byte;

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
	//	byte type;
} Obj;

// Slot ====
typedef struct Slot {
	char name[12];
	byte fixed;
	byte loaded;
	Obj obj;
} Slot;

// Memory ==
typedef struct Memory {
	Slot* slots;
	byte sn;
} Memory;

Memory* AEMemoryCreate(long sn);
void AEMemoryRelease(Memory* memory);
void AEMemoryFix(Memory* memory, byte index);
void AEMemoryClear(Memory* memory);
void AEMemoryPrint(Memory* memory);
byte AEMemoryIndexForName(Memory* memory, char* name);
double AEMemoryFirstValue(Memory* memory);

// Scratch =
typedef struct Scratch {
	Obj* stack;
	byte sp;
	byte cp;
	byte vp;
} Scratch;

Scratch* AEScratchCreate();
void AEScratchRelease(Scratch* scratch);

// Morphs ==
typedef enum {
	AEMorphAdd, AEMorphSub, AEMorphMul, AEMorphDiv, AEMorphMod, AEMorphPow, AEMorphEqual, AEMorphNotEqual,
	AEMorphLessThan, AEMorphLessThanOrEqual, AEMorphGreaterThan, AEMorphGreaterThanOrEqual, AEMorphNot,
	AEMorphAnd, AEMorphOr, AEMorphNeg, AEMorphAbs, AEMorphRound, AEMorphFloor, AEMorphSqrt, AEMorphFac,
	AEMorphExp, AEMorphLn, AEMorphLog, AEMorphTen, AEMorphTwo, AEMorphLog2, AEMorphSin, AEMorphCos,
	AEMorphTan, AEMorphAsin, AEMorphAcos, AEMorphAtan, AEMorphSec, AEMorphCsc, AEMorphCot, AEMorphSinh,
	AEMorphCosh, AEMorphTanh, AEMorphAsinh, AEMorphAcosh, AEMorphAtanh, AEMorphIf, AEMorphMin, AEMorphMax,
	AEMorphSum, AEMorphRandom, AEMorphVariable, AEMorphConstant
} AEMorph;

// Lambda ==
typedef struct Lambda {
	Obj* constants;
	byte cn;
	
	byte* variables;
	byte vn;
	
	byte* morphs;
	byte mn;
	
	byte vi;
	
} Lambda;

Lambda* AELambdaCreate(byte vi, Obj* constants, byte cn, byte* variables, byte vn, byte* morphs, byte mn);
void AELambdaRelease(Lambda* lambda);
void AELambdaPrint(Lambda* lambda);
void AELambdaExecute (Lambda* lambda, Scratch* scratch, Memory* memory);
//void AELambdaApplyTag (Lambda* lambda, )

// Task ====
typedef enum AETask {
	AETaskLambda,
	AETaskGoto,
	AETaskIfGoto,
	AETaskFork
} AETask;

typedef struct LambdaTask {
	Lambda* Lambda;
} LambdaTask;
typedef struct GotoTask {
	byte go2;
} GotoTask;
typedef struct IfGotoTask {
	byte index;
	byte go2;
} IfGotoTask;
typedef struct ForkTask {
	byte ifIndex;
	byte thenIndex;
	byte elseIndex;
	byte resultIndex;
} ForkTask;

typedef struct Task {
	AETask type;
	char* label;
	char* command;
	union {
		LambdaTask lambda;
		GotoTask go2;
		IfGotoTask ifGoto;
		ForkTask fork;
	};
} Task;

Task* AETaskCreateLambda(Lambda* lambda);
Task* AETaskCreateGoto(byte go2);
Task* AETaskCreateIfGoto(byte index,byte go2);
Task* AETaskCreateFork(byte ifIndex, byte thenIndex, byte elseIndex, byte resultIndex);
long AETaskExecute(Task* task, Memory* memory);
void AETaskPrint(Task* task);

// Recipe ==
typedef struct Recipe {
	Task** tasks;
	byte tn;
} Recipe;

Recipe* AERecipeCreate(long tn);
void AERecipeRelease(Recipe* recipe);
void AERecipeExecute(Recipe* recipe, Memory* memory);
void AERecipePrint(Recipe* recipe);

void startAegean();
