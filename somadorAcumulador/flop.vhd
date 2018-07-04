library IEEE; use IEEE.STD_LOGIC_1164.all;
entity flop is
	port(d: in STD_LOGIC_VECTOR(15 downto 0);
		clock: in STD_LOGIC;
		q: out STD_LOGIC_VECTOR(15 downto 0));
end;

architecture synth of flop is
begin
	process(clock) begin
		if rising_edge(clock) then
			q <= d;
		end if;
	end process;
end;
