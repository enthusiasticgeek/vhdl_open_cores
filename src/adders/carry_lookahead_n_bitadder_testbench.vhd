-- n bit ripple carry Adder Testbench
--https://github.com/enthusiasticgeek/vhdl_opecarry_lookahead_n_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use Work.carry_lookahead_n_bitadder_package.all;

entity carry_lookahead_n_bitadder_testbench is
end entity;

architecture testbench of carry_lookahead_n_bitadder_testbench is
  component carry_lookahead_n_bitadder
     port (g, p: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
	  clk:    in  std_logic;
	  n_rst:  in  std_logic;
                sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
                z, n: out std_logic;
                c_out, v: out std_logic);

  end component;

  signal  p,g:  std_logic_vector (BUS_WIDTH-1 downto 0) := (others=>'0');
  signal  clk: std_logic;
  signal  n_rst: std_logic;
  signal  c_in: std_logic;
  signal  sum:  std_logic_vector (BUS_WIDTH-1 downto 0);
  signal  z, n: std_logic;
  signal  c_out,v: std_logic;

begin
  dut: carry_lookahead_n_bitadder port map (
                            n_rst=>n_rst, 
                            clk=>clk, 
                            g=>g, 
			    p=>p, 
			    c_in=>c_in,
                            sum=>sum, 
                            z=>z,
                            n=>n,
			    c_out=>c_out,
                            v=>v
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
    p <= x"0100";
    g <= x"10FF";
    c_in <= '0';

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    -- addition
    p <= x"FF00";
    g <= x"11FF";
    c_in <= '0';

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    -- addition
    p <= x"FFFF";
    g <= x"FF00";
    c_in <= '0';

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;



    wait for 10 ns;

    wait;
  end process;
end;
