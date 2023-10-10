library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity vga_text is
port(
    reset       : in  std_logic;
    clk25MHz    : in  std_logic;
    RAM_A      : out std_logic_vector(12 downto 0); -- text buffer
    RAM_D      : in  std_logic_vector(07 downto 0);
	 RAM_R		: out std_logic;
    R           : out std_logic_vector(2 downto 0);
    G           : out std_logic_vector(2 downto 0);
    B           : out std_logic_vector(1 downto 0);
    hsync       : out std_logic;
    vsync       : out std_logic
);
end vga_text;

architecture rtl of vga_text is
	signal tmp_a	: natural;
	signal color	: std_logic_vector(7 downto 0) := (others => '0');
	signal x_pos	: natural;
	signal y_pos	: natural;
	signal rom_rd	: boolean := false;
	signal ram_reg	: std_logic_vector(7 downto 0);
	signal rom_reg	: std_logic_vector(7 downto 0);
	
	
	signal x_minus_30 : unsigned(12 downto 0) := (others => '0');
   signal y_minus_34 : unsigned(12 downto 0) := (others => '0');
   signal y_shifted_mult : unsigned(12 downto 0) := (others => '0');
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
	variable ram_reg_append	: std_logic_vector(12 downto 0);
	variable ram_shift_2 : std_logic_vector(12 downto 0);
	variable ram_shift_4  : std_logic_vector(12 downto 0);
	variable x_shifted	: std_logic_vector(12 downto 0);
	variable y_shifted	: std_logic_vector(12 downto 0);
	variable y_mult		: std_logic_vector(12 downto 0);
begin
	if rising_edge(CLK25MHz) then
		--1. text_ram lezen - 1 klok (46-47)
		--2. font ram lezen met resultaat v text_ram - 1 klok (48-49)
		--3. 8 komende klokken font ram data displayen (x-47)%8
		RAM_R <= '0';
		if (x_pos > 27 and x_pos < 688) and (y_pos > 32 and y_pos < 514) then
			if ((x_pos-30) mod 8) = 0 then
				x_shifted := std_logic_vector(shift_right(to_unsigned(x_pos,13)-30,3));
				y_shifted := std_logic_vector((to_unsigned(y_pos,13)-34)/12);
				y_mult := std_logic_vector(unsigned(shift_left(unsigned(y_shifted),4)) + unsigned(shift_left(unsigned(y_shifted),6)));
				ram_a <= std_logic_vector(unsigned(x_shifted) + unsigned(y_mult));
				ram_r <= '1';
			
				--ram_a <= std_logic_vector(to_unsigned((((x_pos-30)/8) + ((y_pos-34)/12) * 80), 13));
			elsif ((x_pos-32) mod 8) = 0 then
				ram_reg <= ram_d;
				RAM_R <= '1';
				ram_reg_append := "00000" & ram_reg;
				ram_shift_2 := std_logic_vector(unsigned(ram_reg_append) sll 2);
				ram_shift_4 := std_logic_vector(unsigned(ram_reg_append) sll 4);
				ram_a <= std_logic_vector(((unsigned(ram_shift_4) - unsigned(ram_shift_2) + ((y_pos-34) mod 12) + 3200)));--ram_shift_4;
				RAM_R <= '1';
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

end rtl;

