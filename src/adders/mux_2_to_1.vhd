
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of a 2 to 1 muxer
entity mux_2_to_1 is
port(
 
a,b : in std_logic;
sel: in std_logic;
o: out std_logic
);
end entity;
 
architecture behavior of mux_2_to_1 is
begin
process(a,b,sel)
 begin
   if sel = '0' then
      o <= a;
   else
      o <= b;
   end if;
 end process;
end behavior; 
