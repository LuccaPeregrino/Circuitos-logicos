library IEEE; use IEEE.STD_LOGIC_1164.all;

entity vua2 is
	port (p, g: in  STD_LOGIC_VECTOR(3 downto 0);
		    pg, gg: out  STD_LOGIC;
		    cin: in  STD_LOGIC;
		    c: inout STD_LOGIC_VECTOR(3 downto 0));
end;

architecture synth of vua2 is
begin
	c(0) <= g(0) or (p(0) and cin);
	c(1) <= g(1) or (p(1) and c(1));
	c(2) <= g(2) or (p(2) and c(2));
	c(3) <= g(3) or (p(3) and c(3));
	
	pg <= p(0) and p(1) and p(2) and p(3);
	gg <= g(3) or (g(2) and p(3)) or (g(1) and p(3) and p(2)) or (g(0) and p(3) and p(2) and p(1));
end;
