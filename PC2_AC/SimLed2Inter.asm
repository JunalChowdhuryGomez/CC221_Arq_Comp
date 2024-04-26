;Update Freq. : 5000
;19Hz --> j=41283 -->A143
;49Hz --> j=56131 -->DB43
;99Hz --> j=60881 -->EDD1
	org 0h
	sjmp main
	org 3h
	ljmp int_ext_0
	org 13h
	ljmp int_ext_1
main:
	mov 50h,#0
	lcall configura_LCD
	mov R0,#offCur
	lcall wrLCDcom4
	setb IT0
	setb EX0
	setb P3.2
	setb IT1
	setb EX1
	setb P3.3
	setb EA
	lcall init
	mov TMOD,#21h ;Timer 0 - Modo 1 
	setb TR0
fre19:
	cpl P1.0
	lcall fila1
	lcall prtLCD4
	db "Frecuencia:     ",0
	lcall fila2
	lcall prtLCD4
	db "           19hz ",0
	mov TH0,#0A1h
	mov TL0,#043h
	jnb TF0,$
	clr TF0
	lcall check1
	sjmp fre19
fre49:
	cpl P1.0
	lcall fila2
	lcall prtLCD4
	db "           49hz ",0
	mov TH0,#0DBh
	mov TL0,#043h
	jnb TF0,$
	clr TF0
	lcall check1
	sjmp fre49
fre99:
	cpl P1.0
	lcall fila2
	lcall prtLCD4
	db "           99hz ",0
	mov TH0,#0EDh
	mov TL0,#0D1h
	jnb TF0,$
	clr TF0
	lcall check1
int_ext_0:
	mov 50h,#1
	reti
int_ext_1:
	mov 50h,#2
	reti
check1:
	mov R7,50h
	cjne R7,#0,check2
	jmp fre19
	ret
check2:
	cjne R7,#1,check3
	sjmp fre49
	ret
check3:
	sjmp fre99
	ret
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
$INCLUDE(LCDRutinas.inc)
$INCLUDE(SubFrecuentes.inc)
	end