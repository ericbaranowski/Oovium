//
//  Aegean.c
//  Oovium
//
//  Created by Joe Charlier on 2/4/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

#include <math.h>
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
void AEMemoryFix(Memory* memory, byte index) {
	memory->slots[index].fixed = 1;
}
void AEMemoryClear(Memory* memory) {
	for (int i=0;i<memory->sn;i++) {
		memory->slots[i].loaded = memory->slots[i].fixed;
	}
}
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
byte AEMemoryIndexForName (Memory* memory, char* name) {
	for (int i=0;i<memory->sn;i++) {
		if (strcmp(name, memory->slots[i].name) == 0)
			return i;
	}
	return -1;
}
double AEMemoryFirstValue(Memory* memory) {
	return memory->slots[0].obj.a.x;
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
Lambda* AELambdaCreate(byte vi, Obj* constants, byte cn, byte* variables, byte vn, byte* morphs, byte mn) {
	Lambda* lambda = (Lambda*)malloc(sizeof(Lambda));
	
	lambda->vi = vi;
	
	lambda->constants = (Obj*)malloc(sizeof(Obj)*cn);
	for (int i=0;i<cn;i++)
		lambda->constants[i] = constants[i];
	lambda->cn = cn;
	
	lambda->variables = (byte*)malloc(sizeof(byte)*vn);
	for (int i=0;i<vn;i++)
		lambda->variables[i] = variables[i];
	lambda->vn = vn;
	
	lambda->morphs = (byte*)malloc(sizeof(byte)*mn);
	for (int i=0;i<mn;i++)
		lambda->morphs[i] = morphs[i];
	lambda->mn = mn;
	
	return lambda;
}
void AELambdaRelease(Lambda* lambda) {
	free(lambda->constants);
	free(lambda->variables);
	free(lambda->morphs);
	free(lambda);
}
void AELambdaPrint (Lambda* lambda) {
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
void AELambdaExecute (Lambda* lambda, Scratch* scratch, Memory* memory) {
	scratch->cp = 0;
	scratch->vp = 0;
	scratch->sp = 0;
	
	for (int i=0;i<lambda->mn;i++) {
		switch (lambda->morphs[i]) {
			case AEMorphAdd: {
				scratch->stack[scratch->sp-2].a.x += scratch->stack[scratch->sp-1].a.x;
				scratch->sp--;
			} break;

			case AEMorphSub: {
				scratch->stack[scratch->sp-2].a.x -= scratch->stack[scratch->sp-1].a.x;
				scratch->sp--;
			} break;

			case AEMorphMul: {
				scratch->stack[scratch->sp-2].a.x *= scratch->stack[scratch->sp-1].a.x;
				scratch->sp--;
			} break;

			case AEMorphDiv: {
				scratch->stack[scratch->sp-2].a.x /= scratch->stack[scratch->sp-1].a.x;
				scratch->sp--;
			} break;
				
			case AEMorphPow: {
				scratch->stack[scratch->sp-2].a.x = pow(scratch->stack[scratch->sp-2].a.x,scratch->stack[scratch->sp-1].a.x);
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
Task* AETaskCreateLambda(Lambda* lambda) {
	Task* task = (Task*)malloc(sizeof(Task));
	task->type = AETaskLambda;
	task->lambda.Lambda = lambda;
	return task;
}
Task* AETaskCreateGoto(byte go2) {
	Task* task = (Task*)malloc(sizeof(Task));
	task->type = AETaskGoto;
	task->go2.go2 = go2;
	return task;
}
Task* AETaskCreateIfGoto(byte index,byte go2) {
	Task* task = (Task*)malloc(sizeof(Task));
	task->type = AETaskIfGoto;
	task->ifGoto.index = index;
	task->ifGoto.go2 = go2;
	return task;
}
Task* AETaskCreateFork(byte ifIndex, byte thenIndex, byte elseIndex, byte resultIndex) {
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
char* AETaskCommand(Task* task) {
	int n = 32;
	char* sb = malloc(sizeof(char)*n);
	
	switch (task->type) {
		case AETaskGoto: {
			snprintf(sb, n,"GOTO %d", task->go2.go2);
		} break;
			
		case AETaskIfGoto: {
			snprintf(sb, n,"IF %d == FALSE THEN GOTO %d", task->ifGoto.index, task->ifGoto.go2);
		} break;
			
		case AETaskFork: {
			snprintf(sb, n, "fork");
		} break;
			
		case AETaskLambda: {
			snprintf(sb, n, "lambda");
		} break;
	}
	
	return sb;
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
void AERecipePrint(Recipe* recipe) {
	printf("[ Recipe ============================================= ]\n");
	for (int i=0;i<recipe->tn;i++) {
		Task* task = recipe->tasks[i];
		printf("  %2d> %12s : %-32s\n", i, task->label, task->command);
	}
	printf("[ ==================================================== ]\n\n");
}

// Aegean ==========================================================================================
void startAegean() {
	scratch_ = AEScratchCreate();
}
