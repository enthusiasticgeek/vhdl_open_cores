-- Basic building blocks for Kogge Stone Adder
--  GP block
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of GP block
entity kogge_stone_GP is
     port (x, y: in std_logic;
           g, p: out std_logic);
end entity;
architecture behaviour of kogge_stone_GP is
begin
        g <= x and y;
        p <= x xor y;
end architecture;

 --  cent block
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of cent block
entity kogge_stone_cent is
     port (g1, p1: in std_logic;
           g2, p2: in std_logic;
           g, p: out std_logic);
end entity;
architecture behaviour of kogge_stone_cent is
begin
        g <= g2 or (g1 and p2);
        p <= p1 and p2;
end architecture;

  --  c block
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of c block
entity kogge_stone_c is
     port (g, p, c: in std_logic;
           c_out: out std_logic);
end entity;
architecture behaviour of kogge_stone_c is
begin
        c_out <= g or (c and p);
end architecture;

   --  s block
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of s block
entity kogge_stone_s is
     port (p, c: in std_logic;
           s: out std_logic);
end entity;
architecture behaviour of kogge_stone_s is
begin
        s <= p xor c;
end architecture;
