;18)Hacer un programa que parpadee un led conectado a P1.0 en caso se presiona el 
;botón conectado a P3.2. Si se presiona el otro botón P3.3 se detiene el parpadeo.

	org 0h
espera:
	jnb P3.2,start_blink
	sjmp espera
start_blink:
	lcall parpadeo
	jnb P3.3,stop_blink
	sjmp start_blink
stop_blink:
	setb P1.0
	sjmp espera
parpadeo:
	jnb P3.3,sale
	setb P1.0
	clr P1.0
sale:
	ret
	end
	