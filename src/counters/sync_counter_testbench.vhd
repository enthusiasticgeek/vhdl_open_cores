-- 32-bit Up/Down Counter Custom Testbench
-- https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sync_counter_testbench is
end entity;

architecture testbench of sync_counter_testbench is
  component sync_counter
    port(
      clk:    in  std_logic;
      n_rst:  in  std_logic;
      cnt_stop: in std_logic;
      is_up: in std_logic;
      load_enable: in std_logic;
      load_data: in std_logic_vector(31 downto 0);
      cout:   out std_logic_vector (31 downto 0);
      overflow, underflow:   out std_logic
    );
  end component;

  signal  clk:    std_logic;
  signal  n_rst:  std_logic;
  signal  cnt_stop:  std_logic;
  signal  is_up:  std_logic;
  signal  load_enable:  std_logic;
  signal  load_data:   std_logic_vector (31 downto 0);
  signal  cout:   std_logic_vector (31 downto 0);
  signal  overflow, underflow:   std_logic;

begin
  dut: sync_counter port map (
                            clk=>clk, 
			    n_rst=>n_rst, 
			    cnt_stop=>cnt_stop, 
			    is_up=>is_up, 
			    load_enable=>load_enable, 
			    load_data=>load_data, 
			    cout=>cout,
			    overflow=>overflow,
			    underflow=>underflow
		    );

  process
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;

  process
  begin
    n_rst <= '0';
    cnt_stop <= '0';
    --is_up <= '0';
    is_up <= '1';
    --start counting from this value
    --load_data <= std_logic_vector'( x"0000FFFF");
    --load_data <= std_logic_vector'( x"00000003");   -- check underflow condition
    load_data <= std_logic_vector'( x"FFFFFFFA");     -- check overflow condition
    load_enable <= '0';
    wait for 10 ns;
    n_rst <= '1';
    load_enable <= '1';
    wait for 10 ns;
    load_enable <= '0';
    wait for 100 ns;
    cnt_stop <= '1';
    wait for 250 ns;
    wait;
  end process;
end;

