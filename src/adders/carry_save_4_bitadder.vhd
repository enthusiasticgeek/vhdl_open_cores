--4 bit carry save adder
package carry_save_4_bitadder_package  is
  constant BUS_WIDTH : integer := 4;
  --type input is array (0 to BUS_WIDTH-1) of bit;
end package;

-- 4-bit adder
library  ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.carry_save_4_bitadder_package.all;

entity carry_save_4_bitadder is
     port (a, b, c_in: in std_logic_vector(BUS_WIDTH-1 downto 0);
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           sum: out std_logic_vector (BUS_WIDTH downto 0);
           c_out: out std_logic);
end entity;

architecture behaviour of carry_save_4_bitadder is
     signal c_stage1: signed (BUS_WIDTH-1 downto 0) := (others => '0');
     signal c_stage2: signed (BUS_WIDTH downto 0) := (others => '0');
     signal sum_temp_stage1:  std_logic_vector (BUS_WIDTH downto 0) := (others => '0');
     signal sum_temp_stage2:  std_logic_vector (BUS_WIDTH downto 0) := (others => '0');
     --constant zeros : std_logic_vector(c'range-1) := (others => '0');
     constant zeros : std_logic_vector(BUS_WIDTH-1 downto 0) := (others => '0');
component FULLADDER
           port(a, b, c: in std_logic;
		sum, carry: out std_logic);
end component;
begin
--stage 1 full independent full adders
full_adder:
for I in 0 to BUS_WIDTH-1 generate
           FULL_ADDER0: FULLADDER
                port map (a(I), b(I), c_in(I), sum_temp_stage1(I), c_stage1(I));
end generate;
--stage 2 -> feed into 4 bit ripple carry
           sum_temp_stage2(0) <= sum_temp_stage1(0);
           sum_temp_stage1(BUS_WIDTH) <= '0';
           c_stage2(0) <= '0';
ripple_carry_adder:
for I in 0 to BUS_WIDTH-1 generate
           FULL_ADDER1: FULLADDER
                port map (c_stage1(I), sum_temp_stage1(I+1), c_stage2(I), sum_temp_stage2(I+1), c_stage2(I+1));
end generate;

           process(clk,n_rst,c_stage1, c_stage2,sum_temp_stage1, sum_temp_stage2)
           begin
           if n_rst = '0' then
             c_out <= '0';
             sum <= (others => '0');
           elsif rising_edge(clk) then
             c_out <= c_stage2(BUS_WIDTH);
             sum <= sum_temp_stage2;
           end if;
           end process;
end architecture;
