;3)
;Update Freq: 600
	org 0h
	lcall init
	lcall configura_LCD
	lcall prtLCD4
	db "CONTADOR : ",0
	lcall print
	db "CONTADOR : ",0dh,0ah,0
	mov A,#2
	mov B,#11
	lcall placeCur4
	mov R3,#10
	mov R2,#0
loop:
	mov A,R2
	add A,#30h	;Aquí paso el número a código ASCII
	mov 40h,A
	mov R0,A
	lcall wrLCDdata4
	mov R0,#offCur	;Oculta al cursor
	lcall wrLCDcom4
	mov R0,#shLfCur	;Desplazamiento a la izq. del cursor
	lcall wrLCDcom4
;Envio al terminal
	mov A,#25
	lcall da_espacios_blanco
	mov A,40h
	lcall sndchr
	lcall crlf	;Hace un salto de línea
	lcall retardo_para_lab3	;Retardo entre cuenta y cuenta
	inc R2
	djnz R3,loop
	sjmp $
	
$INCLUDE(subrutinas_LCD_Sim.inc)
$INCLUDE(subrutinasDeUsoFreq.inc)
	end