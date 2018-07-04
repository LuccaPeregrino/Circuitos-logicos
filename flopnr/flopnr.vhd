library IEEE; use IEEE.STD_LOGIC_1164.all;
entity flopnr is
	port(clk: in STD_LOGIC;
		reset: in STD_LOGIC;
		en: in STD_LOGIC;
		d: in STD_LOGIC_VECTOR(3 downto 0);
		q: out STD_LOGIC_VECTOR(3 downto 0));
end;

architecture asynchronous of flopnr is
-- asynchronous reset
begin
	process(clk, reset) begin
		if reset = '1' then
			q <= "0000";
		else	
			if rising_edge(clk) then
				if en = '1' then
					q <= d;
				end if;
			end if;
		end if;
	end process;
end;
