-- 64-bit Down Counter Custom
-- https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity down_counter_custom is
port (
  clk:    in  std_logic;
  n_rst:  in  std_logic;
  cnt_stop: in std_logic;
  load_enable: in std_logic;
  load_data: in std_logic_vector(63 downto 0);
  cout:   out std_logic_vector (63 downto 0)
);
end entity;

architecture behaviour of down_counter_custom is
  signal cnt_down: std_logic_vector (63 downto 0);
begin
  process (clk, n_rst, cnt_stop)
  begin
    if n_rst = '0' then
      cnt_down <= (others => '1');
    elsif rising_edge(clk) then
       if load_enable = '1' then
	  cnt_down <= load_data;
       else
	  if cnt_stop /= '1' then
             cnt_down <= cnt_down - 1;
          else   
             cnt_down <= cnt_down;
	  end if;	  

       end if;
    end if;
  end process;

  cout <= cnt_down;
end architecture;
