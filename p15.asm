;15)Hacer un programa que encienda los leds P1.0 y P1.1 en forma alternada y 
;esta acción se repita indefinidamente.

	org 0h
repite:
	clr P1.0
	setb P1.1
	lcall espera
	setb P1.0
	clr P1.1
	lcall espera
	sjmp repite
espera:
	mov R7,#2
	djnz R7,$
	ret
	end