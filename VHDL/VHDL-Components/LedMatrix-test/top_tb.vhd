LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
	signal outp: std_logic;
	signal clk : std_logic := '1';
BEGIN

mclk : process
begin
	while true loop
		clk <= not clk;
		wait for 5ns;
	end loop;
end process;

dut : entity work.top(rtl)
port map(
	CLK_100MHz => clk,
	IO_P6 => outp
);

END;
