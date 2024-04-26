;Preg.4:
	org 8000h
	lcall inicioLCD; Configura el display LCD
	mov R0,#offCur
	lcall wrlcdCom4
	lcall prtLCD4
	db "SEGUNDERO:",0;imprime "SEGUNDERO" en la primera fila
	lcall print
	db "SEGUNDERO:",0DH,0AH,0
	mov A,#2
	mov B,#11
	lcall placeCur4
repite:
	mov R2,#0
	mov R4,#60
otra_vez:
	mov A,R2
	mov 40h,A
	mov A,#12
	lcall positionNTerminal
	mov A,40h
	lcall envio_dos_digitos_dec
	mov A,#0dh
	lcall sndchr
	mov A,40h
	lcall twoDigits_dec_ascii
	mov R0,30h
	lcall wrlcddata4
	mov R0,31h
	lcall wrlcddata4
	mov R0,#shLfCur
	lcall wrlcdCom4	;Envio al display una instrucción
	mov R0,#shLfCur
	lcall wrlcdCom4	;Envio al display una instrucción
	;lcall sdelay
	mov A,#100
	lcall delay
	inc R2
	djnz R4,otra_vez
	sjmp repite
$INCLUDE(subrutinas_LCD_TMC51.inc)
$INCLUDE(subrutinasDeUsoFreq.inc)
	end