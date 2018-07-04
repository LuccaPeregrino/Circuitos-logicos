library IEEE; use IEEE.STD_LOGIC_1164.all;  
entity mux2_estrutural is   
	port(d0, d1: in STD_LOGIC_VECTOR(3 downto 0); 
	s: in STD_LOGIC;        
	y: out STD_LOGIC_VECTOR(3 downto 0)); 
end;  

architecture struct of mux2 is   
	component tristate      
		port(a: in STD_LOGIC_VECTOR(3 downto 0);           
			en: in STD_LOGIC;           
			y: out STD_LOGIC_VECTOR(3 downto 0));   
	end component;

	component inverter      
		port(a: in STD_LOGIC;                     
			y: out STD_LOGIC_);   
	end component;
	
	signal sbar: STD_LOGIC; 
begin   
	sbar: inverter port map(s, notS);  
	t0: tristate port map(d0, sbar, y);   
	t1: tristate port map(d1, s, y); 
end;