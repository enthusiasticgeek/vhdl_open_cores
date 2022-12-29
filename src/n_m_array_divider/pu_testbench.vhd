library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity pu_testbench is
end entity;

architecture testbench of pu_testbench is
component pu is
     port (a, ci, b, clk, n_rst, s: in std_logic;
           co, r: out std_logic);
end component;
     signal a : std_logic := '0'; 
     signal b : std_logic := '0'; 
     signal ci : std_logic := '0'; 
     signal  clk: std_logic;
     signal  n_rst: std_logic;
     signal s : std_logic := '0'; 
     signal co : std_logic := '0'; 
     signal r : std_logic := '0'; 
begin
  dut: pu port map (
                            a=>a, 
                            ci=>ci, 
			    b=>b, 
			    clk=>clk,
                            n_rst=>n_rst, 
                            s=>s, 
                            co=>co,
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
    a <= '0';
    ci <= '0';
    b <= '0';
    s <= '0';

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    a <= '1';
    ci <= '1';
    b <= '0';
    s <= '0';
    wait for 10 ns;

    n_rst <= '0';
    wait for 10 ns;
    n_rst <= '1';
    wait for 10 ns;

    a <= '1';
    ci <= '1';
    b <= '1';
    s <= '1';
    wait for 10 ns;



    wait;
  end process;
end;


