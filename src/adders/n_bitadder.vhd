--n bit ripple carry adder
package n_bitadder_package  is
  constant BUS_WiDTH : integer := 32;
  --type input is array (0 to BUS_WiDTH-1) of bit;
end package;

-- 32-bit adder
library  ieee;
use  ieee.std_logic_1164.all;
use Work.n_bitadder_package.all;

entity n_bitadder is
     port (a, b: in std_logic_vector(BUS_WiDTH-1 downto 0);
           c_in : in std_logic;
                sum: out std_logic_vector (BUS_WiDTH-1 downto 0);
                c_out, v: out std_logic);
end entity;

architecture behaviour of n_bitadder is
     signal c: std_logic_vector (BUS_WiDTH downto 0);
component FULLADDER
           port(a, b, c: in std_logic;
		sum, carry: out std_logic);
end component;
begin
           c(0)<=c_in;
full_adder:
for I in 0 to BUS_WiDTH-1 generate
           FULL_ADDER0: FULLADDER
                port map (a(I), b(I), c(I), sum(I), c(I+1));
end generate;
           v <= c(BUS_WiDTH-1) xor c(BUS_WiDTH);
           c_out <= c(BUS_WiDTH);
end architecture;
