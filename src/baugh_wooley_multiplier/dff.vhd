-- vhdl code for d flip flop
-- vhdl code for rising edge d flip flop 
library ieee;
use ieee.std_logic_1164.all;

entity dff is
port ( d, clk, n_rst : in std_logic;
q : out std_logic);
end dff;



architecture dff_arch of dff is    
begin
    dff1 : process (d,clk,n_rst) is
    begin
        if (n_rst='0') then
            q <= '0';
        elsif (rising_edge (clk)) then
            q <= d;
        end if;
    end process dff1;
end dff_arch;
