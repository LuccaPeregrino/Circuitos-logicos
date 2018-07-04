library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use STD.TEXTIO.ALL ;

entity testbench_adder is -- no inputs or outputs
end;
architecture sim of testbench_adder is
	component adder
		port(a, b: in STD_LOGIC_VECTOR(15 downto 0);
			cin: in STD_LOGIC;
			cout: out STD_LOGIC;
			s: out STD_LOGIC_VECTOR(15 downto 0));
	end component;
signal clk: STD_LOGIC;
signal a, b: STD_LOGIC_VECTOR(15 downto 0);
signal cin: STD_LOGIC;
signal cout:   STD_LOGIC;
signal s:      STD_LOGIC_VECTOR(15 downto 0);
signal sexpected: STD_LOGIC_Vector(15 downto 0);
signal coutexpected: STD_LOGIC;
constant MEMSIZE: integer := 8; --
type tvarray is array (MEMSIZE downto 0) of
STD_LOGIC_VECTOR (49 downto 0);
signal testvectors: tvarray;
shared variable vectornum, errors: integer;
begin
-- instantiate device under test
dut: adder port map (a, b, cin, cout, s);
-- generate clock
process begin
	clk <= '1'; wait for 15 ns;  
	clk <= '0'; wait for 5 ns;
end process;
-- at start of test, load vectors
-- and pulse reset
process is
file tv: TEXT;
variable i, j: integer;
variable L: line;
variable ch: character;
begin
	-- read file of test vectors
	i := 0;
	FILE_OPEN (tv, "./adder.tv", READ_MODE);
	while not endfile(tv) loop
		readline (tv, L);
		for j in 49 downto 0 loop
			read (L, ch);
			if (ch = '_') then read (L, ch);
			end if;
			if (ch = '0') then
			testvectors (i) (j) <= '0';
			else testvectors (i) (j) <= '1';
			end if;
		end loop;
		i := i + 1;
	end loop;
	vectornum := 0; errors := 0;
	-- reset <= '1'; wait for 27 ns; reset <= '0';
	wait;
end process;
-- apply test vectors on rising edge of clk
process (clk) begin
	if (clk'event and clk='1') then   
		a <= testvectors (vectornum) (49 downto 34); --after 1 ns;
		b <= testvectors (vectornum) (33 downto 18); --after 1 ns;
		cin <= testvectors (vectornum) (17); --after 1 ns;
		coutexpected <= testvectors (vectornum)(16); --after 1 ns;
		sexpected <= testvectors (vectornum)(15 downto 0); --after 1 ns;
	end if;
end process;
-- check results on falling edge of clk
process (clk) begin
	if (clk'event and clk = '0')then
		for k in 0 to 15 loop
			assert s(k) = sexpected(k)
			 report "Vetor deu erro n. Teste: " &integer'image(vectornum) &". Esperado sesp ="& STD_LOGIC'image(sexpected(k))&"Valor Obtido: s ="& STD_LOGIC'image(s(k));
			 if (s(k) /= sexpected(k)) then
				errors := errors + 1;
			end if;
		end loop;
		
			assert cout= coutexpected
			report "Vetor deu erro n. Teste: " &integer'image(vectornum)&". Esperado coutesp ="& STD_LOGIC'image(coutexpected)&"Valor Obtido: cout ="& STD_LOGIC'image(cout);
			if (cout /= coutexpected) then
			  errors := errors + 1;
			end if;  
		
			
		vectornum := vectornum + 1;
		if (vectornum = MEMSIZE) then
			if (errors = 0) then
				report "Just kidding --" &
				integer'image (vectornum) &
				"tests completed successfully."
				severity failure;
			else
				report integer'image (vectornum) &
				"tests completed, errors = " &
				integer'image (errors)
				severity failure;
			end if;
		end if;
	end if;
end process;
end;
