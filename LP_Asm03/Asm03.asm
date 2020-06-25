.586P
.model flat, stdcall
includelib kernel32.lib
includelib user32.lib

ExitProcess PROTO : DWORD
MessageBoxA PROTO : DWORD, : DWORD, : DWORD, : DWORD

.stack 4096

.const

.DATA
myBytes		BYTE	10h, 20h, 30h, 40h
myArray		DWORD	1h, 16h, 3h, 0h, 5h, 6h, 0Ch
windowName	byte	"Зинович Елизавета Игоревна, 1 курс, 4 группа", 0			
result		byte	"Результат: ", "0"
.CODE

main PROC

	mov		esi, offset myBytes
	mov		ah, [esi]
	mov     al, [esi+2]					
	
ARRAYSUM: 
		mov		esi, offset myArray
		mov		ecx, 7
		mov		eax, 0
	CYCLESUM:	
		add		eax, [esi]
		add		esi, 4
	loop CYCLESUM

ARRAYZERO:
		mov		esi, offset myArray
		mov		ecx, 7
		mov		ebx, 1
	CYCLEZERO:	
		mov		eax, [esi]
		cmp		eax, 0
		je		zero		
		add		esi, 4
	loop CYCLEZERO

		jmp nozero
	zero: 
		mov ebx, 0
	nozero:

		mov		eax, ebx
		add     eax, '0'					
		mov		ebx, offset result
		mov		[ebx+11], eax

			invoke MessageBoxA, 0, OFFSET result, OFFSET windowName, 0

		push - 1
		call ExitProcess
main ENDP
end main