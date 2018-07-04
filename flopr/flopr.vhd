library IEEE; use IEEE.STD_LOGIC_1164.all;
entity flopr is
	port(reset: in STD_LOGIC;
		clock: in STD_LOGIC;
		d: in STD_LOGIC_VECTOR(3 downto 0);
		q: out STD_LOGIC_VECTOR(3 downto 0));
end;

architecture asynchronous of flopr is
-- asynchronous reset
begin
	process(clock, reset) begin
		if reset = '1' then
			q <= "0000";
		elsif rising_edge(clock) then
				q <= d;
		end if;
	end process;
end;
