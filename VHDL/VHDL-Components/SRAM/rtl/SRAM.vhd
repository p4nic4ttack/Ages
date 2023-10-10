library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SRAM is
port(
	clk			: in std_logic;
	address_in	: in std_logic_vector(14 downto 0);
	data_in		: in std_logic_vector(7 downto 0);
	data_out		: out std_logic_vector(7 downto 0);
	mreq_n		: in std_logic;
	ioreq_n		: in std_logic;
	rd_n			: in std_logic;
	wr_n			: in std_logic;
	
	addr_out		: out std_logic_vector(14 downto 0);
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
	
begin
process (clk)
begin
	if rising_edge(clk) then
		case fsm is
			when S_IDLE =>
				if mreq_n = '0' and ioreq_n = '1' and wr_n = '0' then
					ce_n <= '0';
					ce <= '1';
					oe_n <= '1';
					we_n <= '0';
					dq <= data_in;
					fsm <= S_WRITE;
				elsif mreq_n = '0' and ioreq_n = '1' and rd_n = '0' then
					ce_n <= '0';
					ce <= '1';
					oe_n <= '0';
					we_n <= '1';
					dq <= (others => 'Z');
					data_out <= dq;
					fsm <= S_READ;
				end if;
				
			when S_WRITE =>
				ce_n <= '1';
				ce <= '0';
				oe_n <= '0';
				we_n <= '0';
				fsm <= S_IDLE;
			
			when S_READ =>
				ce_n <= '1';
				ce <= '0';
				oe_n <= '0';
				we_n <= '0';
				fsm <= S_IDLE;
				
		end case;
	end if;
end process;
addr_out <= address_in;
end rtl;

