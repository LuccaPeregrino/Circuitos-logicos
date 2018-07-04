library IEEE; use IEEE.STD_LOGIC_1164.all;  
entity somador16 is   
	port(a: in STD_LOGIC_VECTOR(15 downto 0);   
		 b: in STD_LOGIC_VECTOR(15 downto 0); 	
		 cin: in STD_LOGIC;
	     cout: out STD_LOGIC;
         s: out STD_LOGIC_VECTOR(15 downto 0);
		 pg: out STD_LOGIC;
		 gg: out STD_LOGIC);
		
	end;  

architecture struct of somador16 is   
	component somador4 is      
		port(a: in STD_LOGIC_VECTOR(3 downto 0);   
			 b: in STD_LOGIC_VECTOR(3 downto 0); 	
			 cin: in STD_LOGIC;
			 --cout: out STD_LOGIC;
			 s: out STD_LOGIC_VECTOR(3 downto 0);
			 pg: out STD_LOGIC;
			 gg: out STD_LOGIC);
		
	end component; 

    component vua is
		port (p, g: in  STD_LOGIC_VECTOR(3 downto 0);
			  pg, gg: out  STD_LOGIC;
			  cin: in  STD_LOGIC;
			  c: inout STD_LOGIC_VECTOR(3 downto 0));
	end component;
		  
	signal p: STD_LOGIC_VECTOR(3 downto 0);
	signal g: STD_LOGIC_VECTOR(3 downto 0);
	signal c_signal: STD_LOGIC_VECTOR(3 downto 0);
	signal coutt: STD_LOGIC_VECTOR(15 downto 0);
	
begin   
	vua_1: vua port map (p,g,pg,gg,cin,c_signal);

	add4_1:somador4 port map(a(3 downto 0), b(3 downto 0), cin, s(3 downto 0), p(0), g(0)); 
	add4_2:somador4 port map(a(7 downto 4), b(7 downto 4), c_signal(0), s(7 downto 4), p(1), g(1));
	add4_3:somador4 port map(a(11 downto 8), b(11 downto 8), c_signal(1), s(11 downto 8), p(2), g(2)); 
	add4_4:somador4 port map(a(15 downto 12), b(15 downto 12), c_signal(2), s(15 downto 12), p(3), g(3));     
	
	cout <= c_signal(3);
end;  