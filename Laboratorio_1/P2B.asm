;frecuencia = 1/29Hz = 0.034s
; k x 65536 x 1.085 x 10^-6 = 0.017 --> k = 0.24
	org 0h
	lcall init
	mov TMOD,#21h ;selecciono Modo 1 de trabajo para el timer 0
	setb TR0
repite:
	mov R0,#20
	mov R2,#19
lazo:
	mov A,R2
	lcall envio_dos_digitos
	mov P1,A
	lcall delay
	dec R2
	djnz R0, lazo
	sjmp repite
delay:
	setb TR0
	mov R7,#10
loop:
	jnb TF0, $
	clr TF0
	djnz R7,loop
	ret
$INCLUDE(SubFrecuentes.inc)
	end