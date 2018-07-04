library IEEE; use IEEE.STD_LOGIC_1164.all;
entity floprs is
	port(clock, reset: in STD_LOGIC;
		d: in STD_LOGIC_VECTOR(3 downto 0);
		q: out STD_LOGIC_VECTOR(3 downto 0));
	end;
architecture synchronous of floprs is
begin
	process(clock) begin
		if rising_edge(clock) then
			if reset = '1' then q <= "0000";
			else q <= d;
			end if;
		end if;
	end process;
end;
