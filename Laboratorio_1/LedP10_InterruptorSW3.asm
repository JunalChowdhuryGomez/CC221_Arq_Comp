;Update Freq.:1000
org 0
lcall init
mov TMOD,#22h

espera:
jnb P2.3,frecuencia37hz
jnb P2.4,frecuencia57hz
sjmp espera

frecuencia37hz:
lcall print
db "Frecuencia de 37hz",0dh,0ah,0
mov TH0,#0
setb TR0

repite:
mov R7,#49
loop:
jnb TF0,$
clr TF0
jnb P2.4,frecuencia57hz
djnz R7,loop
cpl P1.0
sjmp repite

frecuencia57hz:
lcall print
db "Frecuencia de 57hz",0dh,0ah,0
mov TH0,#0
setb TR0
repite_:
mov R7,#32

loop_:
jnb TF0,$
clr TF0
jnb P2.3,frecuencia37hz
djnz R7,loop_
cpl P1.0
sjmp repite_

$INCLUDE(subrutinasDeUsoFreq.inc)
end
