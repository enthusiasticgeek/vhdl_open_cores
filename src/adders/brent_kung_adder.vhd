-- 8-bit brent-kung adder
library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use ieee.math_real.all;
--n bit brent kung
package brent_kung_adder_package  is
  constant BUS_WIDTH : integer := 8;
  --type input is array (0 to 8,0 to BUS_WIDTH-1) of std_logic_vector;
  type input is array (0 to integer(ceil(log2(real(8))))+integer(2), BUS_WIDTH-1 downto 0) of std_logic;
  --type my_std_logic is array (natural range <>) of std_logic_vector;
end package;

-- 32-bit adder
library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use Work.brent_kung_adder_package.all;

entity brent_kung_adder is
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
           c_out: out std_logic);
end entity;

architecture behaviour of brent_kung_adder is
     signal c_sig: signed (BUS_WIDTH downto 0) := (others => '0');
     signal s_sig: std_logic_vector (BUS_WIDTH-1 downto 0) := (others => '0');
     signal g_sig: input := (others=>(others => '0'));
     signal p_sig: input := (others=>(others => '0'));
     --constant zeros : std_logic_vector(c'range-1) := (others => '0');
     --constant zeros : std_logic_vector(BUS_WIDTH-1 downto 0) := (others => '0');
-- definition of GP block
component brent_kung_GP is
     port (x, y: in std_logic;
           g, p: out std_logic);
end component;
 --  cent block
-- definition of cent block
component brent_kung_cent is
     port (g1, p1: in std_logic;
           g2, p2: in std_logic;
           g, p: out std_logic);
end component;
-- definition of c block
component brent_kung_c is
     port (g, p, c: in std_logic;
           c_out: out std_logic);
end component;
   --  s block
-- definition of s block
component brent_kung_s is
     port (p, c: in std_logic;
           s: out std_logic);
end component;

begin
           c_sig(0)<=c_in;

-- 8 blocks
brent_kung0:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
           brent_kung_gp0: brent_kung_gp
                port map (a(I),b(I),g_sig(0,I),p_sig(0,I)); --0,1,2,3,4,5,6,7
end generate;


-- 4 blocks
brent_kung1:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
    OPERATE: if (I mod 2) = 0 and I+1 <= BUS_WIDTH-1 generate
           brent_kung_cent0: brent_kung_cent
                port map (g_sig(0,I),p_sig(0,I),g_sig(0,I+1),p_sig(0,I+1),g_sig(1,I+1),p_sig(1,I+1)); -- [0,1],[2,3],[4,5],[6,7]
    end generate OPERATE;
    PASS_THROUGH: if (I mod 2) /= 0 and I-1 <= 7 generate -- 0, 2, 4, 6
                g_sig(1,I-1) <= g_sig(0,I-1);
                p_sig(1,I-1) <= p_sig(0,I-1);
    end generate PASS_THROUGH;
end generate;

-- 2 blocks
brent_kung2:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
    OPERATE: if (I mod 4) = 0 and I+3 <= BUS_WIDTH-1 generate
           brent_kung_cent1: brent_kung_cent
                port map (g_sig(1,I+1),p_sig(1,I+1),g_sig(1,I+3),p_sig(1,I+3),g_sig(2,I+3),p_sig(2,I+3)); -- [1,3],[5,7]
    end generate OPERATE;
    PASS_THROUGH: if (I mod 4) /= 0 and I-1 <= 7 generate -- 0, 1, 2, 4, 5, 6
                g_sig(2,I-1) <= g_sig(1,I-1);
                p_sig(2,I-1) <= p_sig(1,I-1);
    end generate PASS_THROUGH;
end generate;

-- 1 block
brent_kung3:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
    OPERATE: if (I mod 8) = 0 and I+7 <= BUS_WIDTH-1 generate
           brent_kung_cent2: brent_kung_cent
                port map (g_sig(2,I+3),p_sig(2,I+3),g_sig(2,I+7),p_sig(2,I+7),g_sig(3,I+7),p_sig(3,I+7)); -- [3,7]
    end generate OPERATE;
    PASS_THROUGH: if (I mod 8) /= 0 and I-1 <= 7 generate -- 0, 1, 2, 3, 4, 5, 6
                g_sig(3,I-1) <= g_sig(2,I-1);
                p_sig(3,I-1) <= p_sig(2,I-1);
    end generate PASS_THROUGH;
end generate;

-- 1 blocks
brent_kung4:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
    OPERATE: if (I mod 4) = 0 and I+5 <= BUS_WIDTH-1 generate
           brent_kung_cent3: brent_kung_cent
                port map (g_sig(3,I+3),p_sig(3,I+3),g_sig(3,I+3),p_sig(3,I+5),g_sig(4,I+5),p_sig(4,I+5)); -- [3,5]
    end generate OPERATE;
                g_sig(4,0) <= g_sig(3,0);
                p_sig(4,0) <= p_sig(3,0);
                g_sig(4,1) <= g_sig(3,1);
                p_sig(4,1) <= p_sig(3,1);
    PASS_THROUGH: if (I mod 4) /= 0 and I+1 <= BUS_WIDTH-1 generate
                g_sig(4,I+1) <= g_sig(3,I+1);
                p_sig(4,I+1) <= p_sig(3,I+1);
    end generate PASS_THROUGH;
end generate;

-- 3 blocks 
brent_kung5:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
    OPERATE: if (I mod 2) = 0 and I+2 <= BUS_WIDTH-1 generate
           brent_kung_cent4: brent_kung_cent
                port map (g_sig(4,I+1),p_sig(4,I+1),g_sig(4,I+2),p_sig(4,I+2),g_sig(5,I+2),p_sig(5,I+2)); -- [1,2],[3,4],[5,6]
    end generate OPERATE;
                g_sig(5,0) <= g_sig(4,0);
                p_sig(5,0) <= p_sig(4,0);
    PASS_THROUGH: if (I mod 2) /= 0 and I <= BUS_WIDTH-1 generate
                g_sig(5,I) <= g_sig(4,I);
                p_sig(5,I) <= p_sig(4,I);
    end generate PASS_THROUGH;
end generate;

-- 
-- 8 blocks
brent_kung6:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
           brent_kung_c0: brent_kung_c
                port map (g_sig(5,I),p_sig(5,I),c_sig(0),c_sig(I+1)); --0,1,2,3,4,5,6,7
end generate;

-- 8 blocks
brent_kung7:
for I in 0 to BUS_WIDTH-1 generate -- 0 to 7
           brent_kung_s0: brent_kung_s
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
