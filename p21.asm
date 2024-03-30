
;21)Hacer un programa que al presionar un botón (conectado a P3.2) empiece un 
;contador decreciente (de 9 a 0) que se muestre en el display de 7 segmentos. 
;Que se repita en forma indefinida hasta que se vuelva a presionar el botón (conectado a P3.3) que detiene la cuenta.
	org 0h
espera:
	jnb P3.2,start_count
	sjmp espera
start_count:
	lcall cuenta_regresiva
	jnb P3.3,stop_count
	sjmp start_count
stop_count:
	sjmp espera
cuenta_regresiva:
	mov R7,#10
	mov R2,#9
lazo:
	mov A,R2
	lcall display
	jnb P3.3,salir2
	mov P1,A
	dec R2
	djnz R7,lazo
salir2:
	ret	
display:
	jnb P3.3,salir
	inc a ;incremento el valor de A
	movc a,@a+pc ;muevo a A el valor del contenido de la dirección de memoria (pc+a)
salir:
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
	end