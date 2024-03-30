;frecuencia = 1/37Hz = 0.027s
;k x 65536 x 1.085 x 10^-6 = 0.0135 --> k = 0.189 --> k = 0.19
;(65536 - j ) x 1.085 x 10^-6 = 0.0135 --> j = 53093.6 --> j = 53094 --> j = CF66h
;CF00 = 52992 - 66 = 102
	org 0h
	lcall init
	mov TMOD,#21h ;Timer 0 - Modo 1 
	setb TR0
	lcall print
	db "Frecuencia de 37Hz.",0dh,0ah,0
	mov A,#0h
	mov 40h,#0h
main:
	jnb P2.2,send
	sjmp main
send:
	mov TH0,#0CFh
	mov TL0,#66h
	jnb TF0,$
	clr TF0
	lcall envio_dos_digitos
	sjmp changeA
changeA:
	mov A,40h
	add A,#1
	mov 40h,A
	cjne A,#22,send; si A es diferente de 22 entonces manda a imprimirlo de lo contrario queda en $
	sjmp $
$INCLUDE(SubFrecuentes.inc)
	end