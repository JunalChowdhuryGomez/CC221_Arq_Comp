;Update Freq. 500
;Si algun boton no funciona presionar hasta que lo haga, el simulador no lo detecta siempre
	org 0h
	sjmp main
	org 3h
	ljmp inter_ext_0
	org 13h
	ljmp inter_ext_1
main:
	mov R7, #0	; saber si va a derecha o izquierda
	lcall init
	lcall configura_LCD
	setb IT0
	setb EX0
	setb P3.2
	setb IT1
	setb EX1
	setb P3.3
	setb EA
	lcall prtLCD4
	db "Querer es poder",0
	mov A,#2	
	mov B,#0
	lcall placeCur4
	lcall prtLCD4	
	db "Piensa en grande",0
	mov R0,#offCur
	lcall wrLCDcom4
	mov R7,#40
	sjmp $
inter_ext_0:
	mov R5,#0
	mov R0, #onDsp
	jnb P3.3, inter_ext_1
	lcall wrLCDcom4
	mov R0,#shLfDsp
	lcall wrLCDcom4
	lcall retardo
	lcall retardo
	djnz R7, inter_ext_0
	jnb P3.3, inter_ext_1
	lcall retardo2
	lcall retardo2
	lcall retardo2
	lcall retardo2
	mov R7,#40
	jnb P3.3, inter_ext_1
	sjmp inter_ext_01
	reti
inter_ext_01:
	mov R5,#1
	jnb P3.3, inter_ext_1
	mov R0,#shRtDsp
	lcall wrLCDcom4
	lcall retardo
	lcall retardo
	djnz R7, inter_ext_01
	jnb P3.3, inter_ext_1
	lcall retardo2
	lcall retardo2
	lcall retardo2
	lcall retardo2
	mov R7,#40
	jnb P3.3, inter_ext_1
	sjmp inter_ext_0
	reti
inter_ext_1:
	jnb P3.2, checkDerIzq
	jnb P3.2, checkDerIzq
	mov R0, #offDsp
	jnb P3.2, checkDerIzq
	jnb P3.2, checkDerIzq
	lcall wrLCDcom4
	jnb P3.2, checkDerIzq
	jnb P3.2, checkDerIzq
	lcall retardo2
	jnb P3.2, checkDerIzq
	jnb P3.2, checkDerIzq
	mov R0, #onDsp
	jnb P3.2, checkDerIzq
	jnb P3.2, checkDerIzq
	lcall wrLCDcom4
	jnb P3.2, checkDerIzq
	jnb P3.2, checkDerIzq
	lcall retardo2
	jnb P3.2, checkDerIzq
	jnb P3.2, checkDerIzq
	sjmp inter_ext_1
	reti
checkDerIzq:
	cjne R5,#0, inter_ext_01
	jmp inter_ext_0
	sjmp $
$INCLUDE(LCDRutinas.inc)
$INCLUDE(SubFrecuentes.inc)
	end