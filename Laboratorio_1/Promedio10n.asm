org 0
lcall init
mov R3,#10
mov R2,#0
mov R4,#0

lazo:
mov A,R2
lcall obtiene_numero
add A,R4
mov R4,A
inc R2
djnz R3,lazo
mov A,R4
mov B,#10
div AB
mov 40h,A
lcall print
db "El promedio es : ",0
mov A,40h
lcall envio_dos_digitos_dec
lcall crlf
sjmp $

obtiene_numero:
inc A
movc A,@A+PC
ret
db 8,6,2,5,18,17,5,13,16,10

$INCLUDE(subrutinasDeUsoFreq.inc)
end
