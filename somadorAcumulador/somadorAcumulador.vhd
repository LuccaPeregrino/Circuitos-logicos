library IEEE; use IEEE.STD_LOGIC_1164.all;  
entity somadorAcumulador is   
	port(a: in STD_LOGIC_VECTOR(15 downto 0);   	
		 sel0: in STD_LOGIC;
		 sel1: in STD_LOGIC;
	     cout: out STD_LOGIC;
         s: out STD_LOGIC_VECTOR(15 downto 0);
         clock: in STD_LOGIC);
		
	end;  

architecture struct of somadorAcumulador is   
	component somador16 is      
		port(a: in STD_LOGIC_VECTOR(15 downto 0);   
		 b: in STD_LOGIC_VECTOR(15 downto 0); 	
		 cin: in STD_LOGIC;
	     cout: out STD_LOGIC;
         s: out STD_LOGIC_VECTOR(15 downto 0);
		 pg: out STD_LOGIC;
		 gg: out STD_LOGIC);
	end component; 

    component mux2_estrutural is
		port(d0, d1: in STD_LOGIC_VECTOR(15 downto 0); 
			s: in STD_LOGIC;        
			y: out STD_LOGIC_VECTOR(15 downto 0));
	end component;
	
	component flop is
		port(d: in STD_LOGIC_VECTOR(15 downto 0);
			clock: in STD_LOGIC;
			q: out STD_LOGIC_VECTOR(15 downto 0));
	end component;
	
	component inverter is
		port(a: in STD_LOGIC_VECTOR(15 downto 0); 
			y: out STD_LOGIC_VECTOR(15 downto 0)); 
	end component;
	
	
		  
	signal a_inverter: STD_LOGIC_VECTOR(15 downto 0);
	signal signal_mux0: STD_LOGIC_VECTOR(15 downto 0);
	signal signal_mux1: STD_LOGIC_VECTOR(15 downto 0);
	signal somaodor: STD_LOGIC_VECTOR(15 downto 0);
	signal signal_somador: STD_LOGIC_VECTOR(15 downto 0);
	signal signal_acumulador: STD_LOGIC_VECTOR(15 downto 0);
	
begin   
	inversor: inverter port map(a, a_inverter);
	mux0: mux2_estrutural port map (a,a_inverter, sel0,signal_mux0);
	mux1: mux2_estrutural port map (signal_mux0, signal_somador, sel1,signal_mux1);
	somador1: somador16 port map (signal_mux0,signal_acumulador,sel0,cout,signal_somador);
	acumulador:flop port map(signal_mux1, clock, signal_acumulador);     
	s <= signal_mux1;
end;  