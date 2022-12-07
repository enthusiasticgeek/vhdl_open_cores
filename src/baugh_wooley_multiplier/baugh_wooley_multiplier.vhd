library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use ieee.math_real.all;

--nxn array multiplier
package baugh_wooley_multiplier_package  is
  constant BUS_WIDTH : integer := 4;
  --type input is array (0 to BUS_WIDTH-1) of bit;
  type input is array (0 to BUS_WIDTH, BUS_WIDTH downto 0) of std_logic;
  type delay is array (0 to 2*BUS_WIDTH, BUS_WIDTH downto 0) of std_logic;
end package;

-- nxn array multiplier
library  ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.baugh_wooley_multiplier_package.all;

entity baugh_wooley_multiplier is
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           p: out std_logic_vector (2*BUS_WIDTH-1 downto 0));
end entity;

architecture behaviour of baugh_wooley_multiplier is

     signal s_sig: input := (others=>(others => '0'));
     signal c_sig: input := (others=>(others => '0'));
     signal d_sig: delay := (others=>(others => '0'));
     signal p_sig: std_logic_vector (2*BUS_WIDTH-1 downto 0) := (others => '0');

component dff is
	port ( d, clk, n_rst : in std_logic;
	q : out std_logic);
end component;
component gc is
    port (si, ci, a, b, clk, n_rst: in std_logic;
           co, so: out std_logic);
end component;
component wc is
    port (si, ci, a, b, clk, n_rst: in std_logic;
           co, so: out std_logic);
end component;
component fa is
     port (a, ci, b, clk, n_rst: in std_logic;
           co, so: out std_logic);
end component;

begin
		X0:
		for I in 0 to BUS_WIDTH-1 generate 
	            A1: if I >=0 and I < BUS_WIDTH-1 generate 
	               X01: wc
				port map ('0','0',a(I),b(0),clk,n_rst,c_sig(0,I),s_sig(0,I)); 
                    end generate A1;
	            B1: if I = BUS_WIDTH-1 generate 
	               X02: gc
				port map ('0','0',a(I),b(0),clk,n_rst,c_sig(0,I),s_sig(0,I)); 
                    end generate B1;
		end generate X0;

		X1:
		for I in 0 to BUS_WIDTH-1 generate 
	            A1: if I >=0 and I < BUS_WIDTH-1 generate 
	               X11: wc
				port map (s_sig(0,I+1),c_sig(0,I),a(I),b(1),clk,n_rst,c_sig(1,I),s_sig(1,I)); 
                    end generate A1;
	            B1: if I = BUS_WIDTH-1 generate 
	               X12: gc
				port map ('0'       ,c_sig(0,I),a(I),b(1),clk,n_rst,c_sig(1,I),s_sig(1,I)); 
                    end generate B1;
		end generate X1;

		X2:
		for I in 0 to BUS_WIDTH-1 generate 
	            A1: if I >=0 and I < BUS_WIDTH-1 generate 
	               X21: wc
				port map (s_sig(1,I+1),c_sig(1,I),a(I),b(2),clk,n_rst,c_sig(2,I),s_sig(2,I)); 
                    end generate A1;
	            B1: if I = BUS_WIDTH-1 generate 
	               X22: gc
				port map ('0'       ,c_sig(1,I),a(I),b(2),clk,n_rst,c_sig(2,I),s_sig(2,I)); 
                    end generate B1;
		end generate X2;

		X3:
		for I in 0 to BUS_WIDTH-1 generate 
	            A1: if I >=0 and I < BUS_WIDTH-1 generate 
	               X31: gc
				port map (s_sig(2,I+1),c_sig(2,I),a(I),b(3),clk,n_rst,c_sig(3,I),s_sig(3,I)); 
                    end generate A1;
	            B1: if I = BUS_WIDTH-1 generate 
	               X32: wc
				port map ('0'       ,c_sig(2,I),a(I),b(3),clk,n_rst,c_sig(3,I),s_sig(3,I)); 
                    end generate B1;
		end generate X3;

		X4:
		for I in 0 to BUS_WIDTH-1 generate 
	            A1: if I = 0 generate 
	               X41: fa
				port map (s_sig(3,1+I),c_sig(3,I),'1'       ,clk,n_rst,c_sig(4,I),s_sig(4,I)); 
                    end generate A1;
	            B1: if I > 0 and I < BUS_WIDTH-1 generate 
	               X42: fa
				port map (s_sig(3,1+I),c_sig(3,I),c_sig(4,I-1),clk,n_rst,c_sig(4,I),s_sig(4,I)); 
                    end generate B1;
	            C1: if I = BUS_WIDTH-1 generate 
	               X43: fa
				port map ('1'         ,c_sig(3,I),c_sig(4,I-1),clk,n_rst,c_sig(4,I),s_sig(4,I)); 
                    end generate C1;
		end generate X4;

		X5:
		for I in 0 to 2*BUS_WIDTH-1 generate 
	            A1: if I >= 0 and I <= BUS_WIDTH-1 generate 
			  p_sig(I) <= s_sig(I,0);
                    end generate A1;
	            B1: if I > BUS_WIDTH-1 generate 
			  p_sig(I) <= s_sig(BUS_WIDTH,I-BUS_WIDTH);
                    end generate B1;
		end generate X5;


--

--
--		X01: wc
--				port map ('0','0',a(0),b(0),clk,n_rst,c_sig(0,0),s_sig(0,0)); 
--		X02: wc
--				port map ('0','0',a(1),b(0),clk,n_rst,c_sig(0,1),s_sig(0,1)); 
--		X03: wc
--				port map ('0','0',a(2),b(0),clk,n_rst,c_sig(0,2),s_sig(0,2)); 
--		X04: gc
--				port map ('0','0',a(3),b(0),clk,n_rst,c_sig(0,3),s_sig(0,3)); 
--
--
--
--		X21: wc
--				port map (s_sig(0,1),c_sig(0,0),a(0),b(1),clk,n_rst,c_sig(1,0),s_sig(1,0)); 
--		X22: wc
--				port map (s_sig(0,2),c_sig(0,1),a(1),b(1),clk,n_rst,c_sig(1,1),s_sig(1,1)); 
--		X23: wc
--				port map (s_sig(0,3),c_sig(0,2),a(2),b(1),clk,n_rst,c_sig(1,2),s_sig(1,2)); 
--		X24: gc
--				port map ('0',       c_sig(0,3),a(3),b(1),clk,n_rst,c_sig(1,3),s_sig(1,3)); 
--
--
--		X31: wc
--				port map (s_sig(1,1),c_sig(1,0),a(0),b(2),clk,n_rst,c_sig(2,0),s_sig(2,0)); 
--		X32: wc
--				port map (s_sig(1,2),c_sig(1,1),a(1),b(2),clk,n_rst,c_sig(2,1),s_sig(2,1)); 
--		X33: wc
--				port map (s_sig(1,3),c_sig(1,2),a(2),b(2),clk,n_rst,c_sig(2,2),s_sig(2,2)); 
--		X34: gc
--				port map ('0',       c_sig(1,3),a(3),b(2),clk,n_rst,c_sig(2,3),s_sig(2,3)); 
--
--
--		X41: gc
--				port map (s_sig(2,1),c_sig(2,0),a(0),b(3),clk,n_rst,c_sig(3,0),s_sig(3,0)); 
--		X42: gc
--				port map (s_sig(2,2),c_sig(2,1),a(1),b(3),clk,n_rst,c_sig(3,1),s_sig(3,1)); 
--		X43: gc
--				port map (s_sig(2,3),c_sig(2,2),a(2),b(3),clk,n_rst,c_sig(3,2),s_sig(3,2)); 
--		X44: wc
--				port map ('0',       c_sig(2,3),a(3),b(3),clk,n_rst,c_sig(3,3),s_sig(3,3)); 
--
--                                -- a , cin, b, co, so
--		X51: fa
--				port map (s_sig(3,1),c_sig(3,0),'1'       ,clk,n_rst,c_sig(4,0),s_sig(4,0)); 
--		X52: fa
--				port map (s_sig(3,2),c_sig(3,1),c_sig(4,0),clk,n_rst,c_sig(4,1),s_sig(4,1)); 
--		X53: fa
--				port map (s_sig(3,3),c_sig(3,2),c_sig(4,1),clk,n_rst,c_sig(4,2),s_sig(4,2)); 
--		X54: fa
--				port map ('1'       ,c_sig(3,3),c_sig(4,2),clk,n_rst,c_sig(4,3),s_sig(4,3)); 


	--stage 1 full independent full adders
--
--		  p_sig(0) <= s_sig(0,0);
--		  p_sig(1) <= s_sig(1,0);
--		  p_sig(2) <= s_sig(2,0);
--		  p_sig(3) <= s_sig(3,0);
--		  p_sig(4) <= s_sig(4,0);
--		  p_sig(5) <= s_sig(4,1);
--		  p_sig(6) <= s_sig(4,2);
--		  p_sig(7) <= s_sig(4,3);
--
--
--

           process(clk,n_rst)
           begin
           if n_rst = '0' then
             p <= (others => '0');
           elsif rising_edge(clk) then
             p <= p_sig;

           end if;
           end process;
end architecture;
