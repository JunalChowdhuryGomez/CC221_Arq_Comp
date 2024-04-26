; Update Freq. : 500
; Para cambiar el tiempo en el que se cancela el viaje cambiar el numero en la linea 10
; el actual tiempo es 3 segundos aprox
	org 0h
	sjmp main
	org 3h
	ljmp inter_ext_0
	org 13h
	ljmp inter_ext_1
main:
	mov 70h,#3	;tiempo desde interrupcion hasta cancelar
	lcall init
	setb IT0
	setb EX0
	setb P3.2
	setb IT1
	setb EX1
	setb EA
	setb P3.3
	lcall configura_LCD
	mov R0,#offCur
	lcall wrLCDcom4
	mov R1,#0
	mov R6,#0	;Contador para seleccionar int0
	mov R7,70h	
	mov R5,#1
	mov R3,#9
	mov 50h,#0
loop2:
	cjne R6,#0,cont
	mov R7,70h
	mov R0,#shLfCur		;retrocedemos el cursor
	lcall wrLCDcom4
	mov A,R3
	add A,#30h
	lcall sndchr
	mov A,#20h	
	lcall sndchr
	lcall retardo_para_lab3
	dec R3
	cjne R3,#0,loop2
	sjmp last
last:
	mov A,R3
	lcall binasc
	mov A,R2
	mov R0,A
	lcall wrLCDdata4
	mov R0,#shLfCur		;retrocedemos el cursor
	lcall wrLCDcom4
	mov A,R3
	add A,#30h
	lcall sndchr
	mov A,#20h	
	lcall sndchr
	lcall retardo_para_lab3
	lcall win
	sjmp $
return:
	reti
cont:
	cjne R7,#0,dec_cont
	cjne R1,#1,lose
	reti
dec_cont:
	dec R7
	lcall retardo_para_lab3
	lcall cont
inter_ext_0:
	mov A,50h
	jnz return
	inc R6
	lcall fila1
	lcall prtLCD4
	db "No pasa el      ",0
	lcall fila2
	lcall prtLCD4
	db "combustible.    ",0
	reti
inter_ext_1:
	mov A,50h
	jnz return
	mov R1,#0
	inc R1
	lcall fila1
	lcall prtLCD4
	db "Resuelto el     ",0
	lcall fila2
	lcall prtLCD4
	db "Problema. Sigue ",0
	mov R6,#0
	lcall desactivar
	reti
lose:	
	lcall fila1
	lcall prtLCD4
	db "El lanzamiento  ",0
	lcall fila2
	lcall prtLCD4
	db "se cancela      ",0
	lcall desactivar
	sjmp $
win:
	lcall fila1
	lcall prtLCD4
	db "Ignicion        ",0
	lcall fila2
	lcall prtLCD4
	db "Despegue        ",0
	lcall desactivar
	sjmp $
fila1:
	mov A,#1	
	mov B,#0	
	lcall placeCur4	
	ret
fila2:
	mov A,#2	
	mov B,#0	
	lcall placeCur4	
	ret
desactivar:
	mov A,#0
	mov 50h,#1
	ret
$INCLUDE(LCDRutinas.inc)
$INCLUDE(SubFrecuentes.inc)
	end