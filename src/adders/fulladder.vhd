library  ieee;
use  ieee.std_logic_1164.all;
-- definition of a full adder
entity FULLADDER is
     port (a, b, c: in std_logic;
           sum, carry: out std_logic);
end entity;
architecture behaviour of FULLADDER is
begin
	sum <= (a xor b) xor c ;
	carry <= (a and b) or (c and (a xor b));
end architecture;

 
