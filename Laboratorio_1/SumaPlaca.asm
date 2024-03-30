org 8000h
;lcall init
lcall print
db 0dh,0ah,"El resultado de la suma es :",0
mov R3,#0 ;Obtiene el total de la suma
mov R0,#10 ;Cantidad de elementos a sumar
mov R2,#0 ;Hace las veces de "i"
otra_vez:
mov A,R2
lcall obtiene_numero
add A,R3
mov R3,A ;Se guarda el total en R3
inc R2
djnz R0,otra_vez
mov A,R3
lcall envio_dos_digitos
lcall crlf
ljmp 2F0h ;Retorno al monitor
obtiene_numero:
inc A
movc A,@A+PC
ret
db 1,9,2,6,8,7,5,13,12,10
$INCLUDE(subrutinasDeUsoFreq.inc)
end
