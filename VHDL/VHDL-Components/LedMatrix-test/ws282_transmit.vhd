library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.ALL;


entity ws282_transmit is
generic(
	amount_leds : natural := 1;
	rgb_len		: integer := 24
);
port(
	rgb		: in std_logic_vector((rgb_len*amount_leds)-1 downto 0) := (others => '1');--"111111111111111111111111";
	clk		: in std_logic;
	enable	: in std_logic := '1';
	tx_ready	: out std_logic := '1';
	data_out	: out std_logic := '0'
);
end ws282_transmit;

architecture rtl of ws282_transmit is

type state is (IDLE, INIT_TX, TX_HIGH, TX_LOW, RESET);
signal fsm			: state := IDLE;
constant T0H		: natural := (350 * 100 / 1000)-1;
constant T0L		: natural := (900 * 100 / 1000)-2;
constant T1H		: natural := (760 * 100 / 1000)-1;
constant T1L		: natural := (500 * 100 / 1000)-2;
constant RST_TIME	: natural := 550000 * 100;
signal rst_cnt		: natural := RST_TIME;
signal len			: natural := (rgb_len*amount_leds)-1;
signal count		: unsigned(15 downto 0) := (others => '0');
signal ready		: std_logic := '1';


begin

	process(clk)
	begin
		if rising_edge(clk) then
			case fsm is
				when IDLE =>
					data_out <= '0';
					if ready = '1' and enable = '1' then
						ready <= '0';
						fsm <= INIT_TX;
					end if;
				
				when INIT_TX =>
					data_out <= '1';
					if rgb(len) = '1' then
						count <= to_unsigned(T1H, count'length);
						
					elsif rgb(len) = '0' then
						count <= to_unsigned(T0H, count'length);
					end if;
					fsm <= TX_HIGH;
					
				when TX_HIGH =>
					if count = 0 then
						if rgb(len) = '1' then
							count <= to_unsigned(T1L, count'length);
						else
							count <= to_unsigned(T0L, count'length);
						end if;
						data_out <= '0';
						fsm <= TX_LOW;
					else
						count <= count-1;
						data_out <= '1';
					end if;
					
				when TX_LOW =>
					if count = 0 then
						len <= len-1;
						data_out <= '0';
						if len /= 0 then
							fsm <= INIT_TX;
						else	
							fsm <= RESET;
						end if;
					else
						count <= count-1;
						data_out <= '0';
					end if;
					
				when RESET =>
					if rst_cnt = 0 then
						rst_cnt <= RST_TIME;
						--len <= (rgb_len-1)*amount_leds;
						len <= (rgb_len*amount_leds)-1;
						ready <= '1';
						--if enable = '0' then
							fsm <= IDLE;
						--else
						--	fsm <= INIT_TX;
						--end if;
					else
						len <= (rgb_len*amount_leds)-1;
						rst_cnt <= rst_cnt - 1;
						data_out <= '0';
					end if;
				when others =>
					data_out <= '0';
			end case;
		end if;
	end process;
	tx_ready <= ready;
end rtl;

