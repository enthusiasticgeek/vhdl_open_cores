--  full Adder Testbench
--https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fulladder_testbench is
end entity;

architecture testbench of fulladder_testbench is
  component fulladder
     port (a, b, c: in std_logic;
           sum, carry: out std_logic);
  end component;

  signal  a,b,c:    std_logic;
  signal  carry: std_logic;
  signal  sum: std_logic;

begin
  dut: fulladder port map (
                            a=>a, 
			    b=>b, 
			    c=>c, 
			    carry=>carry,
                            sum=>sum 
		    );
  process
  begin
    a <= '0';
    b <= '0';
    c <= '0';
    wait for 10 ns;
    a <= '0';
    b <= '0';
    c <= '1';
    wait for 10 ns;
    a <= '0';
    b <= '1';
    c <= '1';
    wait for 10 ns;
    a <= '1';
    b <= '0';
    c <= '1';
    wait for 10 ns;
    a <= '1';
    b <= '1';
    c <= '1';
    wait for 10 ns;
    wait;
  end process;
end;

