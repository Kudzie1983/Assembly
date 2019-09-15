;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	openPrompt	db	"Welcome to my Program", 0dh, 0ah, 0h	;Prompt String
		.size	equ	$-openPrompt			;Length of Prompt String
											; $ means current address. in above its current address minus openprompt address.
											
	goodbyeMsg db "program ending, have a good day",  0h
	
	hexMsg db "the hex value of your number: ",0h
	decMsg db "the decimal value of your number: ",0h
	binMsg db "the binary value of your number: ",0h
 
SECTION .bss
 
SECTION     .text
	global      _start
     
_start:
	;
	;Display Program Header
    push	openPrompt			;The prompt address - argument #1
    push	openPrompt.size		;The size of the prompt string - argument #2
    call    PrintText			;print it 
    
    mov eax, 1h					; mov some data into the register
    mov ecx, 2h					;to test our print register function
    mov ebx, 3h
    mov edx, 4h
    
	call PrintRegisters 			;Print the cpu registers 	
	call Printendl				;then print a number of blanks
	call Printendl				;
	
	mov eax, 123456h 			;will be used to test printing numbers 
	
	push eax 					; puts the number we wish to print int stack
	push decMsg					;prints the dec output message before number 
	call PrintString
	call Print32bitNumDecimal	;prints the number 
	call Printendl	
	
					;
	push eax 					; puts the number we wish to print int stack
	push hexMsg	
	call PrintString
	call Print32bitNumHex		;prints the number 
	call Printendl				;
	
	
	push eax 					; puts the number we wish to print int stack
	push binMsg
	call PrintString
	call Print32bitNumBinary	;prints the number 
	call Printendl	
	call Printendl			;
	
    
    push goodbyeMsg 			; Print the goodbye msg before ending program.
    call PrintString
;
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
