-- nxn array multiplier Testbench
--https://github.com/enthusiasticgeek/vhdl_opecarry_lookahead_4_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use Work.n_m_array_divider_package.all;

entity n_m_array_divider_testbench is
end entity;

architecture testbench of n_m_array_divider_testbench is
component n_m_array_divider is
     port (a: in std_logic_vector(2*BUS_WIDTH-1 downto 0);
           b: in std_logic_vector(BUS_WIDTH-1 downto 0);
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           q: out std_logic_vector (2*BUS_WIDTH-1 downto 0);
           r: out std_logic_vector (BUS_WIDTH-1 downto 0));
end component;



  signal  a:  std_logic_vector (2*BUS_WIDTH-1 downto 0) := (others=>'0');
  signal  b:  std_logic_vector (BUS_WIDTH-1 downto 0) := (others=>'0');
  signal  clk: std_logic;
  signal  n_rst: std_logic;
  signal  q:  std_logic_vector (2*BUS_WIDTH-1 downto 0) := (others=>'0');
  signal  r:  std_logic_vector (BUS_WIDTH-1 downto 0) := (others=>'0');

begin
  dut: n_m_array_divider port map (
                            a=>a, 
			    b=>b, 
			    clk=>clk,
                            n_rst=>n_rst, 
			    q=>q,
                            r=>r
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
    a <= "00000000";
    b <= "0000";

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    -- divide
    a <= "00001001";
    b <= "0010";
    wait for 10 ns;

--    n_rst <= '0';
--    wait for 10 ns;
--    n_rst <= '1';
--    wait for 10 ns;
--
--    -- divide
--    a <= "00001001";
--    b <= "0011";
--    wait for 10 ns;
--
--
--    n_rst <= '0';
--    wait for 10 ns;
--    n_rst <= '1';
--    wait for 10 ns;
--
--    -- divide
--    a <= "00001000";
--    b <= "0011";
--    wait for 10 ns;
--
    wait;
  end process;
end;
