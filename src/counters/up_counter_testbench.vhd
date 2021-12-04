-- 64-bit Up Counter Testbench
--https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity up_counter_testbench is
end entity;

architecture testbench of up_counter_testbench is
  component up_counter
    port(
      clk:    in  std_logic;
      n_rst:  in  std_logic;
      cout:   out std_logic_vector (63 downto 0)
    );
  end component;

  signal  clk:    std_logic;
  signal  n_rst:  std_logic;
  signal  cout:   std_logic_vector (63 downto 0);

begin
  dut: up_counter port map (
                            clk=>clk, 
			    n_rst=>n_rst, 
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
    wait for 10 ns;
    n_rst <= '1';
    wait for 250 ns;
    wait;
  end process;
end;

