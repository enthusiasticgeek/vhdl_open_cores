-- 8 bit kogge stone Adder Testbench
--https://github.com/enthusiasticgeek/vhdl_opecarry_lookahead_n_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use Work.kogge_stone_adder_package.all;

entity kogge_stone_adder_testbench is
end entity;

architecture testbench of kogge_stone_adder_testbench is

component kogge_stone_adder is
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
           c_out: out std_logic);
end component;

  signal  a,b:  std_logic_vector (BUS_WIDTH-1 downto 0) := (others=>'0');
  signal  clk: std_logic;
  signal  n_rst: std_logic;
  signal  c_in: std_logic;
  signal  sum:  std_logic_vector (BUS_WIDTH-1 downto 0);
  signal  c_out: std_logic;

begin
  dut: kogge_stone_adder port map (
                            n_rst=>n_rst, 
                            clk=>clk, 
                            a=>a, 
			    b=>b, 
			    c_in=>c_in,
                            sum=>sum, 
			    c_out=>c_out
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
    wait for 10 ns;

    -- addition
    a <= x"01";
    b <= x"01";
    c_in <= '0';

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    -- addition
    a <= x"10";
    b <= x"0F";
    c_in <= '0';

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    -- addition
    a <= x"11";
    b <= x"FF";
    c_in <= '0';

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    wait;
  end process;
end;
