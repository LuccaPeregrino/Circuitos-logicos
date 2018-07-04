library IEEE; use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity adder is
	generic(N: integer := 16);
	port(a, b: in STD_LOGIC_VECTOR(N-1 downto 0);
	cin: in STD_LOGIC;
	cout: out STD_LOGIC;
	s: out STD_LOGIC_VECTOR(N-1 downto 0));
end;
architecture synth of adder is
	signal result: STD_LOGIC_VECTOR(N downto 0);
begin
	result <= ('0' & a) + ('0' & b) + cin; 
	s <= result(N-1 downto 0);
	cout <= result(N);
end;