-- n bit ripple carry Adder Testbench
--https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use Work.n_bitadder_package.all;

entity n_bitadder_testbench is
end entity;

architecture testbench of n_bitadder_testbench is
  component n_bitadder
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
                sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
                c_out, v: out std_logic);

  end component;

  signal  a,b:    std_logic_vector (BUS_WIDTH-1 downto 0);
  signal  c_in: std_logic;
  signal  sum:  std_logic_vector (BUS_WIDTH-1 downto 0);
  signal  c_out,v:   std_logic;

begin
  dut: n_bitadder port map (
                            a=>a, 
			    b=>b, 
			    c_in=>c_in,
                            sum=>sum, 
			    c_out=>c_out,
                            v=>v
		    );
  process
  begin
    a <= x"FFFF0000";
    b <= x"1000FFFF";
    c_in <= '0';
    wait for 10 ns;
    a <= x"00000000";
    b <= x"1000FFFF";
    c_in <= '0';
    wait for 10 ns;

    wait;
  end process;
end;

