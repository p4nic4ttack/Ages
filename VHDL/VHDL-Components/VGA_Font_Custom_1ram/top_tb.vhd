LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_textio.all;
use std.textio.all;

ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS

	signal down_clk	: std_logic := '0';
	signal ram_wea		: std_logic := '0';
	signal ram_addr	: std_logic_vector(12 downto 0) := "0000000000000";
	signal ram_din		: std_logic_vector(7 downto 0) := "00000000";
	signal ram_dout	: std_logic_vector(7 downto 0) := "00000000";
	signal x				: natural := 0;
	signal y				: natural := 0;
BEGIN

mclk : process
begin
	while true loop
		down_clk <= not down_clk;
		wait for 5ns;
	end loop;
end process;

RAM : entity work.RAM
port map(
	clka => down_clk,
	wea(0) => '0',
	addra => ram_addr,
	dina => ram_din,
	douta => ram_dout
);


VGA_TMP : entity work.VGA_Text_tmp(rtl)
port map(
	clk => down_clk,
	reset  => '0',
	ram_a => ram_addr,
	ram_d => ram_dout,
	x		 => x,
	y		 => y
);

stimuli : process
begin
	if x < 800 then
		x <= x + 1;
	else
		y <= y + 1;
		x <= 0;
	end if;
	if y > 525 then
		y <= 0;
	end if;
	wait for 10ns;
end process;


END;
