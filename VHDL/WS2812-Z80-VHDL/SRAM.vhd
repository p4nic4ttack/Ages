library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SRAM is
port(
	clk			: in std_logic;
	address_in	: in std_logic_vector(16 downto 0);
	data_in		: in std_logic_vector(7 downto 0);
	data_out		: out std_logic_vector(7 downto 0);
	mreq_n		: in std_logic;
	ioreq_n		: in std_logic;
	rd_n			: in std_logic;
	wr_n			: in std_logic;
	
	addr_out		: out std_logic_vector(16 downto 0);
	ce_n			: out std_logic;
	ce				: out std_logic;
	we_n			: out std_logic;
	oe_n			: out std_logic;
	dq				: inout std_logic_vector(7 downto 0)
);
end SRAM;

architecture rtl of SRAM is
	type sram_state is (S_IDLE, S_WRITE, S_READ);
	signal fsm : sram_state := S_IDLE;
	signal wea : std_logic;
	signal mem_rd : std_logic;
	signal mem_wr : std_logic;
	signal ram_rd : std_logic;
	signal down_clk : std_logic;
begin

mem_rd <= '1' when (mreq_n = '0' and ioreq_n = '1' and rd_n = '0') else '0';
mem_wr <= '1' when (mreq_n = '0' and ioreq_n = '1' and wr_n = '0') else '0';
ram_rd <= '1' when (mem_rd = '1') else '0';
wea <= '1' when (mem_wr = '1') else '0';

ce_n <= '0';
ce <= '1';
oe_n <= '1' when (wea = '1') else '0';
we_n <= '1' when (wea = '0') else '0';
dq <= data_in when (wea = '1') else (others => 'Z');
data_out <= dq when (wea = '0') else (others => '0');

addr_out <= address_in;
end rtl;