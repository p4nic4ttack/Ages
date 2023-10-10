library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_tx is
port(
	clk		: in std_logic;
	nRst		: in std_logic;
	bd_clk	: in std_logic;
	tx_start	: in std_logic := '0';
	stopbit	: in boolean;
	tx_data	: in std_logic_vector(7 downto 0);
	tx_busy	: out std_logic := '1'; -- actief hoog
	tx_pin	: out std_logic := '1'
);
end uart_tx;

architecture rtl of uart_tx is
type state is (IDLE, SEND_DATA, STOP);
signal fsm			: state := IDLE;
signal data_len	: natural := 0;
signal stop_len	: natural := 2;
signal started		: boolean := false;
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if tx_start = '1' then
				started <= true;
			end if;
			
			if nRst = '0' then
				fsm <= IDLE;
				data_len <= 8;
				tx_busy <= '1';
			end if;
			
			if bd_clk = '1' then
				case fsm is
					when IDLE =>
						tx_pin <= '1';
						tx_busy <= '1';
						if started = true then
							started <= false;
							tx_pin <= '0'; -- Sending start bit
							tx_busy <= '0';
							fsm <= SEND_DATA;
						end if;
					when SEND_DATA =>
						if data_len < 8 then
							tx_pin <= tx_data(data_len);
							data_len <= data_len + 1;
						else
							tx_pin <= '1';
							fsm <= STOP;
						end if;
						
					when STOP =>
						tx_pin <= '1';
						if stopbit = false then
							data_len <= 0;
							fsm <= IDLE;
						else
							if stop_len = 0 then
								data_len <= 0;
								fsm <= IDLE;
							else
								stop_len <= stop_len-1;
							end if;
						end if;
				end case;
			end if;
		end if;
	end process;
end rtl;

