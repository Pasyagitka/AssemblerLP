.586P
.model flat, stdcall
includelib kernel32.lib
includelib user32.lib

ExitProcess PROTO: DWORD									; �������� ������� ��� ���������� �������� Windows 

.STACK 4096													; ��������� ����� ������� 4 ���������	
.CONST
.DATA
	myarray sdword 12, 16, 54, -3, 8, 79, 4, 2, -10, 6			; ������ ���������� 10-� ����������
	min sdword ?

.CODE
getmin PROC array : sdword, arraysize : dword					; ���������� ������� � �����������
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

	ret														;������� ��������� � �������� eax
getmin ENDP													

main PROC		
	invoke getmin, offset myarray, lengthof myarray
	mov min, eax											

	push -1													
	call ExitProcess										
main ENDP													
end main						