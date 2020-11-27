.586P
.model flat, stdcall
includelib kernel32.lib
includelib user32.lib

ExitProcess PROTO: DWORD									; прототип функции дл€ завершени€ процесса Windows 

.STACK 4096													; выделение стека объЄмом 4 мегабайта	
.CONST
.DATA
	myarray sdword 12, 16, 54, -3, 8, 79, 4, 2, -10, 6			; массив заполненый 10-ю значени€ми
	min sdword ?

.CODE
getmin PROC array : sdword, arraysize : dword					; объ€вление функции с параметрами
	mov ESI, array		
	mov EAX, [ESI]
	dec arraysize
	mov ECX, arraysize								

	MINLOOP:
		add ESI, 4
		cmp [ESI], EAX
		jg MORE			
		mov EAX, [ESI]

		MORE:
	loop MINLOOP

	ret														;возврат результат в регистре eax
getmin ENDP													

main PROC		
	invoke getmin, offset myarray, lengthof myarray
	mov min, eax											

	push -1													
	call ExitProcess										
main ENDP													
end main						