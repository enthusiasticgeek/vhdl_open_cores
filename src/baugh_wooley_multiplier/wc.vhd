-- see https://www.ece.uvic.ca/~fayez/courses/ceng465/lab_465/project2/multiplier.pdf
--  full adder modified (white cells)
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of a full adder
entity wc is
     port (si, ci, a, b, clk, n_rst: in std_logic;
           co, so: out std_logic);
end entity;
architecture behaviour of wc is
begin
    wc_proc : process (si,ci,a,b,clk,n_rst) is
    begin
        if (n_rst='0') then
            so <= '0';
            co <= '0';
        elsif (rising_edge (clk)) then
           so <= (si xor (a and b)) xor ci ;
	   co <= (si and (a and b)) or (ci and (si xor (a and b)));
        end if;
    end process wc_proc;

end architecture;
