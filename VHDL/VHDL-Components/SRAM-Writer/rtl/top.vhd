library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity top is
port(
	CLK_100MHz	: in std_logic;
	
	addr			: out std_logic_vector(14 downto 0); -- P6 & P8
	dq				: inout std_logic_vector(7 downto 0); -- P9
	ce_n			: out std_logic; -- P7.1
	ce				: out std_logic; -- P7.2
	we_n			: out std_logic; -- P7.3
	oe_n			: out std_logic; -- P7.4
	
	tx_data		: out std_logic; -- P7.5
	tx_busy		: out std_logic;  -- P7.6
	
	sw1			: in std_logic;
	sw2			: in std_logic;
	DPSwitch	: in std_logic_vector(7 downto 0)
);
end top;

architecture structural of top is
	signal bd_clk	: std_logic;
	signal addr_in	: std_logic_vector(14 downto 0);
	signal data_in	: std_logic_vector(7 downto 0);
	signal data_out: std_logic_vector(7 downto 0);
	signal mreq_n	: std_logic;
	signal ioreq_n	: std_logic;
	signal rd_n		: std_logic;
	signal wr_n		: std_logic;
	
	signal ram_clk : std_logic;
	signal wr_done : boolean := false;
	signal byte_cnt: natural := 20;
	--signal bytes	: std_logic_vector(159 downto 0) := "0011111000000001001100101111000100000000000001100101000000010000111111100011111000000000001100101111000100000000000001100101000000010000111111101100001100000000";
	signal bytes	: std_logic_vector(159 downto 0) := "0100000101000010010000110100010001000101010001100100011101001000010010010100101001001011010011000100110101001110010011110101000001010001010100100101001101010100";
	signal cnt		: natural := 0;
	signal tmp_cnt	: natural := 1;

	signal tx_start: std_logic := '0';
	signal first	: boolean := true;
	--signal tmp_addr: std_logic_vector(14 downto 0) := (others => '0');
begin
pll : entity work.PLL(xilinx)
port map(
	CLK_IN1 => CLK_100MHz,
	CLK_OUT1 => ram_clk
);

clock_en : entity work.clock_en_generic(rtl)
generic map(
	clk_freq => 12e6,
	req_freq => 115200.0
)
port map(
	clk => ram_clk,
	chip_en => bd_clk
);

sram : entity work.sram(rtl)
port map(
	clk => ram_clk,
	address_in => addr_in,
	data_in => data_in,
	data_out=> data_out,
	mreq_n => mreq_n,
	ioreq_n=> ioreq_n,
	rd_n => rd_n,
	wr_n => wr_n,
	
	addr_out => addr,
	ce_n => ce_n,
	ce => ce,
	we_n => we_n,
	oe_n => oe_n,
	dq => dq
);

uart : entity work.uart_tx(rtl)
port map(
	clk => ram_clk,
	nRst => '1',
	bd_clk => bd_clk,
	tx_start => tx_start,
	stopbit => false,
	tx_data => data_out,
	tx_busy => tx_busy,
	tx_pin => tx_data
);

--addr_in(7 downto 0) <= DPSwitch;
process(ram_clk)
begin

if  rising_edge(ram_clk) then
	if sw1 = '0' and sw2 = '1' then
		if byte_cnt > 0 then
			
			if first = false and tmp_cnt = 0 then
				data_in <= bytes(((byte_cnt-1)*8)+7 downto (byte_cnt-1)*8);
				if cnt = 0 then
					addr_in <= (others => '0');
				else
					addr_in <=  std_logic_vector(to_unsigned(cnt, 15));
				end if;
				mreq_n <= '0';
				ioreq_n <= '1';
				wr_n <= '0';
				rd_n <= '1';
				cnt <= cnt + 1;
				byte_cnt <= byte_cnt - 1;
				tmp_cnt <= 1;
			elsif first = false and tmp_cnt > 0 then
				tmp_cnt <= tmp_cnt - 1;
			else
				first <= false;
			end if;
		end if;
	elsif sw1 = '1' and sw2 = '1' then
		addr_in <= (others => '0');
		data_in <= (others => '0');
		mreq_n <= '1';
		ioreq_n <= '1';
		wr_n <= '1';
		rd_n <= '1';
		tx_start <= '0';
	elsif sw1 = '1' and sw2 = '0' then
		addr_in(7 downto 0) <= DPSwitch;
		mreq_n <= '0';
		ioreq_n <= '1';
		wr_n <= '1';
		rd_n <= '0';
		tx_start <= '1';
	end if;
end if;

end process;

end structural;

