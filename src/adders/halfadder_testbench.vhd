-- n bit ripple carry Adder Testbench
--https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity halfadder_testbench is
end entity;

architecture testbench of halfadder_testbench is
  component halfadder
       port (x,y: in std_logic;
           carry : out std_logic;
                sum: out std_logic);

  end component;

  signal  x,y:    std_logic;
  signal  carry: std_logic;
  signal  sum: std_logic;

begin
  dut: halfadder port map (
                            x=>x, 
			    y=>y, 
			    carry=>carry,
                            sum=>sum 
		    );
  process
  begin
    x <= '0';
    y <= '0';
    wait for 10 ns;
    x <= '0';
    y <= '1';
    wait for 10 ns;
    x <= '1';
    y <= '0';
    wait for 10 ns;
    x <= '1';
    y <= '1';
    wait for 10 ns;
    wait;
  end process;
end;

