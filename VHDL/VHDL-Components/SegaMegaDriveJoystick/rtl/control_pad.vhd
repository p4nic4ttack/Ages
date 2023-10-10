library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_pad is
port(
	CLK_100MHz	: in std_logic;
	in_btn_c_sel: in std_logic;
	in_btn_ab	: in std_logic;
	in_btn_up	: in std_logic;
	in_btn_do	: in std_logic;
	in_btn_le	: in std_logic;
	in_btn_ri	: in std_logic;
	
	toggle		: out std_logic;
	
	out_btn_c	: out std_logic;
	out_btn_sel	: out std_logic;
	out_btn_a	: out std_logic;
	out_btn_b	: out std_logic;
	out_btn_up	: out std_logic;
	out_btn_do	: out std_logic;
	out_btn_le	: out std_logic;
	out_btn_ri	: out std_logic

	--LED			: out std_logic_vector(7 downto 0) := (others => '0')
);
end control_pad;

architecture rtl of control_pad is
	signal down_clk	: std_logic;
	signal tmp_toggle	: std_logic;
begin

PLL : entity work.PLL
port map(
	inclk0 => CLK_100MHz,
	C0 => down_clk
);

chip_en : entity work.clock_en_generic(rtl)
generic map(
	clk_freq => 12500000,
	req_freq => 180.0
)
port map(
	clk => down_clk,
	chip_en => tmp_toggle
);

out_btn_up <= (not in_btn_up);
out_btn_do <= (not in_btn_do);
out_btn_le <= (not in_btn_le) when (tmp_toggle = '1');
out_btn_ri <= (not in_btn_ri) when (tmp_toggle = '1');

process(tmp_toggle)
begin
	if tmp_toggle = '0' then
		if in_btn_ab = '0' then
			out_btn_a <= '1';
		else
			out_btn_a <= '0';
		end if;
		
		if in_btn_c_sel = '0' then
			out_btn_sel <= '1';
		else
			out_btn_sel <= '0';
		end if;
	else
		if in_btn_ab = '0' then
			out_btn_b <= '1';
		else
			out_btn_b <= '0';
		end if;
		
		if in_btn_c_sel = '0' then
			out_btn_c <= '1';
		else
			out_btn_c <= '0';
		end if;
	end if;
end process;

toggle <= tmp_toggle;
end rtl;

