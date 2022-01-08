-- nxn array multiplier Testbench
--https://github.com/enthusiasticgeek/vhdl_opecarry_lookahead_4_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use Work.nxn_array_multiplier_package.all;

entity nxn_array_multiplier_testbench is
end entity;

architecture testbench of nxn_array_multiplier_testbench is
  component nxn_array_multiplier is
     port (a, x: in std_logic_vector(BUS_WIDTH-1 downto 0);
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           p: out std_logic_vector (2*BUS_WIDTH-1 downto 0));
  end component;

  signal  a, x:  std_logic_vector (BUS_WIDTH-1 downto 0) := (others=>'0');
  signal  clk: std_logic;
  signal  n_rst: std_logic;
  signal  p:  std_logic_vector (2*BUS_WIDTH-1 downto 0) := (others=>'0');

begin
  dut: nxn_array_multiplier port map (
                            a=>a, 
			    x=>x, 
			    clk=>clk,
                            n_rst=>n_rst, 
                            p=>p
		    );

  -- we explicitly obtain generate and propogate signals from the a,b values

  process
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;


  process
  begin
    a <= "00000";
    x <= "00000";

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    -- multiply
    a <= "10101";
    x <= "10000";
    wait for 10 ns;
    wait;
  end process;
end;
