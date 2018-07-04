library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use STD.TEXTIO.ALL ;

entity sync_testbench is -- no inputs or outputs
end;
architecture sim of sync_testbench is
	component sync
		port(clk: in STD_LOGIC;
		d: in STD_LOGIC;
		n1: inout STD_LOGIC;
		q: out STD_LOGIC);
	end component;
signal clk_tb: STD_LOGIC;
signal clk: STD_LOGIC;
signal d,q,n1: STD_LOGIC;
signal qexpected: STD_LOGIC;
constant MEMSIZE: integer := 10;
type tvarray is array (MEMSIZE downto 0) of
STD_LOGIC_VECTOR (3 downto 0);
signal testvectors: tvarray;
shared variable vectornum, errors: integer;
begin 
-- instantiate device under test
dut: sync port map (clk,d,n1,q);
-- generate clock
process begin
	clk_tb <= '1'; wait for 10 ns;  
	clk_tb <= '0'; wait for 5 ns;
end process;
process is
file tv: TEXT;
variable i, j: integer;
variable L: line;
variable ch: character;
begin
	-- read file of test vectors
	i := 0;
	FILE_OPEN (tv, "./sync.tv", READ_MODE);
	while not endfile(tv) loop
		readline (tv, L);
		for j in 3 downto 0 loop
			read (L, ch);
			if (ch = '_') then read (L, ch);
			end if;
			if (ch = '0') then
			testvectors (i) (j) <= '0';
			end if;
			if (ch = '1') then
			testvectors (i) (j) <= '1';
			end if;
			if (ch = 'U') then
			testvectors (i) (j) <= 'U';
			end if;
		end loop;
		i := i + 1;
	end loop;
	vectornum := 0; errors := 0;
	-- reset <= '1'; wait for 27 ns; reset <= '0';
	wait;
end process;
-- apply test vectors on rising edge of clk
process (clk_tb) begin
	if (clk_tb'event and clk_tb='1') then
		clk <= testvectors (vectornum) (3); --after 1 ns;
		d <= testvectors (vectornum)(2); --after 1 ns;
		n1 <= testvectors (vectornum)(1); --after 1 ns;
		qexpected <= testvectors (vectornum)(0); --after 1 ns;
	end if;
end process;
-- check results on falling edge of clk
process (clk_tb) begin
	if (clk_tb'event and clk_tb = '0')then
		if (qexpected /='U') then
			assert q = qexpected
				report "Vetor deu erro ";
			if (q /= qexpected) then
				errors := errors + 1;
			end if;
		end if;
		vectornum := vectornum + 1;
		if (vectornum = MEMSIZE) then
			if (errors = 0) then
				report "just kiding" &
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