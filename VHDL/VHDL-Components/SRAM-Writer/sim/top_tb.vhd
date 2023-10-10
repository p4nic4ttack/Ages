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
	signal sw1		: std_logic;-- := '1';
	signal sw2		: std_logic;-- := '1';
	signal dpsw		: std_logic_vector(7 downto 0);
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
	sw1 => sw1,
	sw2 => sw2,
	dpswitch => dpsw
);

stimuli : process
begin
for i in 0 to 19 loop
	sw1 <= '0';
	sw2 <= '1';
	wait for 84ns;
end loop;

end process;

END;
