; ��������� ������� 21 ������ 2014�
; �������� ��������� ������ � �������� ����������� ������� ������������
.686
include /masm32/include/io.asm


.data
	msgInputN	db '������� N: ', 0
	msgBefore 	db '��: ', 0
	msgAfter 	db '�����: ', 0
	Arr 	dd 100 dup(?)
	N 		dd ?
.code


;==== ��������� ������ ������� �� ����� ====
_outArray proc
pusha
	mov esi, 0
	mov ecx, 0
	.while ecx < N
		outint Arr[esi]
		outch ' '

		add esi, 4
		inc cx
	.endw
popa
	ret
_outArray endp
;=============================================



start:
	; ���������� random  (randomize)
	invoke GetCurrentProcessId
	invoke nseed, eax


	; ������ N
	outstr offset msgInputN
	inint N


	; ��������� ������ ������. �������
	mov esi, 0
	mov ecx, 0
	.while ecx < N
		pusha 								; ������, ��� invoke ������� ��������
		invoke nrandom, 100 				; eax = random(100)
		mov Arr[esi], eax
		popa

		add esi, 4
		inc ecx
	.endw


	; ������� ������
	newline
	outstr offset msgBefore
	newline
	call _outArray

	; ���� max
	mov	eax, Arr
	mov	ecx, 0
	mov	esi, 0

	.while ecx < N
		.if Arr[esi] > eax
			mov	eax, Arr[si]
		.endif
		add	esi, 4
		inc	ecx
	.endw


	; ���� min
	mov	ebx, Arr
	mov	ecx, 0
	mov	esi, 0

	.while ecx < N
		.if Arr[esi] < ebx
			mov	ebx, Arr[si]
		.endif
		add	esi, 4
		inc	ecx
	.endw


	;=====   min <- max   ======
	; eax = max
	; ebx = min
	mov esi, 0
	mov ecx, 0
	.while ecx < N
		.if Arr[esi] == ebx
			mov Arr[esi], eax
		.endif
		add esi, 4
		inc cx
	.endw


	; ���� ����� ������� ������
	newline
	outstr offset msgAfter
	newline
	call _outArray
	
	inint eax

exit

end start