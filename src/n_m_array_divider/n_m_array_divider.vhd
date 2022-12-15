--http://www.secs.oakland.edu/~llamocca/dig_library/arith/Divider%20Implementation.pdf
library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use ieee.math_real.all;

--nxn array multiplier
package n_m_array_divider_package  is
  constant BUS_WIDTH : integer := 4;
  --type input is array (0 to BUS_WIDTH-1) of bit;
  type input is array (0 to 2*BUS_WIDTH, BUS_WIDTH+1 downto 0) of std_logic;
end package;

-- nxn array multiplier
library  ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.n_m_array_divider_package.all;

entity n_m_array_divider is
     port (a: in std_logic_vector(2*BUS_WIDTH-1 downto 0);
           b: in std_logic_vector(BUS_WIDTH-1 downto 0);
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           q: out std_logic_vector (2*BUS_WIDTH-1 downto 0);
           r: out std_logic_vector (BUS_WIDTH-1 downto 0));
end entity;

architecture behaviour of n_m_array_divider is

     signal a_sig: input := (others=>(others => '0'));
     --signal b_sig: input := (others=>(others => '0'));
     signal c_sig: input := (others=>(others => '0'));
     signal s_sig: std_logic_vector (2*BUS_WIDTH-1 downto 0) := (others => '0');
     signal q_sig: std_logic_vector (2*BUS_WIDTH-1 downto 0) := (others => '0');
     signal r_sig: std_logic_vector (BUS_WIDTH-1 downto 0) := (others => '0');

component pu is
     port (a, ci, b, clk, n_rst, s: in std_logic;
           co, r: out std_logic);
end component;

begin

                a_sig(0,0) <= a(7);
                a_sig(0,1) <= '0';
                a_sig(0,2) <= '0';
                a_sig(0,3) <= '0';

                c_sig(0,0) <= '1';

		X0:
		for I in 0 to BUS_WIDTH-1 generate 
	            A0: if I = 0 generate 
	               X01: pu
				port map (a_sig(0,0),c_sig(0,0),b(0),clk, n_rst,s_sig(0),c_sig(0,1),a_sig(1,1)); 
                    end generate A0;
	            A1: if I > 0 and I <= BUS_WIDTH-1 generate 
	               X02: pu
				port map (a_sig(0,I),c_sig(0,I),b(I),clk, n_rst,s_sig(0),c_sig(0,I+1),a_sig(1,I+1));  
                    end generate A1;
		end generate X0;
                s_sig(0) <= c_sig(0,4);

                a_sig(1,0) <= a(6);
                c_sig(1,0) <= '1';
		X1:
		for I in 0 to BUS_WIDTH-1 generate 
	            B0: if I = 0 generate 
	               X01: pu
				port map (a_sig(1,0),c_sig(1,0),b(0),clk, n_rst,s_sig(1),c_sig(1,1),a_sig(2,1)); 
                    end generate B0;
	            B1: if I > 0 and I <= BUS_WIDTH-1 generate 
	               X02: pu
				port map (a_sig(1,I),c_sig(1,I),b(I),clk, n_rst,s_sig(1),c_sig(1,I+1),a_sig(2,I+1));  
                    end generate B1;
		end generate X1;
                s_sig(1) <= c_sig(1,4);

                a_sig(2,0) <= a(5);
                c_sig(2,0) <= '1';
		X2:
		for I in 0 to BUS_WIDTH-1 generate 
	            C0: if I = 0 generate 
	               X01: pu
				port map (a_sig(2,0),c_sig(2,0),b(0),clk, n_rst,s_sig(2),c_sig(2,1),a_sig(3,1)); 
                    end generate C0;
	            C1: if I > 0 and I <= BUS_WIDTH-1 generate 
	               X02: pu
				port map (a_sig(2,I),c_sig(2,I),b(I),clk, n_rst,s_sig(2),c_sig(2,I+1),a_sig(3,I+1));  
                    end generate C1;
		end generate X2;
                s_sig(2) <= c_sig(2,4);

                a_sig(3,0) <= a(4);
                c_sig(3,0) <= '1';
		X3:
		for I in 0 to BUS_WIDTH-1 generate 
	            D0: if I = 0 generate 
	               X01: pu
				port map (a_sig(3,0),c_sig(3,0),b(0),clk, n_rst,s_sig(3),c_sig(3,1),a_sig(4,1)); 
                    end generate D0;
	            D1: if I > 0 and I <= BUS_WIDTH-1 generate 
	               X02: pu
				port map (a_sig(3,I),c_sig(3,I),b(I),clk, n_rst,s_sig(3),c_sig(3,I+1),a_sig(4,I+1));  
                    end generate D1;
		end generate X3;
                s_sig(3) <= c_sig(3,4);

                a_sig(4,0) <= a(3);
                c_sig(4,0) <= '1';
		X4:
		for I in 0 to BUS_WIDTH generate 
	            E0: if I = 0 generate 
	               X01: pu
				port map (a_sig(4,0),c_sig(4,0),b(0),clk, n_rst,s_sig(4),c_sig(4,1),a_sig(5,1)); 
                    end generate E0;
	            E1: if I > 0 and I <= BUS_WIDTH-1 generate 
	               X02: pu
				port map (a_sig(4,I),c_sig(4,I),b(I),clk, n_rst,s_sig(4),c_sig(4,I+1),a_sig(5,I+1));  
                    end generate E1;
	            E2: if I = BUS_WIDTH generate 
	               X03: pu
				port map (a_sig(4,I),c_sig(4,I),'0',clk, n_rst,s_sig(4),c_sig(4,I+1),a_sig(5,I+1));  
                    end generate E2;
		end generate X4;
                s_sig(4) <= c_sig(4,5);

                a_sig(5,0) <= a(2);
                c_sig(5,0) <= '1';
		X5:
		for I in 0 to BUS_WIDTH generate 
	            F0: if I = 0 generate 
	               X01: pu
				port map (a_sig(5,0),c_sig(5,0),b(0),clk, n_rst,s_sig(5),c_sig(5,1),a_sig(6,1)); 
                    end generate F0;
	            F1: if I > 0 and I <= BUS_WIDTH-1 generate 
	               X02: pu
				port map (a_sig(5,I),c_sig(5,I),b(I),clk, n_rst,s_sig(5),c_sig(5,I+1),a_sig(6,I+1));  
                    end generate F1;
	            F2: if I = BUS_WIDTH generate 
	               X03: pu
				port map (a_sig(5,I),c_sig(5,I),'0',clk, n_rst,s_sig(5),c_sig(5,I+1),a_sig(6,I+1));  
                    end generate F2;
		end generate X5;
                s_sig(5) <= c_sig(5,5);

                a_sig(6,0) <= a(1);
                c_sig(6,0) <= '1';
		X6:
		for I in 0 to BUS_WIDTH generate 
	            G0: if I = 0 generate 
	               X01: pu
				port map (a_sig(6,0),c_sig(6,0),b(0),clk, n_rst,s_sig(6),c_sig(6,1),a_sig(7,1)); 
                    end generate G0;
	            G1: if I > 0 and I <= BUS_WIDTH-1 generate 
	               X02: pu
				port map (a_sig(6,I),c_sig(6,I),b(I),clk, n_rst,s_sig(6),c_sig(6,I+1),a_sig(7,I+1));  
                    end generate G1;
	            G2: if I = BUS_WIDTH generate 
	               X03: pu
				port map (a_sig(6,I),c_sig(6,I),'0',clk, n_rst,s_sig(6),c_sig(6,I+1),a_sig(7,I+1));  
                    end generate G2;
		end generate X6;
                s_sig(6) <= c_sig(6,5);

                a_sig(7,0) <= a(0);
                c_sig(7,0) <= '1';
		X7:
		for I in 0 to BUS_WIDTH generate 
	            H0: if I = 0 generate 
	               X01: pu
				port map (a_sig(7,0),c_sig(7,0),b(0),clk, n_rst,s_sig(7),c_sig(7,1),a_sig(8,1)); 
                    end generate H0;
	            H1: if I > 0 and I <= BUS_WIDTH-1 generate 
	               X02: pu
				port map (a_sig(7,I),c_sig(7,I),b(I),clk, n_rst,s_sig(7),c_sig(7,I+1),a_sig(8,I+1));  
                    end generate H1;
	            H2: if I = BUS_WIDTH generate 
	               X03: pu
				port map (a_sig(7,I),c_sig(7,I),'0',clk, n_rst,s_sig(7),c_sig(7,I+1),a_sig(8,I+1));  
                    end generate H2;
		end generate X7;
                s_sig(7) <= c_sig(7,5);

           q_sig(7) <= s_sig(0);
           q_sig(6) <= s_sig(1);
           q_sig(5) <= s_sig(2);
           q_sig(4) <= s_sig(3);
           q_sig(3) <= s_sig(4);
           q_sig(2) <= s_sig(5);
           q_sig(1) <= s_sig(6);
           q_sig(0) <= s_sig(7);

           r_sig(0) <= a_sig(8,1);
           r_sig(1) <= a_sig(8,2);
           r_sig(2) <= a_sig(8,3);
           r_sig(3) <= a_sig(8,4);

           process(clk,n_rst)
           begin
           if n_rst = '0' then
             q <= (others => '0');
             r <= (others => '0');
           elsif rising_edge(clk) then
             q <= q_sig;
             r <= r_sig;

           end if;
           end process;
end architecture;
