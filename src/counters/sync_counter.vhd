-- 32-bit Up/Down Counter Custom
-- https://github.com/enthusiasticgeek/vhdl_open_cores
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sync_counter is
port (
  clk:    in  std_logic;
  n_rst:  in  std_logic;
  cnt_stop: in std_logic;
  is_up: in std_logic;
  load_enable: in std_logic;
  load_data: in std_logic_vector(31 downto 0);
  cout:   out std_logic_vector (31 downto 0);
  overflow, underflow:   out std_logic
);
end entity;

architecture behaviour of sync_counter is
  signal cnt: signed(31 downto 0);
begin
	process (clk, n_rst, cnt_stop, is_up)
  begin
    if n_rst = '0' then
      cnt <= (others => '0');
      overflow <= '0';
      underflow <= '0';
    elsif rising_edge(clk) then
       if load_enable = '1' then
	  cnt <= signed(load_data);
       else
	  if cnt_stop /= '1' then
             if is_up = '1' then
                cnt <= signed(cnt) + 1;
		if cnt > (x"FFFFFFFF") then
                   overflow <= '1';
		end if;
	     else
                cnt <= signed(cnt) - 1;
		if cnt < 0 then
                   underflow <= '1';
		end if;
	     end if;	     
          else   
             cnt <= cnt;
	  end if;	  
       end if;
    end if;
  end process;

  cout <= std_logic_vector(cnt);
end architecture;
