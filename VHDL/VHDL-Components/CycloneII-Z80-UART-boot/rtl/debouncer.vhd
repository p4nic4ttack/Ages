library ieee;
use ieee.std_logic_1164.all;

entity debouncer is
    port (
        button: in std_logic;
        clk: in std_logic;
        debounced_button: out std_logic
    );
end entity;

architecture rtl of debouncer is
    signal button_sync: std_logic;
    signal button_sync2: std_logic;
begin
    process (clk)
    begin
        if rising_edge(clk) then
            -- First flip-flop
            button_sync <= not button;

            -- Second flip-flop
            button_sync2 <= button_sync;

            -- Output the debounced button value
            debounced_button <= not button_sync and button_sync2;
        end if;
    end process;
end architecture;