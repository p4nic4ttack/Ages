LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY ws282_transmit_tb IS
END ws282_transmit_tb;
 
ARCHITECTURE behavior OF ws282_transmit_tb IS
constant data_in	: std_logic_vector(23 downto 0) := (others => '1');
signal clk		: std_logic := '0';
signal tx_ready: std_logic := '1';
signal data_out: std_logic;
signal en_sim	: boolean := true;
signal enable	: std_logic := '1';
signal counter : natural := 10;

BEGIN
DUT : entity work.ws282_transmit(rtl)
generic map(
	amount_leds => 1,
	rgb_len => 24
)
port map(
	rgb => data_in,
	clk => clk,
	enable => enable,
	tx_ready => tx_ready,
	data_out => data_out
);
mclk : process
begin
	while true loop
		clk <= not clk;
		wait for 5ns;
	end loop;
	wait;
end process;

process(clk)
begin
	if rising_edge(clk) then
		if counter = 0 then
			enable <= '0';
		else
			counter <= counter-1;
		end if;
	end if;
end process;

END;
