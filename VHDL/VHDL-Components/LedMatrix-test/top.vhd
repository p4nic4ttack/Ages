library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
port(
	CLK_100MHz	: in std_logic;
	--btn			: in std_logic;
	IO_P6			: out std_logic
);
end top;

architecture rtl of top is
constant input	: std_logic_vector(6143 downto 0) := "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000000000000000000000000000000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000111111111111111111111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
signal is_ready: std_logic;
signal enabled	: std_logic := '1';
signal debounced : std_logic;
signal counter	: natural :=0;
constant len	: natural := 24;
constant amount: natural := 256;
signal down_clk: std_logic;
begin
ws282 : entity work.ws282_transmit(rtl)
generic map(
	amount_leds => amount,
	rgb_len => len
)
port map(
	rgb => input,
	clk => CLK_100MHz,
	enable => enabled,
	tx_ready => is_ready,
	data_out => IO_P6
);
--ena : entity work.clock_en_generic(rtl)
--generic map(
--	clk_freq => 100e6,
--	req_freq => 2.0--50000000.0
--)
--port map(
--	clk => CLK_100MHz,
--	chip_en => down_clk
--);
--deb : entity work.debouncer(rtl)
--port map(
--	clk => CLK_100MHz,
--	button => btn,
--	debounced_button => debounced
--);
process(CLK_100MHz)
begin
	--if is_ready = '1' and debounced = '1' then
	--	enabled <= '1';
	--else
	--	enabled <= '0';
	--end if;
	--if is_ready = '1' and enabled = '0' then
	--	enabled <= '1';
	--end if;
	
	--if is_ready = '0' then
	--	enabled <= '0';
	--end if;
	--if down_clk = '1' then
	--	enabled <= '1';
	--end if;
	--if is_ready = '1' and enabled = '0' then
	--	enabled <= '1';
	--end if;
	--if counter < 50000000 then
	--	counter <= counter + 1;
	--else
	--	counter <= 0;
	--	enabled <= '1';
	--end if;
end process;

end rtl;

