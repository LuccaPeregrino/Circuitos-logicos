library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use STD.TEXTIO.ALL ;



entity testbench is -- no inputs or outputs
end;
architecture sim of testbench is
	component flop
		port(d : in   STD_LOGIC_VECTOR (3 downto 0);
			  clk: in STD_LOGIC;
			  q: out STD_LOGIC_VECTOR(3 downto 0));
	end component;
signal clktest, clk: STD_LOGIC;
signal d, q: STD_LOGIC_VECTOR (3 downto 0);

signal qexpected: STD_LOGIC_VECTOR (3 downto 0);
constant MEMSIZE: integer := 6;
type tvarray is array (MEMSIZE downto 0) of STD_LOGIC_VECTOR (8 downto 0);
signal testvectors: tvarray;
shared variable vectornum, errors: integer;
begin
-- instantiate device under test
dut: flop port map (d, clk, q);
-- generate clock
process begin
clktest <= '1'; wait for 5 ns;  
clktest <= '0'; wait for 5 ns;
end process;
-- at start of test, load vectors
-- and pulse reset
process is
file tv: TEXT;
variable i, j, k: integer;-- k: 
variable L: line;
variable ch: character;
begin
-- read file of test vectors
i := 0;
FILE_OPEN (tv, "./example.tv", READ_MODE);
while not endfile(tv) loop
	readline (tv, L);
	for j in 8 downto 0 loop
		read (L, ch);
		if (ch = '_') then read (L, ch);
		end if;
		if (ch = '0') then
		testvectors (i) (j) <= '0';
		else testvectors (i) (j) <= '1';
		end if;
	end loop;
	i   := i  + 1;
end loop;
vectornum := 0; errors := 0;
--reset <= '1'; wait for 27 ns; reset <= '0';
wait;
end process;
-- apply test vectors on rising edge of clk
process (clktest) begin
if (clktest'event and clktest='1')then   
d <= testvectors (vectornum) (8 downto 5); --after 1 ns;
clk <= testvectors (vectornum) (4); --after 1 ns;
qexpected <= testvectors (vectornum)(3 downto 0); --after 1 ns;
end if;
end process;
-- check results on falling edge of clk
process (clktest) begin
if (clktest'event and clktest = '0')then -- and reset = '0')then
	for k in 0 to 5 loop
assert q(k)= qexpected(k)
	report "Vetor deu erro n. Teste: " &integer'image(vectornum)&". Esperado qexp ="& STD_LOGIC'image(qexpected(k))&"Valor Obtido: q("&integer'image(k)&") ="& STD_LOGIC'image(q(k));
	if (q /= qexpected) then
	errors := errors + 1;
	end if;
	
	end loop;

	vectornum := vectornum + 1;
	if (is_x (testvectors(vectornum))) then
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








