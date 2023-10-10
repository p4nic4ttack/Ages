library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity vga_text is
port(
    reset       : in  std_logic;
    clk25MHz    : in  std_logic;
    RAM_A      : out std_logic_vector(12 downto 0); -- text buffer
    RAM_D      : in  std_logic_vector(07 downto 0);
    R           : out std_logic_vector(2 downto 0);
    G           : out std_logic_vector(2 downto 0);
    B           : out std_logic_vector(1 downto 0);
    hsync       : out std_logic;
    vsync       : out std_logic
);
end vga_text;

architecture rtl of vga_text is
	signal color	: std_logic_vector(7 downto 0) := (others => '0');
	signal x_pos	: natural;
	signal y_pos	: natural;
	signal rom_rd	: boolean := false;
	signal ram_reg	: std_logic_vector(7 downto 0);
	signal rom_reg	: std_logic_vector(7 downto 0);
begin

VGA : entity work.VGA(rtl)
port map(
	clk => clk25MHz,
	color => color,
	out_hsync => hsync,
	out_vsync => vsync,
	out_r => R,
	out_g => G,
	out_b => B,
	out_x => x_pos,
	out_y => y_pos
);

process(CLK25MHz)

begin
	if rising_edge(CLK25MHz) then
		--if (x_pos > 44 and x_pos < 688) and (y_pos > 32 and y_pos < 514) then
		--	TEXT_A <= std_logic_vector(to_unsigned((((x_pos-46)/8) + ((y_pos-34)/12) * 80), 12));
		--	FONT_A <= std_logic_vector(to_unsigned(((to_integer(unsigned(TEXT_D))*12)) + ((y_pos-34) mod 12),12));
		--	if FONT_D((8-(x_pos-49) mod 8)) = '1' then
		--		color <= (others => '1');
		--	else
		--		color <= (others => '0');
		--	end if;
		--end if;
		--1. text_ram lezen - 1 klok (46-47)
		--2. font ram lezen met resultaat v text_ram - 1 klok (48-49)
		--3. 8 komende klokken font ram data displayen (x-47)%8
		if (x_pos > 29 and x_pos < 688) and (y_pos > 32 and y_pos < 514) then
			if ((x_pos-30) mod 8) = 0 then
				ram_a <= std_logic_vector(to_unsigned((((x_pos-30)/8) + ((y_pos-34)/12) * 80), 13));
			elsif ((x_pos-32) mod 8) = 0 then
				ram_reg <= ram_d;
				ram_a <= std_logic_vector(to_unsigned(3200 + ((to_integer(unsigned(ram_reg))*12)) + ((y_pos-34) mod 12),13));
			elsif ((x_pos-39) mod 8) = 0 then
				rom_reg <= ram_d;
				
			end if;
			if rom_reg(7-(x_pos-49) mod 8) = '1' and x_pos > 48 and x_pos < 689 then
				color <= (others => '1');
			else
				color <= (others => '0');
			end if;
		end if;
	end if;
end process;

--process(TEXT_D, rom_rd)
--begin
--	if rom_rd = false then
--		ram_reg <= TEXT_D;
		--rom_reg <= (others => '0');
--	else
--		rom_reg <= TEXT_D;
		--ram_reg <= (others => '0');
--	end if;
--end process;

end rtl;

