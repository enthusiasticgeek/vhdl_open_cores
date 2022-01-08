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

        first_row:
        for I in 0 to BUS_WIDTH-2 generate -- I = 3
          y_fa(0,I) <= a(I+1) and x(0); 
          x_fa(0,I) <= a(I) and x(1); 
		   FULL_ADDER0_0: FULLADDER
			port map (x_fa(0,I), y_fa(0,I), '0', sum_sig(0,I), cout_sig(0,I));

        end generate;
          p_sig(1) <= sum_sig(0,0);

         -- middle rows

second_to_middle_row_k:
for K in 1 to BUS_WIDTH-2 generate -- K = [1,3]
        second_to_middle_row:
        for I in 0 to BUS_WIDTH-2 generate -- I = [0,3]
	  connect_to_middle_sum: if I < BUS_WIDTH-2 generate 
                   y_fa(K,I) <= sum_sig(K,I+1); 
          end generate connect_to_middle_sum;
	  connect_to_middle_product : if I = BUS_WIDTH-2 generate
                   y_fa(K,I) <= a(I+1) and x(I); 
          end generate connect_to_middle_product;

          x_fa(K,I) <= a(I) and x(K+1); 
		   FULL_ADDER_to_middle_0: FULLADDER
			port map (x_fa(K,I), y_fa(K,I), cout_sig(K-1,I), sum_sig(K,I), cout_sig(K,I));

        end generate second_to_middle_row;
          p_sig(K+1) <= sum_sig(K,0);
end generate second_to_middle_row_k;


        -- last row

        last_row:
        for I in 0 to BUS_WIDTH-2 generate -- I = 3
          first_sum_N: if I=0 generate
                   y_fa(BUS_WIDTH-1,I) <= sum_sig(BUS_WIDTH-2,I+1); 
                   x_fa(BUS_WIDTH-1,I) <= '0';
          end generate first_sum_N;
	  connect_sum_N: if I > 0 and I < BUS_WIDTH-2 generate 
                   y_fa(BUS_WIDTH-1,I) <= sum_sig(BUS_WIDTH-2,I+1); 
                   x_fa(BUS_WIDTH-1,I) <= cout_sig(BUS_WIDTH-1,I-1); 
          end generate connect_sum_N;
	  connect_product_N : if I = BUS_WIDTH-2 generate
                   y_fa(BUS_WIDTH-1,I) <= a(I+1) and x(I+1); 
                   x_fa(BUS_WIDTH-1,I) <= cout_sig(BUS_WIDTH-1,I-1); 
          end generate connect_product_N;
		   FULL_ADDER_N_0: FULLADDER
			port map (x_fa(BUS_WIDTH-1,I), y_fa(BUS_WIDTH-1,I), cout_sig(BUS_WIDTH-2,I), sum_sig(BUS_WIDTH-1,I), cout_sig(BUS_WIDTH-1,I));

        end generate last_row;

        last_row_prod:
        for I in 0 to BUS_WIDTH-2 generate -- I = 3
          p_sig(BUS_WIDTH+I) <= sum_sig(BUS_WIDTH-1,I);
          cout_sig_prod: if I = BUS_WIDTH-2 generate
             p_sig(2*BUS_WIDTH-1) <= cout_sig(BUS_WIDTH-1,I);
          end generate cout_sig_prod;
        end generate last_row_prod;





           process(clk,n_rst, sum_sig, cout_sig)
           begin
           if n_rst = '0' then
             p <= (others => '0');
           elsif rising_edge(clk) then
             p <= p_sig;
           end if;
           end process;
end architecture;
