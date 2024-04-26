	org 0h
	lcall init
	lcall configura_LCD
	
$INCLUDE(subrutinas_LCD_Sim.inc)
$INCLUDE(subrutinasDeUsoFreq.inc)
	end