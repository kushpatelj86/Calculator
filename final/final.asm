; This program is a one-digit simple calculator which 
; uses 4 different operators and 5 integers from 1-9.

; This is a macro for printing to the terminal
%macro	print 	2		
        mov     rax, 1					
        mov     rdi, 1					
        mov     rsi, %1					
        mov     rdx, %2					
        syscall						
%endmacro
; This macro is to receive input from the terminal/keyboard
%macro	scan 	2
        mov     rax, 0					
        mov     rdi, 0					
        mov     rsi, %1					
        mov     rdx, %2					
        syscall						
%endmacro
; These data are for values (input, numbers, symbols, and total)
section .bss
buffer	resb	10
num1	resb	1
num2	resb	1
num3	resb	1
num4	resb	1    
num5	resb	1
total	resb	1
sym1	resb	1
sym2	resb	1
sym3	resb	1
sym4	resb	1
; These data are for the output to terminal
section .data
msg1	db	"Enter Operations String: "
msg3	db	" = "
ascii	db	"00", 10

section .text
        global _start
_start:
	print	msg1, 25				
	scan	buffer, 10	
; The below section intakes the values input by the user
; and converts them to numerical values so they can be calculated				
	mov	al, byte[buffer+0]	; Lines 46-47: Converts first input ascii value to numer
	and	al, 0fh
	mov	byte[num1], al		; Stores into num1
	
	mov	al, byte[buffer+1]	; Lines 50-51: Stores first input symbol in sym1
	mov	byte[sym1], al
	
	mov	al, byte[buffer+2]	; Lines 53-54: Converts second input ascii value to nume
	and	al, 0fh
	mov	byte[num2], al		; Stores into num2
	
	mov	al, byte[buffer+3]	; Lines 57-58: Stores second input symbol in sym2
	mov	byte[sym2], al
	
	mov	al, byte[buffer+4]	; Lines 60-61: Converts third input ascii value to numer
	and	al, 0fh
	mov	byte[num3], al		; Stores into num3
	
	mov	al, byte[buffer+5]	; Lines 64-65: Stores third input symbol in sym3
	mov	byte[sym3], al
	
	mov	al, byte[buffer+6]	; Lines 67-68: Converts fourth input ascii value to nume
	and	al, 0fh
	mov	byte[num4], al		; Stores into num4
	
	mov	al, byte[buffer+7]	; Lines 71-72: Stores fourth input symbol in sym4
	mov	byte[sym4], al
	
	mov	al, byte[buffer+8]	; Lines 74-75: Converts fifth input ascii value to numer
	and	al, 0fh
	mov	byte[num5], al		; Stores into num5
	
	mov	al, byte[num1]		; Lines 78-79: Moves num1 into total
	mov	byte[total], al				
; The below section evaluates which operator sym1 is (+, -, /, or *) and jumps t
	cmp	byte[sym1], '+'		; Compares sym1 to '+'			
	jne	skip11			; If sym1 != '+', jump to "skip11" 
	mov	dil, byte[total]	; Lines 83-84, moves total and num2 into dil and sil
	mov	sil, byte[num2]
	call	addition		; Since '+' must = sym1, call addition
	jmp	second			; Jump to "second"
skip11:
	cmp	byte[sym1], '-'		; Compares sym1 to '-'
	jne	skip12			; If sym1 != '-', jump to "skip12"

	mov	dil, byte[total]	; Lines 91-92, moves total and num2 into dil and sil
	mov	sil, byte[num2]
	call	subtraction		; Since '-' must = sym1, call subtraction
	jmp	second			; Jump to "second"
skip12:
	
	cmp	byte[sym1], '*'		; Compares sym1 to '*'			
	jne	skip13			; If sym1 != '*', jump to "skip13"

	mov	dil, byte[total]	; Lines 100-101: moves total and num2 into dil and sil
	mov	sil, byte[num2]
	call	multiplication		; Since '*' must = sym1, call multiplication
	jmp	second			; Jump to "second"
skip13:
	cmp	byte[sym1], '/'		; Compares sym1 to '/'
	jne	second			; If sym1 != '/', jump to end

	mov	dil, byte[total]	; Lines 108-109: moves total and num2 into dil and sil
	mov	sil, byte[num2]
	call	division		; Since '/' must = sym1, call division
; The below section evaluates which operator sym2 is (+, -, /, or *) and jumps t
second:

cmp	byte[sym2], '+'		; Compares sym1 to '+'			
	jne	skip21			; If sym1 != '+', jump to "skip11" 
	mov	dil, byte[total]	; Lines 83-84, moves total and num2 into dil and sil
	mov	sil, byte[num3]
	call	addition		; Since '+' must = sym1, call addition
	jmp	third			; Jump to "second"
skip21:
	cmp	byte[sym2], '-'		; Compares sym1 to '-'
	jne	skip22			; If sym1 != '-', jump to "skip12"

	mov	dil, byte[total]	; Lines 91-92, moves total and num2 into dil and sil
	mov	sil, byte[num3]
	call	subtraction		; Since '-' must = sym1, call subtraction
	jmp	third			; Jump to "second"
skip22:
	
	cmp	byte[sym2], '*'		; Compares sym1 to '*'			
	jne	skip23			; If sym1 != '*', jump to "skip13"

	mov	dil, byte[total]	; Lines 100-101: moves total and num2 into dil and sil
	mov	sil, byte[num3]
	call	multiplication		; Since '*' must = sym1, call multiplication
	jmp	third			; Jump to "second"
skip23:
	cmp	byte[sym2], '/'		; Compares sym1 to '/'
	jne	second			; If sym1 != '/', jump to end

	mov	dil, byte[total]	; Lines 108-109: moves total and num2 into dil and sil
	mov	sil, byte[num3]
	call	division		; Since '/' must = sym1, call division
; The below section evaluates which operator sym2 is (+, -, /, or *) and jumps t

third:
cmp	byte[sym3], '+'		; Compares sym1 to '+'			
	jne	skip31			; If sym1 != '+', jump to "skip11" 
	mov	dil, byte[total]	; Lines 83-84, moves total and num2 into dil and sil
	mov	sil, byte[num4]
	call	addition		; Since '+' must = sym1, call addition
	jmp	fourth			; Jump to "second"
skip31:
	cmp	byte[sym3], '-'		; Compares sym1 to '-'
	jne	skip32			; If sym1 != '-', jump to "skip12"

	mov	dil, byte[total]	; Lines 91-92, moves total and num2 into dil and sil
	mov	sil, byte[num4]
	call	subtraction		; Since '-' must = sym1, call subtraction
	jmp	fourth			; Jump to "second"
skip32:
	
	cmp	byte[sym3], '*'		; Compares sym1 to '*'			
	jne	skip33			; If sym1 != '*', jump to "skip13"

	mov	dil, byte[total]	; Lines 100-101: moves total and num2 into dil and sil
	mov	sil, byte[num4]
	call	multiplication		; Since '*' must = sym1, call multiplication
	jmp	fourth			; Jump to "second"
skip33:
	cmp	byte[sym3], '/'		; Compares sym1 to '/'
	jne	fourth			; If sym1 != '/', jump to end

	mov	dil, byte[total]	; Lines 108-109: moves total and num2 into dil and sil
	mov	sil, byte[num4]
	call	division		; Since '/' must = sym1, call division
; The below section evaluates which operator sym2 is (+, -, /, or *) and jumps t


fourth:
       cmp	byte[sym4], '+'		; Compares sym1 to '+'			
	jne	skip41			; If sym1 != '+', jump to "skip11" 
	mov	dil, byte[total]	; Lines 83-84, moves total and num2 into dil and sil
	mov	sil, byte[num5]
	call	addition		; Since '+' must = sym1, call addition
	jmp	done			; Jump to "second"
skip41:
	cmp	byte[sym4], '-'		; Compares sym1 to '-'
	jne	skip42			; If sym1 != '-', jump to "skip12"
	mov	dil, byte[total]	; Lines 91-92, moves total and num2 into dil and sil
	mov	sil, byte[num5]
	call	subtraction		; Since '-' must = sym1, call subtraction
	jmp	done			; Jump to "second"
skip42:
	
	cmp	byte[sym4], '*'		; Compares sym1 to '*'			
	jne	skip43			; If sym1 != '*', jump to "skip13"
	mov	dil, byte[total]	; Lines 100-101: moves total and num2 into dil and sil
	mov	sil, byte[num5]
	call	multiplication		; Since '*' must = sym1, call multiplication
	jmp	done			; Jump to "second"
skip43:
	cmp	byte[sym4], '/'		; Compares sym1 to '/'
	jne	done			; If sym1 != '/', jump to end
	mov	dil, byte[total]	; Lines 108-109: moves total and num2 into dil and sil
	mov	sil, byte[num5]
	call	division		; Since '/' must = sym1, call division
; The below section evaluates which operator sym2 is (+, -,   

done:
    mov al, byte[total]
	mov ah, 0
	mov bl, 10
	div bl
	add byte[ascii + 0], al
	add byte[ascii + 1], ah
	print ascii, 3

        mov     rax, 60			; Lines 218-220: end of program		
        mov     rdi, 0					
        syscall						 

addition:				; Lines 223-224: Performs addition
	mov	al, dil 			
	add	al, sil				
	mov	byte[total], al		; Updates value of total
	ret				; Returns back to line prior to calling
	
subtraction:				; Lines 229-230: Performs subtraction
	mov	al, dil 			
	sub	al, sil				
	mov	byte[total], al		; Updates value of total
	ret				; Returns back to line prior to calling

multiplication:				; Lines 235-236: Performs multiplication
	mov	al, dil 			
	mul	sil				
	mov	byte[total], al		; Updates value of total
	ret				; Returns back to line prior to calling
	
division:				; Lines 241-242: Performs division
	mov	al, dil 
	mov ah, 0			
	div	sil				
	mov	byte[total], al		; Updates value of total
	ret				; Returns back to place prior to calling