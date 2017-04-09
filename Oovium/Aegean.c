//
//  Aegean.c
//  Oovium
//
//  Created by Joe Charlier on 2/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "Aegean.h"

// Memory ==========================================================================================
Memory* AEMemoryCreate (long sn) {
	Memory* memory = (Memory*)malloc(sizeof(Memory));
	memory->slots = (Slot*)malloc(sizeof(Slot)*sn);
	memory->sn = sn;
	
	for (int i=0;i<sn;i++) {
		memory->slots[i].fixed = 0;
		memory->slots[i].loaded = 0;
		memory->slots[i].obj.a.x = 0;
	}
	
	return memory;
}
void AEMemoryRelease (Memory* memory) {
	free(memory->slots);
	free(memory);
}
void AEMemoryFix(Memory* memory, long index) {
	memory->slots[index].fixed = 1;
}
void AEMemoryClear(Memory* memory) {
	for (int i=0;i<memory->sn;i++) {
		memory->slots[i].loaded = memory->slots[i].fixed;
	}
}
//public var description: String {
//	var sb = String()
//	sb.append("[ Memory ==================== ]\n")
//	for i in 0..<count  {
//		let index = String(format: "%2d", i)
//		let set: String = fixed[i] ? "O" : " "
//		let load: String = loaded[i] ? "O" : " "
//		let name: String  = names[i].padding(toLength: 12, withPad: " ", startingAt: 0)
//		let value: String = loaded[i] ? "\(values[i])" : "-"
//		sb.append("  [\(index)][\(set)][\(load)][\(name)][\(value)]\n")
//	}
//	sb.append("[ =========================== ]\n\n")
//	return sb
//}

void AEMemoryPrint(Memory* memory) {
	printf("[ Memory ==================== ]\n");
	for (int i=0;i<memory->sn;i++) {
		char value[12];
		if (memory->slots[i].loaded)
			sprintf(value, "%.0lf", memory->slots[i].obj.a.x);
		else
			sprintf(value, "-");
		printf("  [%2d][%c][%c][%-12s][%s]\n", i, memory->slots[i].fixed?'O':' ', memory->slots[i].loaded?'O':' ', memory->slots[i].name, value);
	}
	printf("[ =========================== ]\n\n");
}
Byte AEMemoryIndexForName (Memory* memory, char* name) {
	for (int i=0;i<memory->sn;i++) {
		if (strcmp(name, memory->slots[i].name) == 0)
			return i;
	}
	return -1;
}

// Scratch =========================================================================================
Scratch* AEScratchCreate() {
	Scratch* scratch = (Scratch*)malloc(sizeof(Scratch));
	scratch->stack = (Obj*)malloc(sizeof(Obj)*10);
	return scratch;
}
void AEScratchRelease(Scratch* scratch) {
	free(scratch->stack);
	free(scratch);
}

// Lambda ==========================================================================================
LambdaC* AELambdaCreate(Byte vi, Obj* constants, Byte cn, Byte* variables, Byte vn, Byte* morphs, Byte mn) {
	LambdaC* lambda = (LambdaC*)malloc(sizeof(LambdaC));
	
	lambda->vi = vi;
	
	lambda->constants = (Obj*)malloc(sizeof(Obj)*cn);
	for (int i=0;i<cn;i++)
		lambda->constants[i] = constants[i];
	lambda->cn = cn;
	
	lambda->variables = (Byte*)malloc(sizeof(Byte)*vn);
	for (int i=0;i<vn;i++)
		lambda->variables[i] = variables[i];
	lambda->vn = vn;
	
	lambda->morphs = (Byte*)malloc(sizeof(Byte)*mn);
	for (int i=0;i<mn;i++)
		lambda->morphs[i] = morphs[i];
	lambda->mn = mn;
	
	return lambda;
}
void AELambdaRelease(LambdaC* lambda) {
	free(lambda->constants);
	free(lambda->variables);
	free(lambda->morphs);
	free(lambda);
}
void AELambdaPrint (LambdaC* lambda) {
	printf("[ Lambda ==================== ]\n");
	printf("  index: %d\n", lambda->vi);
	printf("  constants:\n");
	for (int i=0;i<lambda->cn;i++)
		printf("  [%2d][%.0lf]\n", i, lambda->constants[i].a.x);
	printf("  variables:\n");
	for (int i=0;i<lambda->vn;i++)
		printf("  [%2d][%2d]\n", i, lambda->variables[i]);
	printf("  morphs:\n");
	for (int i=0;i<lambda->mn;i++)
		printf("  [%2d][%2d]\n", i, lambda->morphs[i]);
	printf("[ =========================== ]\n\n");
}
void AELambdaExecute (LambdaC* lambda, Scratch* scratch, Memory* memory) {
	scratch->cp = 0;
	scratch->vp = 0;
	scratch->sp = 0;
	
	for (int i=0;i<lambda->mn;i++) {
		switch (lambda->morphs[i]) {
			case AEMorphAdd: {
				scratch->stack[scratch->sp-2].a.x += scratch->stack[scratch->sp-1].a.x;
				scratch->sp--;
			} break;
				
			case AEMorphEqual: {
				scratch->stack[scratch->sp-2].a.x = (scratch->stack[scratch->sp-2].a.x == scratch->stack[scratch->sp-1].a.x);
				scratch->sp--;
			} break;
				
			case AEMorphConstant: {
				scratch->stack[scratch->sp].a.x = lambda->constants[scratch->cp].a.x;
				scratch->sp++;
				scratch->cp++;
			} break;
				
			case AEMorphVariable: {
				scratch->stack[scratch->sp].a.x = memory->slots[lambda->variables[scratch->vp]].obj.a.x;
				scratch->sp++;
				scratch->vp++;
			} break;
				
			default: {
			} break;
		}
	}
	
	memory->slots[lambda->vi].obj.a.x = scratch->stack[scratch->sp-1].a.x;
	memory->slots[lambda->vi].loaded = 1;
}

// Task ============================================================================================
Task* AETaskCreateLambda(LambdaC* lambda) {
	Task* task = (Task*)malloc(sizeof(Task));
	task->type = AETaskLambda;
	task->lambda.Lambda = lambda;
	return task;
}
Task* AETaskCreateGoto(Byte go2) {
	Task* task = (Task*)malloc(sizeof(Task));
	task->type = AETaskGoto;
	task->go2.go2 = go2;
	return task;
}
Task* AETaskCreateIfGoto(Byte index,Byte go2) {
	Task* task = (Task*)malloc(sizeof(Task));
	task->type = AETaskIfGoto;
	task->ifGoto.index = index;
	task->ifGoto.go2 = go2;
	return task;
}
Task* AETaskCreateFork(Byte ifIndex, Byte thenIndex, Byte elseIndex, Byte resultIndex) {
	Task* task = (Task*)malloc(sizeof(Task));
	task->type = AETaskFork;
	task->fork.ifIndex = ifIndex;
	task->fork.thenIndex = thenIndex;
	task->fork.elseIndex = elseIndex;
	task->fork.resultIndex = resultIndex;
	return task;
}

Scratch* scratch_;

long AETaskExecute (Task* task, Memory* memory) {
	switch (task->type) {
		case AETaskLambda: {
//			Scratch* scratch = AEScratchCreate();
//			AELambdaPrint(task->lambda.Lambda);
//			AEMemoryPrint(memory);
			AELambdaExecute(task->lambda.Lambda, scratch_, memory);
//			AEMemoryPrint(memory);
//			AEScratchRelease(scratch);
			return -1;
		} break;
		case AETaskGoto: {
			return task->go2.go2;
		} break;
		case AETaskIfGoto: {
			if (memory->slots[task->ifGoto.index].obj.a.x != 0) return -1;
			return task->ifGoto.go2;
		} break;
		case AETaskFork: {
			if (memory->slots[task->fork.ifIndex].obj.a.x != 0)
				memory->slots[task->fork.resultIndex].obj.a.x = memory->slots[task->fork.thenIndex].obj.a.x;
			else
				memory->slots[task->fork.resultIndex].obj.a.x = memory->slots[task->fork.elseIndex].obj.a.x;
			return -1;
		} break;
	}
}

// Recipe ==========================================================================================
Recipe* AERecipeCreate (long tn) {
	Recipe* recipe = (Recipe*)malloc(sizeof(Recipe));
	recipe->tasks = (Task**)malloc(sizeof(Task*)*tn);
	recipe->tn = tn;
	return recipe;
}
void AERecipeRelease (Recipe* recipe) {
	free(recipe->tasks);
	free(recipe);
}
void AERecipeExecute (Recipe* recipe, Memory* memory) {
	long tp = 0;
	while (tp < recipe->tn) {
		long go2 = AETaskExecute(recipe->tasks[tp], memory);
		tp = go2 == -1 ? tp+1 : go2;
	}
}

// PlayAegean ======================================================================================
void playAegean () {
	printf("Hello, Aegean!\n");
	
	scratch_ = AEScratchCreate();
	
//	Obj o;
//	o.a.x = 3.14;
//	o.b.n = 3;
//	o.c.p = (void*)4;
//	
//	printf("%lf\n",o.a.x);
//	printf("%ld\n",o.b.n);
//	printf("%p\n",o.c.p);
//	printf("sizeof(ObjC): %lu\n",sizeof(Obj));
//	printf("sizeof(Dim): %lu\n",sizeof(Dim));
//	printf("sizeof(Byte): %lu\n",sizeof(Byte));
//	printf("sizeof(long): %lu\n",sizeof(long));
//	printf("sizeof(double): %lu\n",sizeof(double));
//	printf("sizeof(char): %lu\n",sizeof(char));
//	printf("sizeof(int): %lu\n",sizeof(int));
//	printf("sizeof(short): %lu\n",sizeof(short));
//	printf("sizeof(float): %lu\n",sizeof(float));
//	printf("sizeof(long double): %lu\n",sizeof(long double));
//	printf("sizeof(Slot): %lu\n",sizeof(Slot));
//	
//	Memory* memory = AEMemoryCreate(10);
//	printf("sizeof(Memory<10>): %lu\n",sizeof(memory));
//	
//	Obj* objs = (Obj*)malloc(sizeof(Obj)*10);
//	for (int i=0;i<10;i++) {
//		objs[i].b.x = 2.71;
//	}
//	
//	for (int i=0;i<10;i++) {
//		printf("%lf\n", objs[i].b.x);
//	}
//	
//	Obj p,q;
//	
//	p.a.x = 3;
//	q = p;
//	p.a.x = 4;
//	printf("p: [%lf]\n",p.a.x);
//	printf("q: [%lf]\n",q.a.x);
}
