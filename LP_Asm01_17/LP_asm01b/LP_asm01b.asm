.586P
.model flat, stdcall
includelib kernel32.lib
includelib user32.lib

ExitProcess PROTO: DWORD
SetConsoleTitleA PROTO: DWORD								; ��������� ����������� ����
WriteConsoleA PROTO: DWORD, : DWORD, : DWORD, : DWORD, : DWORD
GetStdHandle PROTO: DWORD									; �������� handle ������ �� ������� 

includelib ..\Debug\LP_asm01a.lib
getmin PROTO :sdword, :dword
getmax PROTO :sdword, :dword

.STACK 4096													; ��������� ����� ������� 4 ���������	
.CONST
	consoletitle byte 'LP_asm01b', 0	
	text byte 'getmax-getmin =', 0
	handleoutput sdword -11
	myarray sdword 79, 4, 38, -910, 6, -12, 16, -54, 3, 8			; ������ ���������� 10-� ����������
.DATA
	consolehandle dword 0h									; ��������� �������
	resultstring byte 40 dup(0)
	result sdword ?
.CODE

inttochar PROC uses eax ebx ecx edi esi,
				pstr: dword,			; ����� ������ ��� ����������
                intfield: sdword		; ������������� ����a
	mov edi, pstr					;�������� �� pstr � edi
	mov esi, 0						;���������� �������� � ����������
	mov eax, intfield				; ����� -> � eax
	cdq								; ���� ����� ���������������� � eax �� edx
	mov ebx, 10						;��������� ������� ��������� (10) - > ebx
	idiv ebx						;eax = eax/ebx, ������� � edx(������� ����� �� ������)
	test eax, 80000000h				;��������� �������� ���
	jz plus							;���� ������������� ����� - �� ����
	neg eax							;����� ������ ���� �� eax
	neg edx
	mov cl, '-'
	mov [edi], cl					;������ ������ ���������� - �����
	inc edi
 plus :								;���� ���������� �� �������� 10
	 push dx						;������� � ����
	 inc esi
	 test eax, eax					;eax ==?
	 jz fin							;���� ��, �� �� fin
	 cdq							;���� ���������������� � eax �� edx
	 idiv ebx						;eax= eax/ebx, ������� � edx
	 jmp plus						;����������� ������� �� ����

 fin:
	mov ecx, esi					;� ecx ���������� �� 0-��� �������� = ���������� �������� ����������
 write:								;���� ������ ����������
	 pop bx							;������� �� ����� � bx
	 add bl, '0'					;������������ ������ � bl
	 mov [edi], bl					;bl � ���������
	 inc edi						
	 loop write						;���� (--ecx)>0 ������� �� write
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