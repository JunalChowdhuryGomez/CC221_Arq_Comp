flag_inter equ 20h
org 8000h
setb flag_inter ;
mov TMOD,#21h
lcall inicioLCD
mov R0,#offCur
lcall wrLCDcom4
lcall prtLCD4
db " Monitoreo ",0
mov A,#2
mov B,#0
lcall placeCur4
lcall prtLCD4
db " de Motores ",0
mov a, #1 ; Timer 0 es la fuente de interrupción
mov dptr, #IntTimer0 ; IntTimer0 es la dirección inicial del ISR
lcall setintvec ;Posibilita tener el ISR en RAM
setb ET0 ; habilita interrupción del timer 0
mov R6,#56;4x14 overflows(4segundos)
mov a, #2 ; fuente de interrupción externa 1
mov dptr, #inter_ext1 ; fijar dptr
 lcall setintvec
setb IT1
 setb EX1
 setb EA
 setb P3.3
 setb TR0
 jb flag_inter,$
lcall sdelay
repite:
mov R0,#onDsp
lcall wrLCDcom4
mov A,#250
lcall delay
mov A,#250
lcall delay
mov A,#250
lcall delay
mov R0,#offDsp
lcall wrLCDcom4
mov A,#250
lcall delay
mov A,#250
lcall delay
jnb Flag_inter, repite
vaSalir:
mov R0,#onDsp
lcall wrLCDcom4
clr EA
clr TR0
ljmp 2F0h; Retorna al monitor
inter_ext1:
clr ET0
setb flag_inter
reti
IntTimer0:
clr EX1
djnz R6,sale_
mov A,#1
mov B,#0
 lcall placeCur4
lcall prtLCD4
db " Falla de motor ",0
mov A,#2
mov B,#0
lcall placeCur4
lcall prtLCD4
db " #2 ",0
clr Flag_Inter
clr ET0
clr TR0
sale_:
setb EX1
reti
$INCLUDE(subrutinasDeUsoFreq.inc)
$INCLUDE(subrutinas_LCD_P1.inc)
end