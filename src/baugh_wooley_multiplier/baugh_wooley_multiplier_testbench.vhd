-- nxn array multiplier Testbench
--https://github.com/enthusiasticgeek/vhdl_opecarry_lookahead_4_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use Work.baugh_wooley_multiplier_package.all;

entity baugh_wooley_multiplier_testbench is
end entity;

architecture testbench of baugh_wooley_multiplier_testbench is
  component baugh_wooley_multiplier is
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           p: out std_logic_vector (2*BUS_WIDTH-1 downto 0));
  end component;

  signal  a, b:  std_logic_vector (BUS_WIDTH-1 downto 0) := (others=>'0');
  signal  clk: std_logic;
  signal  n_rst: std_logic;
  signal  p:  std_logic_vector (2*BUS_WIDTH-1 downto 0) := (others=>'0');

begin
  dut: baugh_wooley_multiplier port map (
                            a=>a, 
			    b=>b, 
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
    a <= "0000";
    b <= "0000";

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    -- multiply
    a <= "0100";
    b <= "0010";
    wait for 10 ns;

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    -- multiply
    a <= "0111";
    b <= "1111";
    wait for 10 ns;


    wait;
  end process;
end;
