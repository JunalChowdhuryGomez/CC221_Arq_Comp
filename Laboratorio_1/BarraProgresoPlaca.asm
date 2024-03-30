org 8000h
reinicia:
jnb P3.2,inicia
lcall chkbrk ;Retorna al monitor
sjmp reinicia
inicia:
lcall print
db 0dh,0ah,"Barra de Progreso",0
mov P1,#0h
mov R4,#4
mov R2,#0
lazo:
mov A,R2
lcall obtiene_binario
cpl A
mov P1,A
;mov A,#200
;lcall delay
mov A,#100
lcall delay
inc R2
djnz R4,lazo
sjmp reinicia
obtiene_binario:
inc A
movc A,@A+PC
ret
db 11111110b,11111100b,11111000b,11110000b
ret
$INCLUDE(subrutinasDeUsoFreq.inc)
end