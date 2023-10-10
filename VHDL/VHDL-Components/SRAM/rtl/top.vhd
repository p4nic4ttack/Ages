library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
port(
	CLK_100MHz	: in std_logic;
	--LED			: out std_logic;
	
	addr			: out std_logic_vector(14 downto 0); -- P6 & P8
	dq				: inout std_logic_vector(7 downto 0); -- P9
	ce_n			: out std_logic; -- P7.1
	ce				: out std_logic; -- P7.2
	we_n			: out std_logic; -- P7.3
	oe_n			: out std_logic; -- P7.4
	
	tx_data		: out std_logic; -- P7.5
	tx_busy		: out std_logic;  -- P7.6
	
	sw1			: in std_logic;
	sw2			: in std_logic
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
	signal writing : boolean := true;
	signal cnt		: natural := 3;
	
	signal tx_start: std_logic := '0';
begin
pll_x : entity work.PLL
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
addr_in <= "000000000000000";

process(ram_clk)
begin

if rising_edge(ram_clk) then
	if sw1 = '0' and sw2 = '1' then
		data_in <= "00100001";
		mreq_n <= '0';
		ioreq_n <= '1';
		wr_n <= '0';
		rd_n <= '1';
		tx_start <= '0';
	elsif sw1 = '1' and sw2 = '1' then
		data_in <= (others => '0');
		mreq_n <= '1';
		ioreq_n <= '1';
		wr_n <= '1';
		rd_n <= '1';
		tx_start <= '0';
	elsif sw1 = '1' and sw2 = '0' then
		mreq_n <= '0';
		ioreq_n <= '1';
		wr_n <= '1';
		rd_n <= '0';
		tx_start <= '1';
	end if;
end if;

end process;

end structural;

