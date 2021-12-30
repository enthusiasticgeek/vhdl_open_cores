-- Basic building blocks for Brent Kung Adder
--  GP block
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of GP block
entity brent_kung_GP is
     port (x, y: in std_logic;
           g, p: out std_logic);
end entity;
architecture behaviour of brent_kung_GP is
begin
        g <= x and y;
        p <= x xor y;
end architecture;

 --  cent block
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of cent block
entity brent_kung_cent is
     port (g1, p1: in std_logic;
           g2, p2: in std_logic;
           g, p: out std_logic);
end entity;
architecture behaviour of brent_kung_cent is
begin
        g <= g2 or (g1 and p2);
        p <= p1 and p2;
end architecture;

  --  c block
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of c block
entity brent_kung_c is
     port (g, p, c: in std_logic;
           c_out: out std_logic);
end entity;
architecture behaviour of brent_kung_c is
begin
        c_out <= g or (c and p);
end architecture;

   --  s block
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of s block
entity brent_kung_s is
     port (p, c: in std_logic;
           s: out std_logic);
end entity;
architecture behaviour of brent_kung_s is
begin
        s <= p xor c;
end architecture;
