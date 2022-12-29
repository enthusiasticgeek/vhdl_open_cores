-- VHDL code for D Flip FLop
-- VHDL code for rising edge D flip flop 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity d_flip_flop is
     port(
         clk : in STD_LOGIC;
         din : in STD_LOGIC;
         reset : in STD_LOGIC;
         dout : out STD_LOGIC
         );
end d_flip_flop;

architecture d_flip_flop_arc of d_flip_flop is    
begin

    dff : process (din,clk,reset) is
    begin
        if (reset='1') then
            dout <= '0';
        elsif (rising_edge (clk)) then
            dout <= din;
        end if;
    end process dff;


end d_flip_flop_arc;

