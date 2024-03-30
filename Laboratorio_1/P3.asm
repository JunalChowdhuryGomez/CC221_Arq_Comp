;Update Freq : 5000	
	org 0h
	lcall init
	lcall print
	db "Serie de impares desde 21 hasta 39 : ",0dh,0ah,0
	mov R0,#0 ;contador
	mov R1,#19 ;19 numeros
siguienteNumero:
	mov B,#2
	mov A,R0
	lcall numero
	mov 30h,A
check:
	div AB
	mov A,B
	jz continua
	jnz esImpar
esImpar:
	mov A,30h
	lcall envio_dos_digitos
noEsImpar:
	inc R0
	djnz R1,siguienteNumero
	sjmp $
continua:
	mov A,30h
	mov B,R2
	div AB
	mov A,B
	jz noEsImpar
	inc R2
	mov A,30h
	sjmp check
numero:
	inc A
	movc A,@A+PC
	ret
	db 21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39
	$INCLUDE(SubFrecuentes.inc)
	end