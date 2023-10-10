library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;  -- nodig voor std_logic te lezen en schrijven (bestand)
use ieee.numeric_std.ALL;       -- voor omzetting to_integer

entity sram_tb is
end sram_tb;

architecture behavioral of sram_tb is
	signal clk			: std_logic := '0';
	signal address_in	: std_logic_vector(14 downto 0);
	signal data_in		: std_logic_vector(7 downto 0);
	signal mreq_n		: std_logic;
	signal ioreq_n		: std_logic;
	signal rd_n			: std_logic;
	signal wr_n			: std_logic;
	
	-- RAM communication lines
	signal address_out: std_logic_vector(14 downto 0);
	signal ce1_n		: std_logic;
	signal ce2			: std_logic;
	signal we_n			: std_logic;
	signal oe_n			: std_logic;
	signal dq			: std_logic_vector(7 downto 0);
	
	signal data_out	: std_logic_vector(7 downto 0);
	signal sim			: boolean := true;
	file in_buf 		: text;
begin

mclk : process
begin
	while sim = true loop
		clk <= not clk;
		wait for 42ns;
	end loop;
	wait;
end process;

DUT : entity work.sram(rtl)
port map(
	clk => clk,
	address_in => address_in,
	data_in => data_in,
	mreq_n => mreq_n,
	ioreq_n => ioreq_n,
	rd_n => rd_n,
	wr_n => wr_n,
	addr_out => address_out,
	ce_n => ce1_n,
	ce => ce2,
	we_n => we_n,
	oe_n => oe_n,
	dq => dq,
	data_out => data_out
);

stimuli : process
	variable val_col1 : std_logic_vector(14 downto 0);
	variable val_col2 : std_logic_vector(7 downto 0);
	variable val_col3, val_col4, val_col5, val_col6 : std_logic;
	variable val_space: character;
	variable linenumber : integer;
	variable ok : boolean;
	variable in_line : line;
begin
	file_open(in_buf, "test_vector.txt", read_mode);
	linenumber := 0;
	while not endfile(in_buf) loop
		readline(in_buf, in_line);
		read(in_line, val_col1, ok);
		if ok = true then
			read(in_line, val_space);
			read(in_line, val_col2);
			read(in_line, val_space);
			read(in_line, val_col3);
			read(in_line, val_space);
			read(in_line, val_col4);
			read(in_line, val_space);
			read(in_line, val_col5);
			read(in_line, val_space);
			read(in_line, val_col6);
			address_in <= val_col1;
			data_in <= val_col2;
			mreq_n <= val_col3;
			ioreq_n <= val_col4;
			rd_n <= val_col5;
			wr_n <= val_col6;
			
			wait for 84ns;
			
			
		end if;
		linenumber := linenumber + 1;
	end loop;
	
	file_close(in_buf);
	sim <= false;
	wait;
	

	
end process;

end behavioral;