
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity clock_en_generic is
	generic(
		clk_freq : integer := 100e6;
		req_freq : real 	 := 1.0
	);
	port(
		clk     : in std_logic;
		chip_en : out std_logic
	);
end clock_en_generic;

architecture rtl of clock_en_generic is
	constant req_cycles : integer := integer(real(clk_freq) / req_freq) - 1;
begin
process(clk) is
		variable pulse_cnt : integer := 0;
begin
	if rising_edge(clk) then
		if pulse_cnt < req_cycles then
			chip_en <= '0';
			pulse_cnt := pulse_cnt + 1;
		else
			chip_en <= '1';
			pulse_cnt := 0;
		end if;
	end if;
end process;

end rtl;