-- 4 bit carry save Adder Testbench
--https://github.com/enthusiasticgeek/vhdl_opecarry_save_4_cores


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.carry_save_4_bitadder_package.all;

entity carry_save_4_bitadder_testbench is
end entity;

architecture testbench of carry_save_4_bitadder_testbench is
 component carry_save_4_bitadder is
     port (a, b, c_in: in std_logic_vector(BUS_WIDTH-1 downto 0);
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           sum: out std_logic_vector (BUS_WIDTH downto 0);
           c_out: out std_logic);
 end component;


  signal  clk: std_logic;
  signal  n_rst: std_logic;
  signal  a,b,c_in:  std_logic_vector (BUS_WIDTH-1 downto 0);
  signal  sum:  std_logic_vector (BUS_WIDTH downto 0);
  signal  c_out: std_logic;

begin
  dut: carry_save_4_bitadder port map (
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

    a <= "1110";
    b <= "0101";
    c_in <= "0111";

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    -- addition
    a <= x"F";
    b <= x"F";
    c_in <= x"F";
    wait for 10 ns;

    wait;
  end process;
end;
