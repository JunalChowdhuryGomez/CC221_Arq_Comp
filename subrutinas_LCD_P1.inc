LCD_DATA equ 90h ; Puerto P2
LCD_RS equ 91h ; p2.1 Register Select del LCD
LCD_RW equ 92h ; p2.2 Read/Write del LCD
LCD_E equ 93h ; p2.3 Enable del LCD
; Instrucciones para el LCD
Config equ 28h ; Function Set: Tama�o del bus de datos(4 bits), n�mero de l�neas es 2 y tama�o del font es 5x7
entryMode equ 6 ; Modo de Entrada: Incrementa el cursor, no desplaza display
; instrucciones para el control del cursor
offCur equ 0Ch ; Apaga el cursor(lo desaparece)
lineCur equ 0Eh ; Cursor aparece como una l�nea
blinkCur equ 0Dh ; Hace parpadear el cursor
combnCur equ 0Fh ; Encender el Display, encender cursor y parpadea el caracter en la posici�n del cursor
homeCur equ 02h ; Coloca el cursor en el extremo izquierdo de la primera fila
shLfCur equ 10h ; Desplaza al cursor a la izquierda
shRtCur equ 14h ; Desplaza al cursor a la derecha
; instrucciones para el control del display
clrDsp equ 01h ; Limpia el display as� como el contenido de la memoria
onDsp equ 0Eh ; Display On, muestra caracteres en el display
offDsp equ 0Ah ; Display Off, no limpia el contenido de la memoria
shLfDsp   equ  18h  ;Desplazamiento del display a la izquierda
shRtDsp   equ  1Ch  ;Desplazamiento del display a la derecha
; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
; subrutinas
; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

;subrutina inicioLCD
inicioLCD:
	lcall resetLCD4 ; power on reset
	mov A,#1
 	lcall delay
	lcall initLCD4
	mov A,#1
 	lcall delay
 	ret
; ====================================================
; subrutina resetLCD4 - reinicia el LCD
; version en software de la operaci�n power on reset
; ----------------------------------------------------
resetLCD4:
 	clr LCD_RS ; Se pone a 0 el pin RS
 	clr LCD_RW ; Se pone a 0 el pin Read / Write
 	clr LCD_E ; Se pone a 0 el pin E
 	clr P1.7 ; se fijan los bits para...
 	clr P1.6 ; ... power-on-reset
 	setb P1.5
 	setb P1.4
 	; paso 1
 	setb LCD_E ; start Enable pulse
 	clr LCD_E ; end Enable pulse
 	mov A, #4 ; retardo de 4 milisegundos
 	lcall delay
 	; paso 2
 	setb LCD_E ; start Enable pulse
 	clr LCD_E ; end Enable pulse
 	mov A, #1 ; retardo de 1 milisegundo
	lcall delay
 	; paso 3
 	setb LCD_E ; start Enable pulse
 	clr LCD_E ; end Enable pulse
 	mov A, #1 ; retardo de 1 milisegundo
 	lcall delay
 	mov R0, #Config ; FUNCTION SET
 	lcall wrLCDcom4
 	mov R0, #offDsp ; display off
 	lcall wrLCDcom4
 	mov R0, #clrDsp ; clear display, home cursor
 	lcall wrLCDcom4
 	mov R0, #entryMode ; set ENTRY MODE
 	lcall wrLCDcom4
 	ret

; ====================================================
; subrutina initLCD4 - se usa para inicializar el LCD
;
; ----------------------------------------------------
initLCD4:
 	clr LCD_RS ; Pin Register Select del LCD
 	clr LCD_RW ; Pin Read/Write del LCD
 	clr LCD_E ; Pin Enable del LCD
 	mov r0, #Config ; Function Set - data bits, lines, fonts
 	lcall wrLCDcom4
 	mov r0, #onDsp ; Enciende display
 	lcall wrLCDcom4
 	mov r0, #entryMode ; set Entry Mode
 	lcall wrLCDcom4 ; increment cursor to right, no display shift
 	mov r0, #clrDsp ; limpia display, cursor en home
 	lcall wrLCDcom4
 	ret

; ====================================================
; subrutina wrLCDdata4
; escribe una palabra de datos al LCD
; datos deben ser localizados en R0
; ----------------------------------------------------
wrLCDdata4:
 	setb LCD_RS ; selecciona envio de datos
 	clr LCD_RW ; selecciona operaci�n de escritura
 	push ACC ; salva el acumulador
 	mov A, R0 ; pone byte de datos en el acumulador
 	mov C, ACC.7 ;
 	mov P1.7, C ;
 	mov C, ACC.6 ;
 	mov P1.6, C ;
 	mov C, ACC.5 ;
 	mov P1.5, C ;
 	mov C, ACC.4 ;
 	mov P1.4, C ;hasta aqu� se envia el nibble mas significativo
	setb LCD_E ;
	clr LCD_E ;
	mov C, ACC.3 ;
	mov P1.7, C ;
	mov C, ACC.2 ;
	mov P1.6, C ;
	mov C, ACC.1 ;
	mov P1.5, C ;
	mov C, ACC.0 ;
	mov P1.4, C ;se envia el nibble menos significativo
	lcall pulseEwait4 ; pulso en el pin Enable... y espera por el Flag Busy que se aclare
	pop ACC
	ret
; ===========================================
; subrutina wrLCDcom4
; escribe una palabra comando al LCD
; el comando debe ser localizado en r0
; -------------------------------------------
wrLCDcom4:
 	clr LCD_RS ; limpia RS - y eso indica que son instrucciones a escribir
 	clr LCD_RW ; selecciona operaci�n de escritura
 	push ACC
 	mov A,R0
	mov C, ACC.7 ;
	mov P1.7, C ;
	mov C, ACC.6 ;
	mov P1.6, C ;
	mov C, ACC.5 ;
	mov P1.5, C ;
	mov C, ACC.4 ;
	mov P1.4, C ;hasta aqu� se envia el nibble mas significativo
;---------------------------------------
	setb LCD_E ;
	clr LCD_E ;
	mov C, ACC.3 ;
	mov P1.7, C ;
	mov C, ACC.2 ;
	mov P1.6, C ;
	mov C, ACC.1 ;
	mov P1.5, C ;
	mov C, ACC.0 ;
	mov P1.4, C ;se envia el nibble menos significativo
;---------------------------------------
	lcall pulseEwait4 ; pulso en el pin Enable...
	pop ACC
	ret
; ====================================================
; subrutina pulseEwait4
; genera un pulso positivo sobre el pin enable del LCD.
; espera por el Flag Busy se aclare antes de retornar.
; input : nada
; output : nada
; destroys : LCD_RW, LCD_RS, LCD_DATA
; ----------------------------------------------------
pulseEwait4:
 	clr LCD_E
 	setb LCD_E ; pulso en el pin Enable
 	clr LCD_E
 	mov LCD_DATA, #0ffh ; prepara el puerto para entrada
 	setb LCD_RW ; prepara R/W para la operaci�n de lectura
 	push ACC ; salva contenidos del acumulador
pEw:
 	setb LCD_E ; inicia el pulso Enable
 	mov A, LCD_DATA ; lee el nibble de estado
 	clr LCD_E ; termina el pulso en Enable
 	setb LCD_E ;
 	clr LCD_E
 	jb ACC.7, pEw ; se hace el lazo mientras que Flag Busy es uno
 	pop ACC ; restaura acumulador
 	ret

; ==========================================================
; subrutina prtLCD4
; toma la cadena inmediatamente que sigue a call y
; lo muestra sobre el LCD. La cadena es leida con la
; instrucci�n mov a, @a+dptr.
; de este modo, la cadena se encuentra en memoria de datos. 
; la cadena debe ser terminada con un nulo (0).
;
; input : nada
; output : nada
; destroys : acc, dptr
; ==========================================================
;
prtLCD4:
 	pop dph ; pop retorna direcci�n en el dptr
 	pop dpl
prtNext:
 	clr a ; fija offset = 0
 	movc a, @a+dptr ; get chr from code memory
 	cjne a, #0, chrOK ; if chr = 0 then return
 	sjmp retPrtLCD
chrOK:
 	mov r0, a
 	lcall wrLCDdata4 ; envia caracter
 	inc dptr ; apunta al siguiente caracter
 	ljmp prtNext ; itera hasta el fin de la cadena
retPrtLCD:
 	mov a, #1h ; apunta a la instrucci�n despu�s de la cadena
 	jmp @a+dptr ; return with a jump instruction
; ==========================================================
; subrutina placeCur4
; esta rutina fija la posici�n del cursor. La posici�n del cursor
; es localizado en el registro B. La posici�n del cursor empieza
; en 0. El acumulador da el n�mero de l�nea.
; input : el acumulador indica el n�mero de l�nea (1, 2)
; : el registro B contiene la posici�n del cursor
; output : nada
; ==========================================================
;
placeCur4:
 	dec acc ; acc=0 for line=1
 	jnz line2 ; if acc=0 then first line
 	mov a, b
 	add a, #080h ; construct control word for line 1
 	sjmp setcur
line2:
 	mov a, b
 	add a, #0C0h ; construct control word for line 2
setcur:
 	mov r0, a ; place control word
 	lcall wrLCDcom4 ; issue command
 	ret
 ; ==========================================================
; subrutina setCGRAM4
; Esta rutina fija la direccion del Character Generator RAM. El
; caracter [0..7] es localizado en el acumulador. La fila del font
; es localizado en el registro b. Las instrucciones 40h a 7Fh
; selecciona las direcciones del CGRAM 0 to 3Fh (0 to 63 decimal).
; El font de 5x7 para el caracter es asumido. Esto es, cada posici�n del
; caracter contiene una matriz de 40 puntos arreglados en 8 filas de
; 5 puntos cada uno. Las 7 filas son para los caracteres y la 8va
; fila para el cursor debajo del caracter. Direcciones de CGRAM "0" corresponde
; a la primera fila del caracter 0, direccion "7" corresponde
; al 8vo (ultima) fila del caracter 0, y direccion 3Fh
; corresponde a la 8va fila del caracter 7.
;
; entrada : acumulador indica el c�digo del caracter [0..7]
; el registro b guarda la fila del font [0..7]
; salida : nada
; ==========================================================
;
setCGRAM4:
		push b
		mov b, #8
		mul ab ; multiplica numero del caracter por 8
		pop b ; b sostiene numero de fila
		add a, b ; en a se sostiene CGRAM address
		add a, #40h ; convert to instruction
		mov r0, a ; place instruction
		acall wrLCDcom4 ; issue command
		ret
 ; ==========================================================
; subrutina dspShLf4
; Esta rutina traslada los contenidos del LCD a la izquierda. El
; numero de caracteres a ser trasladados es localizado en el
; acumulador.
; entrada  : acumulador indica el numero de caracteres a trasladar
; salida   : nada
; ==========================================================
;
dspShLf4:
         jz    ret_sdl
         mov   r0, #shLfDsp ; palabra de control para trasladar a la
                            ; izquierda
         lcall wrLCDcom4
         dec   a
         sjmp  dspShLf4
ret_sdl: ret

; ==========================================================
; subrutina dspShRt4
; Esta rutina traslada los contenidos del LCD a la derecha. El
; numero de caracteres a ser trasladados es localizado en el
; acumulador.
; entrada  : acumulador indica el numero de caracteres a trasladar
; salida   : nada
; ==========================================================
;
dspShRt4:
         jz    ret_sdr
         mov   r0, #shRtDsp ; palabra de control para trasladar a 
                            ; la derecha
         lcall wrLCDcom4
         dec   a
         sjmp  dspShRt4
ret_sdr: ret

;=================================================================
;Se usa para posicionar el cursor en el terminal. Se usa etiqueta sigue
;registros afectados: A y R3
;=================================================================	
positionNTerminal:
	mov R3,A
sigue:
	mov A,#20h
	lcall sndchr
	djnz R3,sigue
	ret