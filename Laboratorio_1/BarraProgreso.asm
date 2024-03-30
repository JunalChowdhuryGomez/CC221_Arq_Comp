;Update Freq.:700
org 0
lcall init
mov TMOD,#21h

espera:
jnb P2.3,start
sjmp espera

start:
lcall print
db "Esperar, por favor",0dh,0ah,0
lcall barra_de_progreso
lcall print
db "Puede retirar su cafe",0dh,0ah,0
sjmp $

barra_de_progreso:
clr P1.7
lcall delay_100ms
clr P1.6
lcall delay_100ms
clr P1.5
lcall delay_100ms
clr P1.4
lcall delay_100ms
clr P1.3
lcall delay_100ms
clr P1.2
lcall delay_100ms
clr P1.1
lcall delay_100ms
clr P1.0
lcall delay_100ms
ret

delay_100ms:
mov TH0,#0A6h
mov TL0,#0
setb TR0
jnb TF0,$
clr TF0
ret
$INCLUDE(subrutinasDeUsoFreq.inc)
end