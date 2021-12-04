-- 64-bit Up Counter Custom Testbench
-- https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity up_counter_custom_testbench is
end entity;

architecture testbench of up_counter_custom_testbench is
  component up_counter_custom
    port(
      clk:    in  std_logic;
      n_rst:  in  std_logic;
      cnt_stop: in std_logic;
      load_enable: in std_logic;
      load_data: in std_logic_vector(63 downto 0);
      cout:   out std_logic_vector (63 downto 0)
    );
  end component;

  signal  clk:    std_logic;
  signal  n_rst:  std_logic;
  signal  cnt_stop:  std_logic;
  signal  load_enable:  std_logic;
  signal  load_data:   std_logic_vector (63 downto 0);
  signal  cout:   std_logic_vector (63 downto 0);

begin
  dut: up_counter_custom port map (
                            clk=>clk, 
			    n_rst=>n_rst, 
			    cnt_stop=>cnt_stop, 
			    load_enable=>load_enable, 
			    load_data=>load_data, 
			    cout=>cout
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
    --start counting from this value
    load_data <= x"00000000FFFFFFFF";
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

