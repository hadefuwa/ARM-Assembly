@ Hamed Adefuwa
@ Program Objective
@ set array a with the following decimal values {42, 56, 23, 78, 60} 
@ and b with {25, 28, 11, 44, 29}.
@
@i = 0;
@while (i < 5) {
@     b[i] = a[i] – b[i] – (i * 2);
@     i = i + 1;
@}
@Mandatory: use register r3 to index array a and register r4 to index array b.
@

.data
.balign 4
arrayA: .skip 20 * 4 		@ defining array of 20 positions, each position with 4 bytes
arrayB: .skip 20 * 4 		@ defining array of 20 positions, each position with 4 bytes
return: .word 0 

.text
.global main
@ ---------------------------------------------------------------------------------------------
main: 
	ldr r3, =arrayA 	@ address pointing to the beginning of the first array of numbers
	mov r10, r3 		@ r10 works as backup for array A address
	ldr r4, =arrayB 	@ address pointing to the beginning of the first array of numbers
	mov r11, r4 		@ r11 works as backup for array B address

@ ---------------------------------------------------------------------------------------------
@store all values in array A {42, 56, 23, 78, 60}

	mov r9, #42
	str r9, [r3]   		@ store the number at the memory position pointed by r3
	add r3, r3, #4 		@ move 4 positions as each number occupies 4 bytes
	mov r9, #56
	str r9, [r3] 
	add r3, r3, #4 
	mov r9, #23
	str r9, [r3]
	add r3, r3, #4  
	mov r9, #78
	str r9, [r3] 
	add r3, r3, #4 
	mov r9, #60
	str r9, [r3]
@finished initialising array A
@ ---------------------------------------------------------------------------------------------
@reset r3 & clear r9

	mov r3, r10 		@reset r3 from backup
	mov r9, #0 		@clear r9 as this register was just used for storing 
				@and will be used for next array
@ ---------------------------------------------------------------------------------------------
@store all values in array B {25, 28, 11, 44, 29}

	mov r9, #25
	str r9, [r4]
	add r4, r4, #4
	mov r9, #28
	str r9, [r4] 
	add r4, r4, #4 
	mov r9, #11
	str r9, [r4]
	add r4, r4, #4  
	mov r9, #44
	str r9, [r4] 
	add r4, r4, #4 
	mov r9, #29
	str r9, [r4]
@finished initialising array B
@ ---------------------------------------------------------------------------------------------
@reset r4 & clear r9

	mov r4, r11 		@reset r4 from backup
	mov r9, #0 		@clear r9 again

@ ---------------------------------------------------------------------------------------------
@initialise i,a,b

	mov r8, #0 		@i = 0
	mov r5, #0 		@a = 0
	mov r6, #0 		@b = 0
	mov r0, #0		@register for storing 2i

@ ---------------------------------------------------------------------------------------------
@loop and calculations

do: 				

	ldr r5,[r3] 		@set a to first/next position of arrayA
	ldr r6,[r4] 		@set b to first/next position of arrayB

@b[i] = a[i] – b[i] – (i * 2);

	sub r6, r5, r6 		@b = a - b
	add r0, r8, r8 		@2i
	sub r6, r6, r0 		@b = b - 2i

@store result into Array B
	
	str r6, [r4]

@ ---------------------------------------------------------------------------------------------
@move positions in array

	add r3, r3, #4 		@move a to next position in array
	add r4, r4, #4 		@move b to next position in array

@ ---------------------------------------------------------------------------------------------
@move positions in array
@while (i < 5) {
@     i = i + 1;

	add r8, r8, #1 		@i++
	cmp r8, #5 		@is i == 5?
	blt do			@go back to do if < 5

	SWI 0
