	org 0h
	lcall init
	lcall print
	db "Los primos encontrados en el listado son : ",0
	mov R0,#0 ;contador
	mov R1,#12 ;12 numeros
siguienteNumero:
	mov R2,#2
	mov A,R0
	lcall numero
	mov 30h,A
check:
	subb A,R2
	jnz continua
	jz esPrimo
continua:
	mov A,30h
	mov B,R2
	div AB
	mov A,B
	jz noEsPrimo
	inc R2
	mov A,30h
	sjmp check
esPrimo:
	mov A,30h
	lcall envio_dos_digitos
noEsPrimo:
	inc R0
	djnz R1,siguienteNumero
	sjmp $
numero:
	inc A
	movc A,@A+PC
	ret
	db 3,24,25,7,5,71,61,90,13,23,11,88
	$INCLUDE(SubFrecuentes.inc)
	end