library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
port(
	CLK_100MHz	: in std_logic;
	DPSwitch		: in std_logic_vector(7 downto 0);
	HSync			: out std_logic;
	VSync			: out std_logic;
	Red			: out std_logic_vector(2 downto 0);
	Green			: out std_logic_vector(2 downto 0);
	Blue			: out std_logic_vector(1 downto 0)
);
end top;

architecture structural of top is
	signal VGA_CLK : std_logic;
begin

PLL : entity work.PLL
port map(
	CLK_IN1 => CLK_100MHz,
	CLK_OUT1 => VGA_CLK
);

VGA : entity work.VGA(rtl)
port map(
	color => DPSwitch,
	clk => VGA_CLK,
	out_vsync => VSync,
	out_hsync => HSync,
	out_r		 => Red,
	out_g		 => Green,
	out_b		 => Blue
);

end structural;

