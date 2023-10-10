LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS

	signal down_clk	: std_logic := '0';
	--signal ram_clk		: std_logic;
	signal ram_wea		: std_logic := '0';
	signal ram_addr	: std_logic_vector(11 downto 0) := "000000000000";
	signal ram_din		: std_logic_vector(7 downto 0) := "00000000";
	signal ram_dout	: std_logic_vector(7 downto 0) := "00000000";
	signal rom_addr	: std_logic_vector(11 downto 0):= "000000000000";
	signal rom_dout	: std_logic_vector(7 downto 0):= "00000000";

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

ROM : entity work.ROM
port map(
	ena => '1',
	clka => down_clk,
	wea(0) => '0',
	addra => rom_addr,
	dina => "00000000",
	douta => rom_dout
);

VGA_TMP : entity work.VGA_Text_tmp(rtl)
port map(
	clk => down_clk,
	reset  => '0',
	text_a => ram_addr,
	text_d => ram_dout,
	font_a => rom_addr,
	font_d => rom_dout,
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
