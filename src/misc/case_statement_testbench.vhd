-- https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity case_statement_testbench is
end entity;

architecture testbench of case_statement_testbench is
  component case_statement
	port (
	  bit0: in std_logic;
	  bit1: in std_logic;
	  bit2: in std_logic;
	  bit3: in std_logic;
	  cout: out std_logic_vector (3 downto  0)
	);

  end component;

  signal  bit0:    std_logic;
  signal  bit1:    std_logic;
  signal  bit2:    std_logic;
  signal  bit3:    std_logic;
  signal  cout:    std_logic_vector (3 downto  0);

begin
  dut: case_statement port map (
                            bit0=>bit0, 
                            bit1=>bit1, 
                            bit2=>bit2, 
                            bit3=>bit3, 
			    cout=>cout
		    );



  process
  begin
    bit0 <= '0';
    bit1 <= '0';
    bit2 <= '0';
    bit3 <= '0';
    wait for 10 ns;
    bit0 <= '0';
    bit1 <= '0';
    bit2 <= '0';
    bit3 <= '1';
    wait for 10 ns;
    bit0 <= '0';
    bit1 <= '0';
    bit2 <= '1';
    bit3 <= '0';
    wait for 10 ns;
    bit0 <= '0';
    bit1 <= '0';
    bit2 <= '1';
    bit3 <= '1';
    wait for 10 ns;
    bit0 <= '1';
    bit1 <= '1';
    bit2 <= '0';
    bit3 <= '0';
    wait for 10 ns;
    bit0 <= '1';
    bit1 <= '0';
    bit2 <= '0';
    bit3 <= '0';
    wait for 10 ns;
    wait;

  end process;
end;

