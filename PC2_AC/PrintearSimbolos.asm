;Hacer un programa que muestre nuevos caracteres como una caja en la primera fila y un
;diamante en la segunda fila.

	org 8000h

; inicializa el m¢dulo LCD --------------------------
start:
	lcall inicioLCD
	mov   A, #0     ; selecciono el caracter 0
    	mov   B, #0     ; selecciono la fila del tipo 0
    	lcall setCGRAM4
    	lcall prtLCD4
    	;db  4h, 0Eh, 1Bh, 0Ah, 0Ah, 0Ah, 1Fh, 20h
    	db    1Fh, 11h, 11h, 11h, 11h, 11h, 1Fh, 20h   ; Caja en la dirección de memoria 0
    	db    20h, 04h, 0Eh, 1Fh, 0Eh, 04h, 20h, 20h,0 ; Diamante en la dirección de memoria 1
    	;db    1Fh, 1Bh, 1Bh, 1Fh, 10h, 10h, 10h, 20h,0; La bandera del Perú de memoria 2

    	mov R0,#offCur
    	lcall wrLCDcom4
    	mov   a, #1               ; linea 2
 	mov   b, #0               ; posicion 0
  	lcall placeCur4
   	lcall prtLCD4             ; imprime mensaje
    	db  8, 0
    
    	mov   a, #2               ; linea 2
 	mov   b, #0               ; posicion 0
  	lcall placeCur4
   	lcall prtLCD4             ; imprime mensaje
    	db  1, 0
    	mov R0,#offCur
    	lcall wrLCDcom4
	ljmp 2f0h
$INCLUDE(subrutinas_LCD_TMC51.inc)
$INCLUDE(subrutinasDeUsoFreq.inc)
	end
