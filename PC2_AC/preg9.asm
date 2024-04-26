;MODULO
;ENTRENADOR TMC51
	org 0h
	lcall configura_LCD
	lcall prtLCD4
	db "MODULO          ",0
	mov A,#2
	mov B,#0
	lcall placeCur4
	lcall prtLCD4
	db "ENTRENADOR TMC51",0
repite:
	mov R7,#4
varios:
	mov R0,#offDSP
	lcall wrLCDcom4
	lcall retardo2
	lcall retardo2
	lcall retardo2
	lcall retardo2
	mov R0,#onDSP
	lcall wrLCDcom4
	lcall retardo2
	lcall retardo2
	lcall retardo2
	lcall retardo2
	mov R0,#offCur
	lcall wrLCDcom4
	djnz R7,varios
	mov R7,#16
llamo1:
	mov R0,#shLfDsp
	lcall wrLCDcom4
	lcall retardo2
	lcall retardo2
	djnz R7,llamo1
	mov R7,#16
llamo2:
	mov R0,#shRtDsp
	lcall wrLCDcom4
	lcall retardo2
	lcall retardo2
	djnz R7,llamo2
	sjmp repite
$INCLUDE(subrutinas_LCD_Sim.inc)
$INCLUDE(subrutinasDeUsoFreq.inc)
	end