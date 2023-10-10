library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VGA_Text_tmp is
port(
	 reset			: in  std_logic;
    clk				: in  std_logic;
    RAM_A      	: out std_logic_vector(12 downto 0); -- text buffer
    RAM_D      	: in  std_logic_vector(07 downto 0);
	 RAM_R			: out std_logic;
	 x					: in natural;
	 y					: in natural
);
end VGA_Text_tmp;

architecture rtl of VGA_Text_tmp is
	--constant base_addr: natural := 3200;
	--constant base_addr: std_logic_vector(4 downto 0) := "11001";
	constant base_addr: unsigned(11 downto 0) := "110010000000";
	signal tmp_a		: natural;
	signal x_v			: std_logic_vector(11 downto 0);
	signal y_v			: std_logic_vector(11 downto 0);
	
	signal color		: std_logic_vector(7 downto 0);
	signal ram_reg		: std_logic_vector(7 downto 0);
	signal rom_reg		: std_logic_vector(7 downto 0);
	
	signal hsync			: std_logic;
	signal vsync			: std_logic;
	signal red				: std_logic_vector(2 downto 0);
	signal green			: std_logic_vector(2 downto 0);
	signal blue				: std_logic_vector(1 downto 0);
	
	signal x_minus_30 : unsigned(12 downto 0) := (others => '0');
   signal y_minus_34 : unsigned(12 downto 0) := (others => '0');
	signal x_shifted : unsigned(12 downto 0) := (others => '0');
   signal y_shifted : unsigned(12 downto 0) := (others => '0');
   signal y_shifted_mult : unsigned(12 downto 0) := (others => '0');
	signal tmp	: std_logic_vector(7 downto 0);
begin

process(clk)
	variable x_minus_30	: natural;
	variable y_minus_34	: natural;
	variable x_shifted	: std_logic_vector(12 downto 0);
	variable y_shifted	: std_logic_vector(12 downto 0);
	variable y_mult		: std_logic_vector(12 downto 0);
	variable y_shifted_m	: natural;
	variable y_min_34_mod12 : natural;
	variable ram_reg_append	: std_logic_vector(12 downto 0);
	variable ram_shift_2 : std_logic_vector(12 downto 0);
	variable ram_shift_4  : std_logic_vector(12 downto 0);
begin
	if rising_edge(clk) then
		if (x > 27 and x < 688) and (y > 33 and y < 514) then
			RAM_R <= '0';
			if ((x-30) mod 8) = 0 then
				--ram_a <= std_logic_vector(to_unsigned((((x-30)/8) + ((y-34)/12) * 79), 13));
				
				--ram_a <= std_logic_vector(shift_right((to_unsigned(x,13)-30),3) + shift_left(shift_right((to_unsigned(y,13)-34),4),7));
				--x_minus_30 <= (to_unsigned(x, 13) - 30);
				--y_minus_34 <= (to_unsigned(y, 13) - 34);
				--x_shifted <= shift_right(x_minus_30, 3);
				--y_shifted <= shift_right(y_minus_34, 3) - shift_right(y_minus_34, 4);
				--y_shifted_mult <= shift_left(y_shifted, 7) - shift_left(y_shifted, 5) - shift_left(y_shifted, 4);
				--x_shifted <= shift_right((to_unsigned(x,13)-30),3);
				--ram_a <= std_logic_vector(x_shifted + y_shifted_mult);
				--x*80 = (x<<4) + (x<<6)
				--x/8 = (x>>3)
				--x/12 = (x>>3)-(x>>4)
				--x*12 = (x<<4)-(i<<2)
				--ram_a <= std_logic_vector(shift_right((to_unsigned(x,13)-30),3) + (shift_left(shift_right((to_unsigned(y,13)-34),3) - shift_right((to_unsigned(y,13)-34),4), 7) - shift_left(shift_right((to_unsigned(y,13)-34),3) - shift_right((to_unsigned(y,13)-34),4), 5) - shift_left(shift_right((to_unsigned(y,13)-34),3) - shift_right((to_unsigned(y,13)-34),4), 4)));
				--x_minus_30 := x-30;
				--y_minus_34 := y-34;
				
				--x_shifted := to_integer(shift_right(to_unsigned(x_minus_30,13), 3));
				--y_shifted := to_integer(shift_right(to_unsigned(y_minus_34,13), 3) - shift_right(to_unsigned(y_minus_34,13),4));
				--y_shifted_m := to_integer(shift_left(to_unsigned(y_shifted,13), 4) + (shift_left(to_unsigned(y_shifted,13),6) ) - y_shifted );
				--ram_a <= std_logic_vector(to_unsigned(x_shifted + y_shifted_m,13));
				x_shifted := std_logic_vector(shift_right(to_unsigned(x,13)-30,3));
				--y_shifted := std_logic_vector(unsigned(shift_right(to_unsigned(y,13)-34,4)) - unsigned(shift_right(to_unsigned(y,13)-34,7)) - unsigned(shift_right(to_unsigned(y,13)-34,8)));
				y_shifted := std_logic_vector((to_unsigned(y,13)-34)/12);
				y_mult := std_logic_vector(unsigned(shift_left(unsigned(y_shifted),4)) + unsigned(shift_left(unsigned(y_shifted),6) ));
				ram_a <= std_logic_vector(unsigned(x_shifted) + unsigned(y_mult));
				--ram_a <= y_shifted;
				ram_r <= '1';
			elsif ((x-32) mod 8) = 0 then
				ram_reg <= ram_d;
				RAM_R <= '1';
				ram_reg_append := "00000" & ram_reg;
				--ram_shift_2 := std_logic_vector(unsigned(ram_reg_append) sll 2);
				--ram_shift_4 := std_logic_vector(unsigned(ram_reg_append) sll 4);
				--ram_a <= std_logic_vector(((unsigned(ram_shift_4) - unsigned(ram_shift_2) + ((y-34) mod 12) + 3200)));--ram_shift_4;
				ram_shift_4 := std_logic_vector(shift_left(unsigned(ram_reg_append),4));
				ram_shift_2 := std_logic_vector(shift_left(unsigned(ram_reg_append),2));
				ram_a <= std_logic_vector(unsigned(ram_shift_4) - unsigned(ram_shift_2) + ((y-34) mod 12) + 3200);
			elsif ((x-39) mod 8) = 0 then
				rom_reg <= ram_d;
			end if;
			if rom_reg(7-(x-49) mod 8) = '1' and x > 48 and x < 689  then
				color <= (others => '1');
			else
				color <= (others => '0');
			end if;
			
		end if;
	end if;
end process;

VGA : entity work.VGA(rtl)
port map(
	clk => clk,
	color => color,
	out_r	=> red,
	out_g	=> green,
	out_b => blue,
	out_hsync => hsync,
	out_vsync => vsync
);

--TEXT_A <= address;
x_v <= std_logic_vector(to_unsigned(x,12));
y_v <= std_logic_vector(to_unsigned(y,12));
end rtl;

