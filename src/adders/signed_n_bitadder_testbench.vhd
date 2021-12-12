-- n bit ripple carry Adder Testbench
--https://github.com/enthusiasticgeek/vhdl_opesigned_n_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use Work.signed_n_bitadder_package.all;

entity signed_n_bitadder_testbench is
end entity;

architecture testbench of signed_n_bitadder_testbench is
  component signed_n_bitadder
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
	  clk:    in  std_logic;
	  n_rst:  in  std_logic;
                sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
                z, n: out std_logic;
                c_out, v: out std_logic);

  end component;

  signal  clk: std_logic;
  signal  n_rst: std_logic;
  signal  a,b:  std_logic_vector (BUS_WIDTH-1 downto 0);
  signal  c_in: std_logic;
  signal  sum:  std_logic_vector (BUS_WIDTH-1 downto 0);
  signal  z, n: std_logic;
  signal  c_out,v: std_logic;

begin
  dut: signed_n_bitadder port map (
                            n_rst=>n_rst, 
                            clk=>clk, 
                            a=>a, 
			    b=>b, 
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
    a <= x"00000000";
    b <= x"00000000";
    c_in <= '0';

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    -- addition
    a <= x"FFFF0000";
    b <= x"1000FFFF";
    c_in <= '0';
    wait for 10 ns;
    -- addition
    a <= x"01000000";
    b <= x"1000FFFF";
    c_in <= '0';
    wait for 10 ns;
    -- addition
    a <= x"00000000";
    b <= x"00000000";
    c_in <= '0';
    wait for 10 ns;
    -- addition
    a <= x"FFFFFFFF";
    b <= x"FFFFFFFF";
    c_in <= '1';
    wait for 10 ns;
    -- subtraction
    a <= x"FFFFFFFF";
    b <= x"00000001"; -- b is 2's complement of a
    c_in <= '0';
    wait for 10 ns;
    -- subtraction
    a <= x"000000FF";
    b <= x"FFFFFF01"; -- b is 2's complement of a
    c_in <= '0';
    wait for 10 ns;
    wait;
  end process;
end;
