library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use STD.TEXTIO.ALL ;

entity testbench_somadorAcumulador is
	-- no inputs or outputs
end;

architecture sim of testbench_somadorAcumulador is
component somadorAcumulador
	port(a: in STD_LOGIC_VECTOR(15 downto 0);   	
		 sel0: in STD_LOGIC;
		 sel1: in STD_LOGIC;
	     cout: out STD_LOGIC;
         s: out STD_LOGIC_VECTOR(15 downto 0);
         clock: in STD_LOGIC);
end component;

signal clk_programa, clk: STD_LOGIC;
signal a, s, sexpected: STD_LOGIC_VECTOR(15 downto 0);
signal sel0, sel1, cout, coutexpected: STD_LOGIC;

constant MEMSIZE: integer := 14;
type tvarray is array (MEMSIZE downto 0) of STD_LOGIC_VECTOR (35 downto 0);
signal testvectors: tvarray;
shared variable vectornum, errors: integer;
begin
-- instantiate device under test
dut: somadorAcumulador port map (a, sel0, sel1, cout, s, clk);
-- generate clockt
process begin
	clk_programa <= '1'; wait for 20 ns;  
	clk_programa <= '0'; wait for 5 ns;
end process;
-- at start of test, load vectors
-- and pulse reset
process is
file tv: TEXT;
variable i, j: integer;
variable L, IGNORE: line;
variable ch: character;
begin
	-- read file of test vectors
	i := 0;
	FILE_OPEN (tv, "./somadorAcumulador.tv", READ_MODE);
	while not endfile(tv) loop
		readline (tv, L);
		for j in 35 downto 0 loop
			read (L, ch);
			if (ch = '-') then
				readline(tv, IGNORE);
			end if;
			if (ch = '_') then
				read (L, ch);
			end if;
			if (ch = '0') then
				testvectors (i) (j) <= '0';
			else
				testvectors (i) (j) <= '1';
			end if;
		end loop;
		i := i + 1;
	end loop;
	vectornum := 0; errors := 0;
	-- reset <= '1'; wait for 27 ns; reset <= '0';
	wait;
end process;
-- apply test vectors on rising edge of clk
process (clk_programa) begin
	if (clk_programa'event and clk_programa='1') then--Ordem exata do arquivo somadorAcumulador.tv
		a <= testvectors (vectornum) (32 downto 17);
		sel0 <= testvectors (vectornum) (34);
		sel1 <= testvectors (vectornum) (33);
		sexpected <= testvectors (vectornum)(16 downto 1);
		coutexpected <= testvectors (vectornum) (0);
		clk <= testvectors (vectornum) (35);
	end if;
end process;
-- check results on falling edge of clk
process (clk_programa) begin
	if (clk_programa'event and clk_programa = '0')then
		for k in 0 to 15 loop
			assert s(k)= sexpected(k)
				report "Vetor deu erro n. Teste: " &integer'image(vectornum)&". Esperado sesp ="& STD_LOGIC'image(sexpected(k))&"Valor Obtido: s("&integer'image(k)&") ="& STD_LOGIC'image(s(k));
			
			if (s /= sexpected) then
				errors := errors + 1;
			end if;
		end loop;
		
		assert cout = coutexpected
			report "cout deru erro. Esperado = " & STD_LOGIC'image(coutexpected) & ", valor obtido = " & STD_LOGIC'image(cout);
		
		if (cout /= coutexpected) then
			errors := errors +1;
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