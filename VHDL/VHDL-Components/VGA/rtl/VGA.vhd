library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity VGA is
port(
	clk			: in std_logic;
	color			: in std_logic_vector(7 downto 0);
	out_vsync	: out std_logic := '1';
	out_hsync	: out std_logic := '1';
	out_r			: out std_logic_vector(2 downto 0);
	out_g			: out std_logic_vector(2 downto 0);
	out_b			: out std_logic_vector(1 downto 0);
	
	out_x 		: out std_logic_vector(9 downto 0);
	out_y			: out std_logic_vector(9 downto 0)
);
end VGA;

architecture rtl of VGA is
	--constant tmp_color		: std_logic_vector(7 downto 0) := "11111100";
	type s_vga is (V_BP, V_FP, DISP, H_SYNC, V_SYNC);
	
	constant H_back_porch	: natural := 48; -- 48 Pixels
	constant H_front_porch	: natural := 16; -- 16 Pixels
	constant V_back_porch	: natural := 33; -- 33 lines
	constant V_front_porch	: natural := 10; -- 10 lines
	
	constant H_width			: natural := 640;
	constant V_height			: natural := 480;
	constant HSync				: natural := 96;
	constant VSync				: natural := 2;
	constant scan_line		: natural := H_back_porch + H_width + H_front_porch;
	constant V_BP_ticks		: natural := V_back_porch * (scan_line + HSYNC);
	
	signal draw					: boolean := false;
	signal x_count				: natural := 0;
	signal y_count				: natural := 0;
	signal tot_count			: natural := 0;
	signal fsm					: s_vga	 := V_BP;
	signal prev_state			: s_vga	 := V_BP;
begin

process(clk)
begin
	if rising_edge(clk) then
	
		case fsm is
			when V_BP =>
				draw <= false;
				out_hsync <= '1';
				out_vsync <= '1';
				if x_count = scan_line and tot_count < V_BP_ticks then -- x_count = 704 and tot_count != 26400
					prev_state <= V_BP;
					fsm <= H_SYNC;
				else
					x_count <= x_count + 1;
					tot_count <= tot_count + 1;
				end if;
			
			when H_SYNC =>
				draw <= false;
				out_hsync <= '0';
				out_vsync <= '1';
				if x_count = (scan_line + HSYNC) then
					x_count <= 0;
					
					if prev_state = V_BP and tot_count = V_BP_ticks then
						fsm <= DISP;
					elsif prev_state = V_BP then
						fsm <= V_BP;
					elsif prev_state = V_FP and tot_count = 418400 then
						fsm <= V_SYNC;
					elsif prev_state = V_FP then
						fsm <= V_FP;
					elsif prev_state = DISP and tot_count = 410400 then
						fsm <= V_FP;
					elsif prev_state = DISP then
						fsm <= DISP;
					end if;
				else
					tot_count <= tot_count + 1;
					x_count <= x_count + 1;
				end if;
			
			when DISP =>
				-- Display logic
				out_hsync <= '1';
				out_vsync <= '1';
				if x_count > H_back_porch and x_count < H_back_porch + H_width then -- H back porch < x < H back porch +  screen width (Draw area)
					draw <= true;
				else
					draw <= false;
				end if;
				
				-- State logic
				if x_count = scan_line and tot_count < 410400 then -- x_count = 704 and tot_count = (48+640+16+96)*(33+480)
					prev_state <= DISP;
					fsm <= H_SYNC;
				else
					x_count <= x_count + 1;
					tot_count <= tot_count + 1;
				end if;
				
			when V_FP =>
				draw <= false;
				out_hsync <= '1';
				out_vsync <= '1';
				if x_count = scan_line and tot_count < 418400 then
					prev_state <= V_FP;
					fsm <= H_SYNC;
				else
					x_count <= x_count + 1;
					tot_count <= tot_count + 1;
				end if;
				
			when V_SYNC =>
				draw <= false;
				out_vsync <= '0';
				if tot_count = 420000 then
					tot_count <= 0;
					x_count <= 0;
					fsm <= V_BP;
				elsif tot_count > 419104 and tot_count < 419200 then
					out_hsync <= '0';
					tot_count <= tot_count + 1;
				elsif tot_count > 419904 and tot_count < 420000 then
					out_hsync <= '0';
					tot_count <= tot_count + 1;
				else
					out_hsync <= '1';
					tot_count <= tot_count + 1;
				end if;
				
				
		end case;
		
	end if;
end process;

out_r <= (others => '0') when (draw = false)
			else color(2 downto 0);
			
out_g <= (others => '0') when (draw = false)
			else color(5 downto 3);
			
out_b <= (others => '0') when (draw = false)
			else color(7 downto 6);
out_x <= std_logic_vector(to_unsigned(x_count, 10));
out_y <= std_logic_vector(to_unsigned((tot_count/800), 10));
end rtl;

