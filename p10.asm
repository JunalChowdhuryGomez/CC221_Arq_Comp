;10)Encontrar el resultado (X * Y). Donde X=15 e Y=20 son almacenados en las posiciones
;de memoria 40h y 41h. Hacer un programa que encuentre el valor del producto de ambos 
;números. Guardando el resultado en las posiciones 42h (el byte más significativo) y 
;en 43h (el byte menos significativo).

	org 0h
	mov 40h,#15
	mov 41h,#20
	mov A,40h
	mov B,41h
	mul AB	; BA<--A x B
	mov 42h,B
	mov 43h,A
	sjmp $
	end