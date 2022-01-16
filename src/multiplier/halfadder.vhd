-- half adder
-- 32-bit adder
library  ieee;
use  ieee.std_logic_1164.all;

entity halfadder is
     port (x,y: in std_logic;
           carry : out std_logic;
                sum: out std_logic);
end entity;

architecture behaviour of halfadder is
begin
           carry<= (x and y);
           sum <= (x xor y);
end architecture;
