library IEEE; use IEEE.STD_LOGIC_1164.all;  

entity inverter2 is 
	port(a: in STD_LOGIC; 
	y: out STD_LOGIC);  
end;  
	architecture synth of inverter2 is 
begin 
	y <= not a; 
end;  
