library IEEE; use IEEE.STD_LOGIC_1164.all;  
entity somador4 is   
	port(a: in STD_LOGIC_VECTOR(3 downto 0);   
		b: in STD_LOGIC_VECTOR(3 downto 0); 	
		cin: in STD_LOGIC;
	     --cout: out STD_LOGIC;
         s: out STD_LOGIC_VECTOR(3 downto 0);
		 pg: out STD_LOGIC;
		 gg: out STD_LOGIC);
		
	end;  

architecture struct of somador4 is   
	component fulladder is      
		port(a, b, cin: in STD_LOGIC; 
		s: out STD_LOGIC;
		p, g: inout STD_LOGIC);    
	end component; 

    component vua is
		port (p, g: in  STD_LOGIC_VECTOR(3 downto 0);
		  pg, gg: out  STD_LOGIC;
		  cin: in  STD_LOGIC;
		  c: out STD_LOGIC_VECTOR(3 downto 0));
	end component;
		  
	signal p: STD_LOGIC_VECTOR(3 downto 0);
	signal g: STD_LOGIC_VECTOR(3 downto 0);
	signal c_signal: STD_LOGIC_VECTOR(3 downto 0);
	
begin   
	vua_1: vua port map (p,g,pg,gg,cin,c_signal);

	add_1:fulladder port map(a(0), b(0), cin, s(0), p(0), g(0)); 
	add_2:fulladder port map(a(1), b(1), c_signal(0), s(1), p(1), g(1));
	add_3:fulladder port map(a(2), b(2), c_signal(1), s(2), p(2), g(2)); 
	add_4:fulladder port map(a(3), b(3), c_signal(2), s(3), p(3), g(3));     
	
	--cout <= c_signal(3);
end;  