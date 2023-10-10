library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity top2 is
port(
	CLK_50MHz	: in std_logic;
	uart_rx		: in std_logic;
	
	addr			: out std_logic_vector(16 downto 0) := (others => '0'); -- P6 & P8
	dq				: inout std_logic_vector(7 downto 0) := (others => '0'); -- P9
	ce_n			: out std_logic; -- P7.1
	ce				: out std_logic; -- P7.2
	we_n			: out std_logic; -- P7.3
	oe_n			: out std_logic; -- P7.4
	

	LED			: out std_logic_vector(7 downto 0) := (others => '0');
	sw1			: in std_logic;
	sw2			: in std_logic

);
end top2;

architecture structural of top2 is
	signal z80_clk		: std_logic;
	signal z80_addr	: std_logic_vector(15 downto 0) := (others => '0');
	signal z80_do		: std_logic_vector(7 downto 0)  := (others => '0');
	signal z80_din		: std_logic_vector(7 downto 0)  := (others => '0');
	signal z80_mreq	: std_logic;
	signal z80_ioreq	: std_logic;
	signal z80_rd		: std_logic;
	signal z80_wr		: std_logic;
	
	signal rst			: std_logic := '0';
	signal tmp_cnt		: natural := 3;
	
	signal busy_rx		: std_logic;
	signal rx_data		: std_logic_vector(7 downto 0) := (others => '0');
	signal addr_cnt	: natural := 0;
	
	signal bootl_addr	: std_logic_vector(15 downto 0) := (others => '0');
	signal bootl_mreq	: std_logic;
	signal bootl_ioreq: std_logic;
	signal bootl_wr	: std_logic;
	signal bootl_rd	: std_logic;
	signal bootl_datin: std_logic_vector(7 downto 0) := (others => '0');
	signal bootl_datout: std_logic_vector(7 downto 0) := (others => '0');
	signal bootl_wea	: std_logic_vector(0 downto 0) := (others => '0');
	
	signal ram_din		: std_logic_vector(7 downto 0) := (others => '0');
	signal ram_addr	: std_logic_vector(15 downto 0) := (others => '0');
	signal ram_dout	: std_logic_vector(7 downto 0) := (others => '0');
	signal ram_mreq_n : std_logic;
	signal ram_ioreq_n: std_logic;
	signal ram_wr_n	: std_logic;
	signal ram_rd_n	: std_logic;
	
	signal sw1_deb		: std_logic := '1';
	signal sw2_deb		: std_logic;
begin



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
	A => z80_addr,
	DI => z80_din,
	DO => z80_do,
	MREQ_n => z80_mreq,
	IORQ_n => z80_ioreq,
	RD_n => z80_rd,
	WR_n => z80_wr,
	WAIT_n => '1',
	INT_n => sw2,
	NMI_n => '1',
	BUSRQ_n => '1'
);


RAM : entity work.SRAM(rtl)
port map(
	clk => z80_clk,
	address_in => ram_addr(14 downto 0),
	mreq_n => ram_mreq_n,
	ioreq_n => ram_ioreq_n,
	rd_n => ram_rd_n,
	wr_n => ram_wr_n,
	data_in => ram_din,
	data_out => ram_dout,
	
   addr_out => addr(14 downto 0),
	ce_n => ce_n,
	ce => ce,
	we_n => we_n,
	oe_n => oe_n,
	dq => dq
);

rx : entity work.uart_rx(rtl)
generic map(
	g_CLKS_PER_BIT => 108
)
port map(
	i_Clk => z80_clk,
	i_RX_Serial => uart_rx,
	o_RX_DV => busy_rx,
	o_RX_Byte => rx_data
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

process(z80_clk)
begin
	
	if rising_edge(z80_clk) then
		if busy_rx = '1' then
			-- If uart rx received data, write to SRAM and increment address counter
			if addr_cnt = 0 then
				bootl_addr <= (others => '0');
			else
				bootl_addr(14 downto 0) <=  std_logic_vector(to_unsigned(addr_cnt, 15));
			end if;
			bootl_datin <= rx_data;
			bootl_rd <= '1';
			bootl_wr <= '0';
			bootl_ioreq <= '1';
			bootl_mreq <= '0';
			addr_cnt <= addr_cnt + 1;
		-- If UART rx is listening for data ans sw3 is pressed, boot Z80 softcore
		elsif busy_rx = '0' and sw1_deb = '1' then
			rst <= '1';
		end if;
		-- When softcore is booted
		if rst = '1' then
			if tmp_cnt = 0 then
				rst <= '1';
			else
				tmp_cnt <= tmp_cnt - 1;
			end if;
			-- Memmap
			if z80_addr(14 downto 0) = "000000010010101" and z80_wr = '0' and z80_do = "00000001" then
				LED(0) <= '1';
			elsif z80_addr(14 downto 0) = "000000010010101"  and z80_wr = '0' and z80_do = "00000000" then
				LED(0) <= '0';
			end if;
		end if;
	end if;
end process;
addr(16 downto 15) <= "00";
ram_addr(14 downto 0) <= bootl_addr(14 downto 0) when (rst = '0') else
								 z80_addr(14 downto 0);
		
ram_mreq_n <= bootl_mreq when (rst = '0') else
				  z80_mreq;

ram_ioreq_n <= bootl_ioreq when (rst = '0') else
					z80_ioreq;
					
ram_wr_n <= bootl_wr when (rst = '0') --else '1' when (rst = '1' and ram_addr(14 downto 0) = "000000010010101")
				else z80_wr;
				
ram_rd_n <= bootl_rd when (rst = '0') else
				z80_rd;
		
ram_din <= bootl_datin when (rst = '0') else
				z80_do;

process(ram_dout, rst, z80_ioreq)
begin
	if rst = '1' and z80_ioreq = '1' then
		z80_din <= ram_dout;
	elsif rst = '1' and z80_ioreq = '0' then
		z80_din <= "10000000";
	elsif rst = '0' then
		bootl_datout <= ram_dout;
	end if;
end process;
--LED(7) <= rst;
end architecture;