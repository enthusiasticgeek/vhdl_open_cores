-- n bit ripple carry Adder Testbench
--https://github.com/enthusiasticgeek/vhdl_opecarry_select_4_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use Work.carry_select_4_bitadder_package.all;

entity carry_select_4_bitadder_testbench is
end entity;

architecture testbench of carry_select_4_bitadder_testbench is
  component carry_select_4_bitadder
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
           sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
           c_out: out std_logic);

  end component;

  signal  a,b:  std_logic_vector (BUS_WIDTH-1 downto 0) := (others=>'0');
  signal  c_in: std_logic;
  signal  sum:  std_logic_vector (BUS_WIDTH-1 downto 0) := (others=>'0');
  signal  c_out: std_logic;

begin
  dut: carry_select_4_bitadder port map (
                            a=>a, 
			    b=>b, 
			    c_in=>c_in,
                            sum=>sum, 
			    c_out=>c_out
		    );

  process
  begin
  -- we explicitly obtain generate and propogate signals from the a,b values

    c_in <= '0';
    a <= x"0";
    b <= x"0";

    -- addition
    c_in <= '0';
    a <= x"1";
    b <= x"1";
    wait for 10 ns;

    -- addition
    c_in <= '0';
    a <= x"3";
    b <= x"4";
    wait for 10 ns;
 
    -- addition
    c_in <= '1';
    a <= x"2";
    b <= x"9";
    wait for 10 ns;

    -- addition
    c_in <= '1';
    a <= x"7";
    b <= x"9";
    wait for 10 ns;



    wait;
  end process;
end;
