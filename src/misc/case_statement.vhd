-- demo case statement
-- https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity case_statement is
port (
  bit0: in std_logic;
  bit1: in std_logic;
  bit2: in std_logic;
  bit3: in std_logic;
  cout: out std_logic_vector (3 downto  0)
);
end entity;

architecture behaviour of case_statement is
  signal test: signed(3 downto  0);
begin



process(bit0,bit1,bit2,bit3)
   variable bitcat : std_logic_vector(3 downto 0);
begin
   bitcat := bit0 & bit1 & bit2 & bit3; --concatenation
   case bitcat is
      when "0001" => test <= to_signed(1, cout'length);
      when "0010" => test <= to_signed(2, cout'length);
      when "0011" => test <= to_signed(3, cout'length);
      when others => test <= to_signed(4, cout'length);
   end case;
end process;
  cout <= std_logic_vector(test);
end architecture;
