.586P
.model flat, stdcall
includelib kernel32.lib
includelib user32.lib

ExitProcess PROTO: DWORD
SetConsoleTitleA PROTO: DWORD								; заголовок консольного окна
WriteConsoleA PROTO: DWORD, : DWORD, : DWORD, : DWORD, : DWORD
GetStdHandle PROTO: DWORD									; получить handle вывода на консоль 

includelib ..\Debug\LP_asm01a.lib
getmin PROTO :sdword, :dword
getmax PROTO :sdword, :dword

.STACK 4096													; выделение стека объёмом 4 мегабайта	
.CONST
	consoletitle byte 'LP_asm01b', 0	
	text byte 'getmax-getmin =', 0
	handleoutput sdword -11
	myarray sdword 79, 4, 38, -910, 6, -12, 16, -54, 3, 8			; массив заполненый 10-ю значениями
.DATA
	consolehandle dword 0h									; состояние консоли
	resultstring byte 40 dup(0)
	result sdword ?
.CODE

inttochar PROC uses eax ebx ecx edi esi,
				pstr: dword,			; адрес строки для результата
                intfield: sdword		; преобразуемое числa
	mov edi, pstr					;копирует из pstr в edi
	mov esi, 0						;количество символов в результате
	mov eax, intfield				; число -> в eax
	cdq								; знак числа распространяется с eax на edx
	mov ebx, 10						;основание системы счисления (10) - > ebx
	idiv ebx						;eax = eax/ebx, остаток в edx(деление целых со знаком)
	test eax, 80000000h				;тестируем знаковый бит
	jz plus							;если положительное число - на плюс
	neg eax							;иначе меняем знак на eax
	neg edx
	mov cl, '-'
	mov [edi], cl					;первый символ результата - минус
	inc edi
 plus :								;цикл разложения по степеням 10
	 push dx						;остаток в стек
	 inc esi
	 test eax, eax					;eax ==?
	 jz fin							;если да, то на fin
	 cdq							;знак распространяется с eax на edx
	 idiv ebx						;eax= eax/ebx, остаток в edx
	 jmp plus						;безусловный переход на плюс

 fin:
	mov ecx, esi					;в ecx количество не 0-вых остатокв = количеству символов результата
 write:								;цикл записи результата
	 pop bx							;остаток из стека в bx
	 add bl, '0'					;сформировали символ в bl
	 mov [edi], bl					;bl в результат
	 inc edi						
	 loop write						;если (--ecx)>0 переход на write
	 ret							
inttochar ENDP


main PROC	
	invoke getmax, offset myarray, lengthof myarray								
    mov result, eax
	invoke getmin, offset myarray, lengthof myarray									
    sub result, eax											

	invoke inttochar, offset resultstring, result

	invoke SetConsoleTitleA, offset consoletitle
	invoke GetStdHandle, handleoutput
	mov consolehandle, eax
	invoke WriteConsoleA, consolehandle, offset text, sizeof text, 0, 0
	invoke WriteConsoleA, consolehandle, offset resultstring, sizeof resultstring, 0, 0

	push -1													
	call ExitProcess										
main ENDP													
end main						