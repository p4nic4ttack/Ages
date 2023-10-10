LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY control_pad_tb IS
END control_pad_tb;
 
ARCHITECTURE behavior OF control_pad_tb IS 
	signal clk		: std_logic := '0';
	signal toggle	: std_logic := '0';
	signal btn		: std_logic;
	signal LED		: std_logic_vector(7 downto 0);
BEGIN
mclk : process
begin
	while True loop
		clk <= not clk;
		wait for 40ns;
	end loop;
end process;

DUT : entity work.control_pad(rtl)
port map(
	clk_100MHz => clk,
	toggle => toggle,
	LED => LED,
	btn => btn
);
END;
