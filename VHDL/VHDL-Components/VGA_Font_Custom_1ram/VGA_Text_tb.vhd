LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY VGA_Text_tb IS
END VGA_Text_tb;
 
ARCHITECTURE behavior OF VGA_Text_tb IS 
	signal clk	: std_logic := '0';
	signal x		: natural := 0;
	signal y		: natural := 0;
BEGIN

mclk : process
begin
while True loop
	clk <= not clk;
	wait for 5ns;
end loop;
wait;
end process;

DUT : entity work.VGA_Text_tmp(rtl)
port map(
	clk => clk,
	x => x,
	y => y
);

stimuli : process
begin
	if x < 688 then
		x <= x + 1;
	else
		y <= y + 1;
		x <= 0;
	end if;
	if y > 512 then
		y <= 0;
	end if;
	wait for 10ns;
end process;

END;
