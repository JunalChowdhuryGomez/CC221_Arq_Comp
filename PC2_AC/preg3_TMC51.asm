;Preg.3:
	org 8000h
	lcall inicioLCD; Configura el display LCD
	mov R0,#offCur
	lcall wrlcdCom4
	lcall prtLCD4
	db "CONTADOR:",0;imprime "CONTADOR" en la primera fila
	lcall print
	db "CONTADOR:",0DH,0AH,0
	mov A,#2
	mov B,#11
	lcall placeCur4
repite:
	mov R2,#0
	mov R4,#10
otra_vez:
	mov A,R2
	mov 40h,A
	mov A,#12
	lcall positionNTerminal
	mov A,40h
	;lcall envio_dos_digitos_dec
	add A,#30h
	lcall sndchr
	mov A,#0dh
	lcall sndchr
	mov A,40h
	add A,#30h	;Convierte a código ASCII
	mov R0,A
	lcall wrlcdData4	;Envia el dato como código ASCII al display LCD.
	mov R0,#shLfCur
	lcall wrlcdCom4	;Envio al display una instrucción
	lcall sdelay
	inc R2
	djnz R4,otra_vez
	sjmp repite
$INCLUDE(subrutinas_LCD_TMC51.inc)
$INCLUDE(subrutinasDeUsoFreq.inc)
	end