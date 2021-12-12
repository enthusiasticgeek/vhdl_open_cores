--n bit ripple carry adder
package signed_n_bitadder_package  is
  constant BUS_WIDTH : integer := 32;
  --type input is array (0 to BUS_WIDTH-1) of bit;
end package;

-- 32-bit adder
library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use Work.signed_n_bitadder_package.all;

entity signed_n_bitadder is
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
	  clk:    in  std_logic;
	  n_rst:  in  std_logic;
                sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
                z, n: out std_logic;
                c_out, v: out std_logic);
end entity;

architecture behaviour of signed_n_bitadder is
     signal c: signed (BUS_WIDTH downto 0) := (others => '0');
     signal sum_temp:  std_logic_vector (BUS_WIDTH-1 downto 0) := (others => '0');
     signal neg: std_logic := '0';
     --constant zeros : std_logic_vector(c'range-1) := (others => '0');
     constant zeros : std_logic_vector(BUS_WIDTH-1 downto 0) := (others => '0');
component FULLADDER
           port(a, b, c: in std_logic;
		sum, carry: out std_logic);
end component;
begin
           c(0)<=c_in;
full_adder:
for I in 0 to BUS_WIDTH-1 generate
           FULL_ADDER0: FULLADDER
                port map (a(I), b(I), c(I), sum_temp(I), c(I+1));
end generate;
           process(clk,n_rst,c,sum_temp)
           begin
           if n_rst = '0' then
             v <='0';
             n <= '0';
             z <= '0';
             c_out <= '0';
             sum <= (others => '0');
           elsif rising_edge(clk) then
             v <= c(BUS_WIDTH-1) xor c(BUS_WIDTH);
             c_out <= c(BUS_WIDTH);
             sum <= sum_temp;
             n <= sum_temp(BUS_WIDTH-1);
             if sum_temp = zeros then
                z <= '1';
             else
                z <= '0';
             end if;
           end if;
           end process;
end architecture;
