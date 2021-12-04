-- 64-bit Down Counter
-- https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity down_counter is
port (
  clk:    in  std_logic;
  n_rst:  in  std_logic;
  cout:   out std_logic_vector (63 downto 0)
);
end entity;

architecture behaviour of down_counter is
  signal cnt_down: std_logic_vector (63 downto 0);
begin
  process (clk, n_rst)
  begin
    if n_rst = '0' then
      cnt_down <= (others => '1');
    elsif rising_edge(clk) then
      cnt_down <= cnt_down - 1;
    end if;
  end process;

  cout <= cnt_down;
end architecture;
