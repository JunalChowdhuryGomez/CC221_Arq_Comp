;Hacer un programa que muestre:
;MODULO

;ENTRENADOR TMC51
;Y que parpadee.
;Update Freq.:1000

	org 0h
	lcall init
	lcall configura_LCD
	mov A,#1
	mov B,#3
	lcall placeCur4
	lcall prtLCD4
	db "   MODULO   ",0
	mov A,#2
	mov B,#0
	lcall placeCur4
	lcall prtLCD4
	db "ENTRENADOR TMC51",0
	lcall retardo2
repite:
	mov R0,#offDsp
	lcall wrLCDcom4
	lcall retardo2
	mov R0,#onDsp
	lcall wrLCDcom4
	lcall retardo2
	sjmp repite
		
$INCLUDE(subrutinas_LCD_Sim.inc)
$INCLUDE(subrutinasDeUsoFreq.inc)
	end