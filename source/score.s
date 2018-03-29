.text
.global initScore
initScore:
	PUSH	{lr}

	// r0 - character
	// r1 - intial x
	// r2 - y
	// r3 - color

	LDR	r0, =scoreChar
	MOV	r1, #88
	MOV	r2, #864
	LDR	r3, =cWhite
	BL	drawWord
	POP	{pc}

.global	initLives
initLives:
	PUSH	{lr}

	// r0 - character
	// r1 - intial x
	// r2 - y
	// r3 - color

	LDR	r0, =livesChar
	MOV	r1, #468
	MOV	r2, #864
	LDR	r3, =cWhite
	BL	drawWord
	POP	{pc}


.global	updateScoreAndLives
updateScoreAndLives:
	PUSH	{r4, lr}

	MOV	r0, #160
	MOV	r1, #863
	MOV	r2, #0x0
	MOV	r3, #32
	MOV	r4, r3
	BL	makeTile

	MOV	r0, #544
	MOV	r1, #863
	MOV	r2, #0x0
	MOV	r3, #32
	MOV	r4, r3
	BL	makeTile

	LDR	r0, =scoreCount
	BL	intToString	// r0 - first digit
	MOV	r4, r1		// r1 - second digit

	MOV	r1, #165
	MOV	r2, #864
	BL	drawChar

	MOV	r0, r4
	MOV	r1, #176
	MOV	r2, #864
	BL	drawChar

	LDR	r0, =lifeCount
	BL	intToString	// r0 - first digit
	MOV	r4, r1		// r1 - second digit

	MOV	r1, #545
	MOV	r2, #864
	BL	drawChar

	MOV	r0, r4
	MOV	r1, #556
	MOV	r2, #864
	BL	drawChar

	POP	{r4, pc}

intToString:
	PUSH	{r4, r5, lr}
	LDR	r0, [r0]

	MOV	r4, #0
	divideLoop:
		CMP	r0, #10
		ADDGE	r4, r4, #1
		SUBGE	r0, #10
		BGE	divideLoop

	ADD	r1, r0, #48	// r1 - second digit, r0 is first
	ADD	r0, r4, #48	//converts to ascii version

	POP	{r4, r5, pc}


.global LOST
LOST:
	BL	updateScoreAndLives
        BL	clearPaddle
	BL	getRidOfBall

	LDR	r0,=gamelost
        MOV	r1, #200
	MOV	r2, #200
	BL      drawCenterTile
	B	anybutton

.global WIN
WIN:
        PUSH    {lr}
	BL	updateScoreAndLives

	LDR	r0,=gamewon
        MOV	r1, #200
	MOV	r2, #200
	BL      drawCenterTile
	POP	{pc}


.global	resetScore
resetScore:
	PUSH	{lr}

	LDR	r0, =scoreCount
	MOV	r1, #0
	STR	r1, [r0]

	LDR	r0, =lifeCount
	MOV	r1, #3
	STR	r1, [r0]

	POP	{pc}
.data
	scoreChar:	.asciz		"SCORE: "
	livesChar:	.asciz		"LIVES: "

	.global scoreCount
	scoreCount:	.int	12

	.global	lifeCount
	lifeCount:	.int	3
