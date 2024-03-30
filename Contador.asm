		org 0h
repite:
		mov R3,#8
		mov R2,#0
lazo:
		mov A,R2
		lcall obtiene_codigo
		mov P1,A
		inc R2
		djnz R3,lazo
		sjmp repite
obtiene_codigo:
		inc A
		movc A,@A+PC
		ret
		db 1111111b,00111111b,00011111b,00001111b,00000111b,00000011b,00000001b,00000000b
		end