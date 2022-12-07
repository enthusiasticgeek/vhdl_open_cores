-- see https://www.ece.uvic.ca/~fayez/courses/ceng465/lab_465/project2/multiplier.pdf
--  full adder modified (gray cells)
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of a full adder
entity gc is
     port (si, ci, a, b, clk, n_rst: in std_logic;
           co, so: out std_logic);
end entity;
architecture behaviour of gc is
begin
    gc_proc : process (si,ci,a,b,clk,n_rst) is
    begin
        if (n_rst='0') then
            so <= '0';
            co <= '0';
        elsif (rising_edge (clk)) then
           so <= (si xor (a nand b)) xor ci ;
	   co <= (si and (a nand b)) or (ci and (si xor (a nand b)));
        end if;
    end process gc_proc;
end architecture;
