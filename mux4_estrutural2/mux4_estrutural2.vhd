library IEEE; use IEEE.STD_LOGIC_1164.all;  
entity mux4_estrutural2 is   port(d0, d1,        
		      d2, d3: in STD_LOGIC_VECTOR(3 downto 0);        
		      s: in STD_LOGIC_VECTOR(1 downto 0);        
                      y: out STD_LOGIC_VECTOR(3 downto 0)); 
end;  

architecture struct of mux4_estrutural2 
is   
	component mux2_estrutural      
		port(d0,           
			 d1: in STD_LOGIC_VECTOR(3 downto 0);           
			 s: in STD_LOGIC;           
			 y: out STD_LOGIC_VECTOR(3 downto 0));    
end component;    
	signal low, high: STD_LOGIC_VECTOR(3 downto 0); 
begin    
	lowmux: mux2_estrutural port map(d0, d1, s(0), low);    
	highmux: mux2_estrutural port map(d2, d3, s(0), high);    
	finalmux: mux2_estrutural port map(low, high, s(1), y); 
end;  