library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VGA_Text_tmp is
port(
	 reset       : in  std_logic;
    clk		    : in  std_logic;
    TEXT_A      : out std_logic_vector(11 downto 0); -- text buffer
    TEXT_D      : in  std_logic_vector(07 downto 0);
	 FONT_A      : out std_logic_vector(11 downto 0); -- font buffer
	 FONT_D      : in  std_logic_vector(07 downto 0);
	 x				 : in natural;
	 y				 : in natural
);
end VGA_Text_tmp;

architecture rtl of VGA_Text_tmp is
	signal x_v			: std_logic_vector(11 downto 0);
	signal y_v			: std_logic_vector(11 downto 0);
	signal color		: std_logic_vector(7 downto 0);
	signal idx			: natural;
begin

process(clk)

begin
	if rising_edge(clk) then
		if (x > 44 and x < 688) and (y > 32 and y < 514) then
			TEXT_A <= std_logic_vector(to_unsigned((((x-46)/8) + ((y-34)/12) * 80), 12));
			FONT_A <= std_logic_vector(to_unsigned(((to_integer(unsigned(TEXT_D))*12)-1) + ((y-34) mod 12),12));
			--FONT_A <= std_logic_vector(to_unsigned(((to_integer(unsigned(TEXT_D))*12)+4) + ((y-33) mod 12),12));
			--idx <= ((x-49) mod 8);
			if FONT_D((x-49) mod 8) = '1' then
				color <= (others => '1');
			else
				color <= (others => '0');
			end if;
			
		end if;
	end if;
end process;
x_v <= std_logic_vector(to_unsigned(x,12));
y_v <= std_logic_vector(to_unsigned(y,12));
end rtl;

