-- 8-bit kogge-stone adder
library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use ieee.math_real.all;
--n bit brent kung
package kogge_stone_adder_package  is
  constant BUS_WIDTH : integer := 8;
  --type input is array (0 to 8,0 to BUS_WIDTH-1) of std_logic_vector;
  type input is array (0 to integer(ceil(log2(real(8))))+integer(2), BUS_WIDTH-1 downto 0) of std_logic;
  --type my_std_logic is array (natural range <>) of std_logic_vector;
end package;

-- 8-bit adder
library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use Work.kogge_stone_adder_package.all;

entity kogge_stone_adder is
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
           c_out: out std_logic);
end entity;

architecture behaviour of kogge_stone_adder is
     signal c_sig: signed (BUS_WIDTH downto 0) := (others => '0');
     signal s_sig: std_logic_vector (BUS_WIDTH-1 downto 0) := (others => '0');
     signal g_sig: input := (others=>(others => '0'));
     signal p_sig: input := (others=>(others => '0'));
     --constant zeros : std_logic_vector(c'range-1) := (others => '0');
     --constant zeros : std_logic_vector(BUS_WIDTH-1 downto 0) := (others => '0');
-- definition of GP block
component kogge_stone_GP is
     port (x, y: in std_logic;
           g, p: out std_logic);
end component;
 --  cent block
-- definition of cent block
component kogge_stone_cent is
     port (g1, p1: in std_logic;
           g2, p2: in std_logic;
           g, p: out std_logic);
end component;
-- definition of c block
component kogge_stone_c is
     port (g, p, c: in std_logic;
           c_out: out std_logic);
end component;
   --  s block
-- definition of s block
component kogge_stone_s is
     port (p, c: in std_logic;
           s: out std_logic);
end component;

begin
           c_sig(0)<=c_in;

-- 8 blocks
kogge_stone0:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
           kogge_stone_gp0: kogge_stone_gp
                port map (a(I),b(I),g_sig(0,I),p_sig(0,I)); --0,1,2,3,4,5,6,7
end generate;


-- 7 blocks
kogge_stone1:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
    OPERATE: if I+1 <= BUS_WIDTH-1 generate
           kogge_stone_cent0: kogge_stone_cent
                port map (g_sig(0,I),p_sig(0,I),g_sig(0,I+1),p_sig(0,I+1),g_sig(1,I+1),p_sig(1,I+1)); -- [0,1],[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]
    end generate OPERATE;
end generate;
kogge_stone2:
for I in 0 to (2**0)-1 generate -- 0 to 2^0-1
                g_sig(1,I) <= g_sig(0,I);
                p_sig(1,I) <= p_sig(0,I);
end generate;

-- 6 blocks
kogge_stone3:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
    OPERATE: if I+2 <= BUS_WIDTH-1 generate
           kogge_stone_cent1: kogge_stone_cent
                port map (g_sig(1,I),p_sig(1,I),g_sig(1,I+2),p_sig(1,I+2),g_sig(2,I+2),p_sig(2,I+2)); -- [0,2],[1,3],[2,4],[3,5],[4,6],[5,7]
    end generate OPERATE;
end generate;
kogge_stone4:
for I in 0 to (2**1)-1 generate -- 0 to 2^1-1
                g_sig(2,I) <= g_sig(1,I);
                p_sig(2,I) <= p_sig(1,I);
end generate;

-- 8 blocks
kogge_stone5:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
    OPERATE: if I+4 <= BUS_WIDTH-1 generate
           kogge_stone_cent2: kogge_stone_cent
                port map (g_sig(2,I),p_sig(2,I),g_sig(2,I+4),p_sig(2,I+4),g_sig(3,I+4),p_sig(3,I+4)); -- [0,2],[1,3],[2,4],[3,5],[4,6],[5,7]
    end generate OPERATE;
end generate;
kogge_stone6:
for I in 0 to (2**2)-1 generate -- 0 to 2^1-1
                g_sig(3,I) <= g_sig(2,I);
                p_sig(3,I) <= p_sig(2,I);
end generate;

-- 
-- 8 blocks
kogge_stone7:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
           kogge_stone_c0: kogge_stone_c
                port map (g_sig(3,I),p_sig(3,I),c_sig(0),c_sig(I+1)); --0,1,2,3,4,5,6,7
end generate;

-- 8 blocks
kogge_stone8:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
           kogge_stone_s0: kogge_stone_s
                port map (p_sig(0,I),c_sig(I),s_sig(I)); --0,1,2,3,4,5,6,7
end generate;

           process(clk,n_rst,c_sig,s_sig)
           begin
		   if n_rst = '0' then
		     c_out <= '0';
		     sum <= (others => '0');
		   elsif rising_edge(clk) then
		     c_out <= c_sig(BUS_WIDTH);
		     sum <= s_sig;
		   end if;
           end process;
end architecture;
