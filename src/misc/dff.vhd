-- VHDL code for D Flip FLop
-- VHDL code for rising edge D flip flop 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity D_FLIPFLOP_SOURCE is
Port ( D, CLK, RST : in STD_LOGIC;
Q, Qb : out STD_LOGIC);
end D_FLIPFLOP_SOURCE;



architecture d_flip_flop_arc of D_FLIPFLOP_SOURCE is    
begin
    dff : process (D,CLK,RST) is
    begin
        if (RST='1') then
            Q <= '0';
        elsif (rising_edge (CLK)) then
            Q <= D;
            Qb <= not D;
        end if;
    end process dff;
end d_flip_flop_arc;

