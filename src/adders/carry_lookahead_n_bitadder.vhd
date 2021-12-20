--n bit ripple carry adder
package carry_lookahead_n_bitadder_package  is
  constant BUS_WIDTH : integer := 16;
  constant BUS_WIDTH1 : integer := 4;
  --type input is array (0 to BUS_WIDTH-1) of bit;
end package;

-- 32-bit adder
library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use Work.carry_lookahead_n_bitadder_package.all;

entity carry_lookahead_n_bitadder is
     port (p, g: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
	   clk:    in  std_logic;
	   n_rst:  in  std_logic;
           sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
           z, n: out std_logic;
           c_out, v: out std_logic);
end entity;

architecture behaviour of carry_lookahead_n_bitadder is
     signal p_sig, g_sig: std_logic_vector(BUS_WIDTH-1 downto 0);
     signal c_sig: signed (BUS_WIDTH downto 0) := (others => '0');
     signal sum_temp:  std_logic_vector (BUS_WIDTH-1 downto 0) := (others => '0');
     signal neg: std_logic := '0';
     --constant zeros : std_logic_vector(c'range-1) := (others => '0');
     constant zeros : std_logic_vector(BUS_WIDTH-1 downto 0) := (others => '0');
     signal ready: std_logic;
component carry_lookahead_4_bitadder
 -- p => propogate
 -- g => generate
     port (a, b: in std_logic_vector(BUS_WIDTH1-1 downto 0);
           c_in : in std_logic;
           sum: out std_logic_vector (BUS_WIDTH1-1 downto 0);
           p_out, g_out: out std_logic;
           c_out: out std_logic);

end component;
begin
           c_sig(0)<=c_in;
           g_sig <= g;
           p_sig <= p;

full_adder0:
--for I in 0 to BUS_WIDTH-1 generate
for I in 0 to (BUS_WIDTH/BUS_WIDTH1)-1 generate
           carry_lookahead_4_bitadder0: carry_lookahead_4_bitadder
                port map (a=>g_sig(4*I+3 downto 4*I), b=>p_sig(4*I+3 downto 4*I), c_in=>c_sig(4*I), sum=>sum_temp(4*I+3 downto 4*I), c_out=>c_sig(4*I+3+1));
end generate;
           process(clk,n_rst,c_sig,sum_temp)
           begin
           if n_rst = '0' then
             v <='0';
             n <= '0';
             z <= '0';
             c_out <= '0';
             sum <= (others => '0');
             ready <= '0';
           elsif rising_edge(clk) then
             v <= c_sig(BUS_WIDTH-1) xor c_sig(BUS_WIDTH);
             c_out <= c_sig(BUS_WIDTH);
             sum <= sum_temp;
             n <= sum_temp(BUS_WIDTH-1);
             if sum_temp = zeros then
                z <= '1';
             else
                z <= '0';
             end if;
             ready <= '1';
           end if;
           end process;
end architecture;
