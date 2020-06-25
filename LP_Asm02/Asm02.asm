.586P
.model flat, stdcall
includelib kernel32.lib


ExitProcess PROTO : DWORD
MessageBoxA PROTO : DWORD, : DWORD, : DWORD, : DWORD

.STACK 4096

.CONST

.DATA
STR1	byte	"Ответ", 0			
STR2	byte	"Результат сложения = ", "0"

.CODE

main PROC

	mov		eax, 3h
	add		eax, 4h
	add     eax, '0'					
	mov		ebx, offset str2
	mov		[ebx+21], eax		
	
		invoke MessageBoxA, 0, OFFSET STR2, OFFSET STR1, 0

	push - 1
	call ExitProcess
main ENDP

end main