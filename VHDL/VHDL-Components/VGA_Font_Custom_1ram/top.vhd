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
	signal ram_wea		: std_logic := '0';
	signal ram_addr	: std_logic_vector(12 downto 0) := "0000000000000";
	signal ram_din		: std_logic_vector(7 downto 0) := "00000000";
	signal ram_dout	: std_logic_vector(7 downto 0);
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


vga : entity work.vga_text(rtl)
port map(
	reset => '0',
	clk25MHz => down_clk,
	ram_a => ram_addr,
	ram_d => ram_dout,
	R => Red,
	G => Green,
	B => Blue,
	hsync => HSync,
	vsync => VSync
);

end structural;

