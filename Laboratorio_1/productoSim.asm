;Update Freq.: 600
org 0h
lcall init
lcall print
db "El resultado de la ",0dh,0ah
db "multiplicacion es :",0
mov R3,#6 ;Cantidad de elementos en el listado
mov R4,#1 ;Contendrá el producto total del listado
mov R2,#0 ;
otra_vez:
mov A,R2
lcall obtener_numero
mov B,R4
mul AB
mov R4,A
inc R2
djnz R3,otra_vez
mov A,R4
lcall envio_tres_digitos ;Se envia al terminal en decimal
sjmp $
obtener_numero:
inc A
movc A,@A+PC
ret
db 2,3,2,4,2,2
$INCLUDE(subrutinasDeUsoFreq.inc)
end