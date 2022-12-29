--  full adder
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of a full adder
entity fa is
     port (a, ci, b, clk, n_rst: in std_logic;
           co, so: out std_logic);
end entity;
architecture behaviour of fa is
begin
    fa_proc : process (a,b,ci,clk,n_rst) is
    begin
        if (n_rst='0') then
            so <= '0';
            co <= '0';
        elsif (rising_edge (clk)) then
            so <= (a xor b) xor ci ;
	    co <= (a and b) or (ci and (a xor b));
        end if;
    end process fa_proc;
end architecture;

 
