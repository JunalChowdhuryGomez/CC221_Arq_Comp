;update Freq.:800
org 0h
lcall init
lcall print
db 0dh,0ah,"Parpadeo de 4 Leds",0
espera:
jnb P3.2,hace_parpa30
jnb P3.3,hace_parpa120
sjmp espera
hace_parpa30:
lcall print
db 0dh,0ah,"Parpadeo a 30ms",0
hace_parpa30_:
lcall parpadeo30m
jnb P3.3,hace_parpa120
sjmp hace_parpa30_
hace_parpa120:
lcall print
db 0dh,0ah,"Parpadeo a 120ms",0
hace_parpa120_:
lcall parpadeo120m
jnb P3.2,hace_parpa30
sjmp hace_parpa120_
parpadeo30m:
mov P1,#0FFh
mov A,#2 ;Debió ser 30 pero el simulador es lento frente a la placa
lcall delay
mov P1,#0F0h
jnb P3.3,sale
mov A,#2
lcall delay
sale:
ret
parpadeo120m:
mov P1,#0FFh
mov A,#8 ;Debió ser 120 pero el simulador es lento frente a la placa
lcall delay
mov P1,#0F0h
jnb P3.2,sale1
mov A,#8
lcall delay
sale1:
ret
$INCLUDE(subrutinasDeUsoFreq.inc)
end