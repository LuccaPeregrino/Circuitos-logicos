library IEEE; use IEEE.STD_LOGIC_1164.all;  

entity inverter is 
	port(a: in STD_LOGIC_VECTOR(15 downto 0); 
	y: out STD_LOGIC_VECTOR(15 downto 0));  
end;  
	architecture synth of inverter is 
begin 
	y <= not a; 
end;  
