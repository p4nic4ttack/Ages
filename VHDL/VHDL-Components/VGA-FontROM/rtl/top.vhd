library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
port(
	CLK_100MHz	: in std_logic;
	HSync	: out std_logic;
	VSync	: out std_logic;
	Red	: out std_logic_vector(2 downto 0);
	Green	: out std_logic_vector(2 downto 0);
	Blue	: out std_logic_vector(1 downto 0)
);
end top;

architecture structural of top is
	signal down_clk	: std_logic;
	--signal ram_clk		: std_logic;
	signal ram_wea		: std_logic := '0';
	signal ram_addr	: std_logic_vector(11 downto 0);
	signal ram_din		: std_logic_vector(7 downto 0) := "00000000";
	signal ram_dout	: std_logic_vector(7 downto 0);
	signal rom_addr	: std_logic_vector(11 downto 0);
	signal rom_dout	: std_logic_vector(7 downto 0);
	signal tmp_r		: std_logic;
	signal tmp_g		: std_logic;
	signal tmp_b		: std_logic;
begin
PLL : entity work.PLL(Xilinx)
port map(
	CLK_IN1	=> CLK_100MHz,
	CLK_OUT1 => down_clk
);

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

vga : entity work.vga_text(rtl)
port map(
	reset => '0',
	clk25MHz => down_clk,
	text_a => ram_addr,
	text_d => ram_dout,
	font_a => rom_addr,
	font_d => rom_dout,
	R => Red,
	G => Green,
	B => Blue,
	hsync => HSync,
	vsync => VSync
);

--Red <= (others => tmp_r);
--Green <= (others => tmp_g);
--Blue <= (others => tmp_b);

end structural;

