LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
	signal en_sim	: boolean := true;
	signal clk		: std_logic := '1';
	signal addr		: std_logic_vector(14 downto 0);
	signal dq		: std_logic_vector(7 downto 0); -- P9
	signal ce_n		: std_logic; -- P7.1
	signal ce		: std_logic; -- P7.2
	signal we_n		: std_logic; -- P7.3
	signal oe_n		: std_logic; -- P7.4
	
	signal uart_tx		: std_logic; -- P7.5
	signal tx_busy		: std_logic;  -- P7.6
BEGIN
mclk : process
begin
	while en_sim = true loop
		clk <= not clk;
		wait for 42ns;
	end loop;
	wait;
end process;

DUT : entity work.top(structural)
port map(
	CLK_100MHz => clk,
	addr => addr,
	dq => dq,
	ce_n => ce_n,
	ce => ce,
	we_n => we_n,
	oe_n => oe_n,
	uart_tx => uart_tx,
	tx_busy => tx_busy
);
END;
