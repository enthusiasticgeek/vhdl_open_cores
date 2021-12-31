--n bit ripple carry adder
package carry_select_4_bitadder_package  is
  constant BUS_WIDTH : integer := 4;
  --type input is array (0 to BUS_WIDTH-1) of bit;
end package;

library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use Work.carry_select_4_bitadder_package.all;

entity carry_select_4_bitadder is
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
           sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
           c_out: out std_logic);
end entity;

architecture behaviour of carry_select_4_bitadder is
component FULLADDER is
     port (a, b, c: in std_logic;
           sum, carry: out std_logic);
end component;

component mux_2_to_1
port(
a,b : in std_logic;
Sel: in std_logic;
o: out std_logic
);
end component;

     signal c0: signed (BUS_WIDTH downto 0) := (others => '0');
     signal s0: std_logic_vector (BUS_WIDTH-1 downto 0) := (others => '0');
     signal c1: signed (BUS_WIDTH downto 0) := (others => '0');
     signal s1: std_logic_vector (BUS_WIDTH-1 downto 0) := (others => '0');
begin

           c0(0)<='0';
full_adder0_0:
for I in 0 to BUS_WiDTH-1 generate
           FULL_ADDER0: FULLADDER
                port map (a(I), b(I), c0(I), s0(I), c0(I+1));
end generate;
           c1(0)<='1';
full_adder1_0:
for I in 0 to BUS_WiDTH-1 generate
           FULL_ADDER0: FULLADDER
                port map (a(I), b(I), c1(I), s1(I), c1(I+1));
end generate;
sum_mux_0:
for I in 0 to BUS_WiDTH-1 generate
           SUM_MUX: mux_2_to_1
                port map (s0(I), s1(I), c_in, sum(I));
end generate;
           CARRY_MUX: mux_2_to_1
                port map (c0(BUS_WIDTH-1), c1(BUS_WIDTH-1), c_in, c_out);

end architecture;
