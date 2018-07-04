library IEEE; use IEEE.STD_LOGIC_1164.all; 
entity fulladder is 
	port(a, b, cin: in STD_LOGIC; 
	s: out STD_LOGIC;
	p, g: inout STD_LOGIC); 
end; 

architecture synth of fulladder is 
	
begin 
   p <= a xor b; 
   g <= a and b; 
   s <= p xor cin; 
   --cout <= g or (p and cin); 
end;