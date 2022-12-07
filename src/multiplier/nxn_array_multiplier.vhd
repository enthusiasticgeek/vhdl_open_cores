library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use ieee.math_real.all;

--nxn array multiplier
package nxn_array_multiplier_package  is
  constant BUS_WIDTH : integer := 5;
  --type input is array (0 to BUS_WIDTH-1) of bit;
  type input is array (0 to BUS_WIDTH-1, BUS_WIDTH-1 downto 0) of std_logic;
end package;

-- nxn array multiplier
library  ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.nxn_array_multiplier_package.all;

entity nxn_array_multiplier is
     port (a, x: in std_logic_vector(BUS_WIDTH-1 downto 0);
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           p: out std_logic_vector (2*BUS_WIDTH-1 downto 0));
end entity;

architecture behaviour of nxn_array_multiplier is
     signal sum_sig: input := (others=>(others => '0'));
     signal cout_sig: input := (others=>(others => '0'));
     signal x_fa: input := (others=>(others => '0'));
     signal y_fa: input := (others=>(others => '0'));
     signal last_row_cout : std_logic_vector(BUS_WIDTH-1 downto 0) := (others => '0');
     signal p_sig: std_logic_vector (2*BUS_WIDTH-1 downto 0) := (others => '0');
component FULLADDER
           port(a, b, c: in std_logic;
		sum, carry: out std_logic);
end component;
begin
--stage 1 full independent full adders

          p_sig(0) <= a(0) and x(0);

          -- row 1

          y_fa(0,0) <= a(1) and x(0); 
          x_fa(0,0) <= a(0) and x(1); 
		   FULL_ADDER0_0: FULLADDER
			port map (x_fa(0,0), y_fa(0,0), '0', sum_sig(0,0), cout_sig(0,0));
          y_fa(0,1) <= a(2) and x(0); 
          x_fa(0,1) <= a(1) and x(1); 
		   FULL_ADDER0_1: FULLADDER
			port map (x_fa(0,1), y_fa(0,1), '0', sum_sig(0,1), cout_sig(0,1));
          y_fa(0,2) <= a(3) and x(0); 
          x_fa(0,2) <= a(2) and x(1); 
		   FULL_ADDER0_2: FULLADDER
			port map (x_fa(0,2), y_fa(0,2), '0', sum_sig(0,2), cout_sig(0,2));
          y_fa(0,3) <= a(4) and x(0); 
          x_fa(0,3) <= a(3) and x(1); 
		   FULL_ADDER0_3: FULLADDER
			port map (x_fa(0,3), y_fa(0,3), '0', sum_sig(0,3), cout_sig(0,3));
          p_sig(1) <= sum_sig(0,0);

          -- row 2

          y_fa(1,0) <= sum_sig(0,1);
          x_fa(1,0) <= a(0) and x(2); 
		   FULL_ADDER1_0: FULLADDER
			port map (x_fa(1,0), y_fa(1,0), cout_sig(0,0), sum_sig(1,0), cout_sig(1,0));
          y_fa(1,1) <= sum_sig(0,2); 
          x_fa(1,1) <= a(1) and x(2); 
		   FULL_ADDER1_1: FULLADDER
			port map (x_fa(1,1), y_fa(1,1), cout_sig(0,1), sum_sig(1,1), cout_sig(1,1));
          y_fa(1,2) <= sum_sig(0,3); 
          x_fa(1,2) <= a(2) and x(2); 
		   FULL_ADDER1_2: FULLADDER
			port map (x_fa(1,2), y_fa(1,2), cout_sig(0,2), sum_sig(1,2), cout_sig(1,2));
          y_fa(1,3) <= a(4) and x(1); 
          x_fa(1,3) <= a(3) and x(2); 
		   FULL_ADDER1_3: FULLADDER
			port map (x_fa(1,3), y_fa(1,3), cout_sig(0,3), sum_sig(1,3), cout_sig(1,3));
          p_sig(2) <= sum_sig(1,0);

          -- row 3

          y_fa(2,0) <= sum_sig(1,1);
          x_fa(2,0) <= a(0) and x(3); 
		   FULL_ADDER2_0: FULLADDER
			port map (x_fa(2,0), y_fa(2,0), cout_sig(1,0), sum_sig(2,0), cout_sig(2,0));
          y_fa(2,1) <= sum_sig(1,2); 
          x_fa(2,1) <= a(1) and x(3); 
		   FULL_ADDER2_1: FULLADDER
			port map (x_fa(2,1), y_fa(2,1), cout_sig(1,1), sum_sig(2,1), cout_sig(2,1));
          y_fa(2,2) <= sum_sig(1,3); 
          x_fa(2,2) <= a(2) and x(3); 
		   FULL_ADDER2_2: FULLADDER
			port map (x_fa(2,2), y_fa(2,2), cout_sig(1,2), sum_sig(2,2), cout_sig(2,2));
          y_fa(2,3) <= a(4) and x(2); 
          x_fa(2,3) <= a(3) and x(3); 
		   FULL_ADDER2_3: FULLADDER
			port map (x_fa(2,3), y_fa(2,3), cout_sig(1,3), sum_sig(2,3), cout_sig(2,3));
          p_sig(3) <= sum_sig(2,0);

          -- row 4

          y_fa(3,0) <= sum_sig(2,1);
          x_fa(3,0) <= a(0) and x(4); 
		   FULL_ADDER3_0: FULLADDER
			port map (x_fa(3,0), y_fa(3,0), cout_sig(2,0), sum_sig(3,0), cout_sig(3,0));
          y_fa(3,1) <= sum_sig(1,2); 
          x_fa(3,1) <= a(1) and x(4); 
		   FULL_ADDER3_1: FULLADDER
			port map (x_fa(3,1), y_fa(3,1), cout_sig(2,1), sum_sig(3,1), cout_sig(3,1));
          y_fa(3,2) <= sum_sig(1,3); 
          x_fa(3,2) <= a(2) and x(4); 
		   FULL_ADDER3_2: FULLADDER
			port map (x_fa(3,2), y_fa(3,2), cout_sig(2,2), sum_sig(3,2), cout_sig(3,2));
          y_fa(3,3) <= a(4) and x(3); 
          x_fa(3,3) <= a(3) and x(4); 
		   FULL_ADDER3_3: FULLADDER
			port map (x_fa(3,3), y_fa(3,3), cout_sig(2,3), sum_sig(3,3), cout_sig(3,3));
          p_sig(4) <= sum_sig(3,0);

          -- last row
          y_fa(4,0) <= sum_sig(3,1);
          x_fa(4,0) <= '0';
		   FULL_ADDER4_0: FULLADDER
			port map (x_fa(4,0), y_fa(4,0), cout_sig(3,0), sum_sig(4,0), cout_sig(4,0));
          y_fa(4,1) <= sum_sig(3,2);
          x_fa(4,1) <= cout_sig(4,0);
		   FULL_ADDER4_1: FULLADDER
			port map (x_fa(4,1), y_fa(4,1), cout_sig(3,1), sum_sig(4,1), cout_sig(4,1));
          y_fa(4,2) <= sum_sig(3,3);
          x_fa(4,2) <= cout_sig(4,1);
		   FULL_ADDER4_2: FULLADDER
			port map (x_fa(4,2), y_fa(4,2), cout_sig(3,2), sum_sig(4,2), cout_sig(4,2));
          y_fa(4,3) <= a(4) and x(4);
          x_fa(4,3) <= cout_sig(4,2);
		   FULL_ADDER4_3: FULLADDER
			port map (x_fa(4,3), y_fa(4,3), cout_sig(3,3), sum_sig(4,3), cout_sig(4,3));

          p_sig(5) <= sum_sig(4,0);
          p_sig(6) <= sum_sig(4,1);
          p_sig(7) <= sum_sig(4,2);
          p_sig(8) <= sum_sig(4,3);
          p_sig(9) <= cout_sig(4,3);



           process(clk,n_rst, sum_sig, cout_sig)
           begin
           if n_rst = '0' then
             p <= (others => '0');
           elsif rising_edge(clk) then
             p <= p_sig;
           end if;
           end process;
end architecture;
