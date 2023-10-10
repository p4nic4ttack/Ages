library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity top2 is
port(
	CLK_50MHz	: in std_logic;
	
	--RAM signals
	addr			: out std_logic_vector(16 downto 0) := (others => '0'); -- P6 & P8
	dq				: inout std_logic_vector(7 downto 0) := (others => '0'); -- P9
	ce_n			: out std_logic; -- P7.1
	ce				: out std_logic; -- P7.2
	we_n			: out std_logic; -- P7.3
	oe_n			: out std_logic; -- P7.4
	
	--Basic input/output
	LED			: out std_logic_vector(7 downto 0) := (others => '0');
	sw1			: in std_logic;
	sw2			: in std_logic;
	
	-- Joystick
	in_btn_c_sel: in std_logic;
	in_btn_ab	: in std_logic;
	in_btn_up	: in std_logic;
	in_btn_do	: in std_logic;
	in_btn_le	: in std_logic;
	in_btn_ri	: in std_logic;
	toggle_line	: out std_logic;
	
	-- UART signals
	uart_rx		: in std_logic;
	sd_rx			: in std_logic;
	
	-- LED Matrix
	led_matrix	: out std_logic

);
end top2;

architecture structural of top2 is
	--constant wait_time : natural := --000; --6000 of 12000
	-- Z80 signals --
	signal z80_clk		: std_logic;
	signal z80_addr	: std_logic_vector(16 downto 0) := (others => '0');
	signal z80_do		: std_logic_vector(7 downto 0)  := (others => '0');
	signal z80_din		: std_logic_vector(7 downto 0)  := (others => '0');
	signal z80_mreq	: std_logic;
	signal z80_ioreq	: std_logic;
	signal z80_rd		: std_logic;
	signal z80_wr		: std_logic;
	signal z80_wait_n	: std_logic := '1';
	
	signal rst			: std_logic := '0';
	signal tmp_cnt		: natural := 3;
	------------------
	
	-- RAM signals --
	signal bootl_addr	: std_logic_vector(16 downto 0) := (others => '0');
	signal bootl_mreq	: std_logic;
	signal bootl_ioreq: std_logic;
	signal bootl_wr	: std_logic;
	signal bootl_rd	: std_logic;
	signal bootl_datin: std_logic_vector(7 downto 0) := (others => '0');
	signal bootl_datout: std_logic_vector(7 downto 0) := (others => '0');
	signal bootl_wea	: std_logic_vector(0 downto 0) := (others => '0');
	
	signal ram_din		: std_logic_vector(7 downto 0) := (others => '0');
	signal ram_addr	: std_logic_vector(16 downto 0) := (others => '0');
	signal ram_dout	: std_logic_vector(7 downto 0) := (others => '0');
	signal ram_mreq_n : std_logic;
	signal ram_ioreq_n: std_logic;
	signal ram_wr_n	: std_logic;
	signal ram_rd_n	: std_logic;
	
	signal ws2812_addr: std_logic_vector(16 downto 0) := (others => '0');
	signal ws2812_din: std_logic_vector(7 downto 0) := (others => '0');
	------------------
	
	-- Debounced signals --
	signal sw1_deb		: std_logic := '1';
	signal sw2_deb		: std_logic := '1';
	-----------------------
	-- UART signals --
	signal busy_rx		: std_logic;
	signal rx_data		: std_logic_vector(7 downto 0) := (others => '0');
	signal addr_cnt	: natural := 0;
	signal sd_busy		: std_logic;
	signal sd_byte		: std_logic_vector(7 downto 0);
	signal tmp_addr_cnt : natural := 65536;--> BETERE OPLOSSING ZOEKEN
	signal wr_boot		: std_logic;
	------------------
	-- Joypad signals --
	signal joystick_int	: std_logic;
	signal joystick1_reg : std_logic_vector(7 downto 0) := (others => '0'); --"A B C UP DWN LFT RGT START"
	signal int_counter	: natural := 0;
	--------------------
	
	-- WS2812b signals --
	signal ws_ready		: std_logic;
	signal ws_enable		: std_logic := '0';
	signal frame_buf		: std_logic_vector(6143 downto 0);
	signal buff				: std_logic_vector(255 downto 0);
	----------------------
begin

ws2812 : entity work.ws282_transmit(rtl)
generic map(
	amount_leds => 256,
	rgb_len => 24
)
port map(
	rgb => frame_buf,
	clk => z80_clk,
	enable => ws_enable,
	--dbg_leds => LED,
	data_out => led_matrix,
	tx_ready => ws_ready
);

PLL : entity work.PLL
port map(
	inclk0 => CLK_50MHz,
	c0 => z80_clk
);

z80_core : entity work.T80se(rtl)
port map(
	RESET_n => rst,
	CLK_n => z80_clk,
	CLKEN => '1',
	A => z80_addr(15 downto 0),
	DI => z80_din,
	DO => z80_do,
	MREQ_n => z80_mreq,
	IORQ_n => z80_ioreq,
	RD_n => z80_rd,
	WR_n => z80_wr,
	WAIT_n => z80_wait_n,
	INT_n => joystick_int,
	NMI_n => '1',
	BUSRQ_n => '1'
);


RAM : entity work.SRAM(rtl)
port map(
	clk => z80_clk,
	address_in => ram_addr,
	mreq_n => ram_mreq_n,
	ioreq_n => ram_ioreq_n,
	rd_n => ram_rd_n,
	wr_n => ram_wr_n,
	data_in => ram_din,
	data_out => ram_dout,
	
   addr_out => addr,
	ce_n => ce_n,
	ce => ce,
	we_n => we_n,
	oe_n => oe_n,
	dq => dq
);

rx : entity work.uart_rx(rtl)
generic map(
	g_CLKS_PER_BIT => 108--217
)
port map(
	i_Clk => z80_clk,
	i_RX_Serial => uart_rx,
	o_RX_DV => busy_rx,
	o_RX_Byte => rx_data
);

sd_recv : entity work.uart_rx(rtl)
generic map(
	g_CLKS_PER_BIT => 325--651
)
port map(
	i_Clk => z80_clk,
	i_RX_Serial => sd_rx,
	o_RX_DV => sd_busy,
	o_RX_Byte => sd_byte
);

debounce_boot : entity work.debouncer(rtl)
port map(
	button => sw1,
	clk => z80_clk,
	debounced_button => sw1_deb
);

debounce_sw2 : entity work.debouncer(rtl)
port map(
	button => sw2,
	clk => z80_clk,
	debounced_button => sw2_deb
);


game_pad : entity work.control_pad(rtl)
port map(
	clk => z80_clk,
	in_btn_c_sel => in_btn_c_sel,
	in_btn_ab => in_btn_ab,
	in_btn_up => in_btn_up,
	in_btn_do => in_btn_do,
	in_btn_le => in_btn_le,
	in_btn_ri => in_btn_ri,
	toggle => toggle_line,
	out_btn_a => joystick1_reg(0),
	out_btn_b => joystick1_reg(1),
	out_btn_c => joystick1_reg(2),
	out_btn_up => joystick1_reg(3),
	out_btn_do => joystick1_reg(4),
	out_btn_le => joystick1_reg(5),
	out_btn_ri => joystick1_reg(6),
	out_btn_sel => joystick1_reg(7)
	
);
--LED(5) <= joystick1_a;
process(z80_clk)
	variable n_addr : natural range 0 to 6144 := 7;
--	variable v_addr	: std_logic_vector(11 downto 0) := "000000000001";
begin
	
	if rising_edge(z80_clk) then
		if ws_ready = '0' then
			ws_enable <= '0';
		end if;
		-- First receiving SD card data, in order to fill the VRAM
		if sd_busy = '1' then --> BETERE OPLOSSING ZOEKEN
			if tmp_addr_cnt = 65536 then
				bootl_addr <= "10000000000000000";
			else
				bootl_addr <= std_logic_vector(to_unsigned(tmp_addr_cnt, 17));
			end if;
			bootl_datin <= sd_byte;
			wr_boot <= '1';
			tmp_addr_cnt <= tmp_addr_cnt + 1;
		end if;
		if busy_rx = '1' then
			-- If uart rx received data, write to SRAM and increment address counter
			if addr_cnt = 0 then
				bootl_addr <= (others => '0');
			else
				bootl_addr <=  std_logic_vector(to_unsigned(addr_cnt, 17));
			end if;
			bootl_datin <= rx_data;
			wr_boot <= '1';
			addr_cnt <= addr_cnt + 1;
		-- If UART rx is listening for data ans sw3 is pressed, boot Z80 softcore
		elsif busy_rx = '0' and sw1_deb = '1' then
			rst <= '1';
			tmp_addr_cnt <= 65536;
		end if;
		-- When softcore is booted
		if rst = '1' then
			if tmp_cnt = 0 then
				rst <= '1';
			else
				tmp_cnt <= tmp_cnt - 1;
			end if;
			-- Memmap
			if z80_addr(14 downto 0) = "000001000010000" and z80_wr = '0' then -- (0x210) LED(0)
				LED(0) <= z80_do(0);
			elsif z80_addr(14 downto 0) = "000001000010001" and z80_wr = '0' then -- (0x211) LED(1)
				LED(1) <= z80_do(0);
			elsif z80_addr(14 downto 0) = "000001000010010" and z80_wr = '0' then -- (0x212) LED(2)
				LED(2) <= z80_do(0);
			elsif z80_addr(14 downto 0) = "000001000010011" and z80_wr = '0' then -- (0x213) LED(3)
				LED(3) <= z80_do(0);
			elsif z80_addr(14 downto 0) = "000001000010100" and z80_wr = '0' then -- (0x214) LED(4)
				LED(4) <= z80_do(0);
			elsif z80_addr(14 downto 0) = "000001000010101" and z80_wr = '0' then -- (0x215) LED(5)
				LED(5) <= z80_do(0);
			elsif z80_addr(14 downto 0) = "000001000010110" and z80_wr = '0' then -- (0x216) LED(6)
				LED(6) <= z80_do(0);
			elsif z80_addr(14 downto 0) = "000001000010111" and z80_wr = '0' then -- (0x217) LED(7)
				LED(7) <= z80_do(0);
			end if;
			
			
			if int_counter < 1000 then
				int_counter <= int_counter + 1;
				joystick_int <= '1';
			else
				int_counter <= 0;
				joystick_int <= '0';
			end if;
			
			--if ws_ready = '1' then
			--	if tmp_addr_cnt = 65536 then
			--		ws2812_addr <= "10000000000000001"; -- 65537
			--	elsif tmp_addr_cnt < 65792 then
			--		ws2812_addr <= std_logic_vector(to_unsigned(tmp_addr_cnt+1, 17));
			--	end if;
			--	if tmp_addr_cnt > 65536 then
			--		if ram_dout = "11111111" then
			--			buff(tmp_addr_cnt-65537) <= '1';
			--		else
			--			buff(tmp_addr_cnt-65537) <= '0';
			--		end if;
			--	end if;
			--	if tmp_addr_cnt < 65792 then
			--		tmp_addr_cnt <= tmp_addr_cnt + 1;
			--	else
			--		for k in 0 to buff'length-1 loop
						--frame_buf(((k+1)*24)-1 downto (((k+1)*24)-1)-23) <= (others => buff(k));
			--			frame_buf((6143-(k*24)) downto ((6143-(k*24))-23)) <= (others => buff(k));
			--		end loop;
					
					
					--ws_enable <= '1';
			--		tmp_addr_cnt <= 65536;
			--	end if;
			--end if;
		end if;
		if wr_boot = '1' then
			bootl_wr <= '0';
			bootl_rd <= '1';
			bootl_ioreq <= '1';
			bootl_mreq <= '0';
		elsif wr_boot = '0' then
			bootl_wr <= '1';
			bootl_rd <= '0';
			bootl_ioreq <= '1';
			bootl_mreq <= '0';
		end if;
	end if;

end process;

ram_addr <= bootl_addr when (rst = '0') else
				z80_addr when (rst = '1');-- and ws_ready = '0'); else
				--ws2812_addr when (rst = '1' and ws_ready = '1');
		
ram_mreq_n <= bootl_mreq when (rst = '0') else
				  z80_mreq when (rst = '1');-- and ws_ready = '0') else
				  --'0' when (rst = '1' and ws_ready = '1');

ram_ioreq_n <= bootl_ioreq when (rst = '0') else
					z80_ioreq when (rst = '1'); --and ws_ready = '0') else
					--'1' when (rst = '1' and ws_ready = '1');
					
ram_wr_n <= bootl_wr when (rst = '0') else
				'1' when (rst = '1' and z80_addr(14 downto 0) = "000001000010000") else -- (0x210)
				'1' when (rst = '1' and z80_addr(14 downto 0) = "000001000010001") else -- (0x211)
				'1' when (rst = '1' and z80_addr(14 downto 0) = "000001000010010") else -- (0x212)
				'1' when (rst = '1' and z80_addr(14 downto 0) = "000001000010011") else -- (0x213)
				'1' when (rst = '1' and z80_addr(14 downto 0) = "000001000010100") else -- (0x214)
				'1' when (rst = '1' and z80_addr(14 downto 0) = "000001000010101") else -- (0x215)
				'1' when (rst = '1' and z80_addr(14 downto 0) = "000001000010110") else -- (0x216)
				'1' when (rst = '1' and z80_addr(14 downto 0) = "000001000010111") else -- (0x217)
				z80_wr when (rst = '1');-- and ws_ready = '0') else
				--'1' when (rst = '1' and ws_ready = '1');
				
ram_rd_n <= bootl_rd when (rst = '0') else
				z80_rd when (rst = '1');-- and ws_ready = '0') else
				--'0' when (rst = '1' and ws_ready = '1');
		
ram_din <= bootl_datin when(rst = '0') else
			  z80_do;


process(ram_dout, rst, z80_ioreq)--, ws_ready)
begin
	if rst = '1' and z80_ioreq = '1' then -- and ws_ready = '0' then
		z80_din <= ram_dout;
	elsif rst = '1' and z80_ioreq = '0' and z80_addr(14 downto 0) = "000000011111111" then
		z80_din <= joystick1_reg;
	elsif rst = '1' and z80_ioreq = '0' then
		z80_din <= "00000000";
	--elsif rst = '1' and z80_ioreq = '1' then and ws_ready = '1' then
	--	ws2812_din <= ram_dout;
	else
		bootl_datout <= ram_dout;
	end if;
end process;

end architecture;