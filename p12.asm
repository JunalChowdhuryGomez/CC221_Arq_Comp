;12)Encontrar el resultado (X/Y). Donde X=30 e Y=7 son almacenados en las posiciones de 
;memoria 30h y 31h. Hacer un programa que encuentre el valor de la división de ambos números. 
;Guardando el resultado en la posición 32h(resto) y 33h(cociente).

	org 0h
	mov 30h,#30
	mov 31h,#7
	mov A,30h
	mov B,31h
	div AB	;   A<--A/B y el resto en B
	mov 33h,A
	mov 32h,B
	sjmp $
	end