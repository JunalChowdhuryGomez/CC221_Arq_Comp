;Valor calculado en modo1 14335.999999999985=14336-->3800h para generar 9hz
;Valor calculado en modo1 48469.33333333333=48469-->BD55h para generar 27hz
org 8000h
mov TMOD,#21h
lcall print
db 0dh,0ah,"Seleccione la frecuencia con los botones",0
espera_seleccion:
jnb P3.2,frec1
jnb P3.3,frec2
sjmp espera_seleccion
frec1:
lcall print
db 0dh,0ah,"La Frecuencia del led es: ",0
mov A,#9
add A,#30h
lcall sndchr
sigue_frec9hz:
lcall frec9hz
jnb P3.3,frec2
lcall chkbrk ;retorna al monitor con Ctrl+C
sjmp sigue_frec9hz
frec2:
lcall print
db 0dh,0ah,"La Frecuencia del led es:",0
mov A,#27
lcall envio_dos_digitos
sigue_frec27hz:
lcall frec27hz
jnb P3.2,frec1
lcall chkbrk
sjmp sigue_frec27hz
frec9hz:
jnb P3.3,sale
mov TH0,#38h
mov TL0,#0
setb TR0
jnb TF0,$
cpl P1.0
clr TF0
sale:
ret
frec27hz:
jnb P3.2,sale1
mov TH0,#0BDh
mov TL0,#55h
setb TR0
jnb TF0,$
cpl p1.0
clr TF0
sale1:
ret
$INCLUDE(su