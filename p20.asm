;Usando un switch para arrancar la cuenta.
;Hacer un programa de un contador creciente (de 0 a 9) que se muestre 
;en el display de 7 segmentos. Y que se repita en forma indefinida.

	org 0h
espera:
	jnb P2.2,arranca
	sjmp espera
arranca:
	mov R7,#10
	mov R2,#0
lazo:
	mov A,R2
	lcall display
	mov P1,A
	inc R2
	djnz R7,lazo
	sjmp espera
display:
	inc a ;incremento el valor de A
	movc a,@a+pc ;muevo a A el valor del contenido de la dirección de memoria (pc+a)
	ret ;Retorno de la subrutina al programa principal
	db 0C0h ;1100 0000(punto g f e d c b a) Con este código se muestra "0" en el display
	db 0F9h ;1111 1001 Con este código se muestra "1" en el display
	db 0A4h ;"2"
	db 0B0h ;"3"
	db 99h ;"4"
	db 92h ;"5"
	db 82h ;"6"
	db 0F8h ;"7"
	db 80h ;"8"
	db 90h ;"9"
	db 88h ; a
	db 83h ; b
	db 0c6h ; c
	db 0a1h ; d
	db 86h ; e
	db 8eh ; f

	end