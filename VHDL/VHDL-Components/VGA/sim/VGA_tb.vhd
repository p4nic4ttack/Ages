LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY VGA_tb IS
END VGA_tb;
 
ARCHITECTURE behavior OF VGA_tb IS 

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal out_vsync : std_logic;
   signal out_hsync : std_logic;
   signal out_r : std_logic_vector(2 downto 0);
   signal out_g : std_logic_vector(2 downto 0);
   signal out_b : std_logic_vector(1 downto 0);
	signal out_x : std_logic_vector(9 downto 0);
	signal out_y : std_logic_vector(9 downto 0);
 
BEGIN
mclk : process
begin
	while True loop
		clk <= not clk;
		wait for 20ns;
	end loop;
end process;

DUT : entity work.VGA(rtl)
port map(
	color		 => "11010010",
	clk		 => clk,
	out_vsync => out_vsync,
	out_hsync => out_hsync,
	out_r		 => out_r,
	out_g		 => out_g,
	out_b		 => out_b,
	out_x		 => out_x,
	out_y		 => out_y
);

END;
