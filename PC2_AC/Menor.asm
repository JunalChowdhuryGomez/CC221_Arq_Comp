org 8000h
lcall inicioLCD
lcall prtLCD4
db "El menor valor :",0
mov A,#2
mov B,#8
lcall placeCur4
mov R0,#offCur
lcall wrLCDcom4
mov R5,#255
mov R6,#7
mov R2,#0
loop_:
mov A,R2
lcall obtiene_numero
mov 40h,A
subb A,R5
jc nuevo_menor
sjmp continua
nuevo_menor:
mov R5,40h
continua:
inc R2
djnz R6,loop_
mov A,R5
lcall tres_digitos_decimales
mov R0,30h
lcall wrLCDdata4
mov R0,31h
lcall wrLCDdata4
mov R0,32h
lcall wrLCDdata4
ljmp 2F0h
obtiene_numero:
inc A
movc A,@A+PC
ret
db 234, 100, 219, 159, 111, 210, 103
$INCLUDE(subrutinasDeUsoFreq.inc)
$INCLUDE(subrutinas_LCD_P1.inc)
 end
