;Preg.6:Hacer un programa que muestre nuevos caracteres como una caja en la primera fila y un
;diamante en la segunda fila.
;Update Freq:1000
	org 0h
; inicializa el m¢dulo LCD --------------------------
start:
	lcall configura_LCD
	mov   A, #0     ; selecciono el caracter 0
    	mov   B, #0     ; selecciono la fila del tipo 0
    	lcall setCGRAM4
    	lcall prtLCD4
    	db    1Fh, 11h, 11h, 11h, 11h, 11h, 1Fh, 20h    ; Caja en la dirección de memoria 0
    	db    20h, 04h, 0Eh, 1Fh, 0Eh, 04h, 20h, 20h ; Diamante en la dirección de memoria 1
    	db    1Fh, 1Bh, 1Bh, 1Fh, 10h, 10h, 10h, 20h; La bandera del Perú en la dirección de memoria 2
    	db    11h, 0Ah, 11h, 4h, 20h, 0Eh, 11h, 20h,0; Molesto en la dirección de memoria 3
; mueve el cursor a la linea 1
 	mov   a, #1               ; linea 1
  	mov   b, #0               ; posicion 0
    	lcall placeCur4
; imprime mensaje.  desde que 0 implica fin de la cadena,
; se usa caracter 8. Note que los caracters 0..7
; son los mismos que los caracteres 8..Fh.
	lcall prtLCD4             ; imprime mensaje
 	db    " Caja :", 8, 0
; mueve el cursor a la linea 2
	mov   a, #2               ; linea 2
 	mov   b, #0               ; posicion 0
  	lcall placeCur4
   	lcall prtLCD4             ; imprime mensaje
    	db    " Diamante :", 1, 0
    	mov R0,#offCur
    	lcall wrLCDcom4
	sjmp $
$INCLUDE(subrutinas_LCD_sim.inc)
$INCLUDE(subrutinasDeUsoFreq.inc)
	end
