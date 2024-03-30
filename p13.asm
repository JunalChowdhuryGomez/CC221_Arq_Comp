;13)Hacer un programa que encienda tres leds conectados a los 
;pines P1.0, P1.1 y P1.2 del Puerto 1.

	org 0h
	;clr P1.0	;Se enciende con un 0
	;clr P1.1	;Se enciende con un 0
	;clr P1.2	;Se enciende con un 0
	;mov P1,#11111000b
	mov P1,#0F8h
	sjmp $
	end

	

	