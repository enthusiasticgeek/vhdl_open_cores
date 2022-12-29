--  pu
library  ieee;
use  ieee.std_logic_1164.all;
-- definition of a pu
entity pu is
     port (a, ci, b, clk, n_rst, s: in std_logic;
           co, r: out std_logic);
end entity;
architecture behaviour of pu is
     signal w: std_logic_vector (1 downto 0) := (others => '0');
begin
    pu_proc : process (a,b,ci,clk,n_rst,s) is
    begin
        if (n_rst='0') then
            r <= '0';
            co <= '0';
        elsif (rising_edge (clk)) then
            w(1) <= (a xor (not b)) xor ci ;
            w(0) <= a;
	    co <= (a and (not b)) or (ci and (a xor (not b)));
	    if s = '0' then
	      r <= w(0);
	    else
	      r <= w(1);
	    end if;
        end if;
    end process pu_proc;
end architecture;
