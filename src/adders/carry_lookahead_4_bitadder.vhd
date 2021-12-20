--n bit ripple carry adder
package carry_lookahead_4_bitadder_package  is
  constant BUS_WIDTH : integer := 4;
  --type input is array (0 to BUS_WIDTH-1) of bit;
end package;

library  ieee;
use ieee.numeric_std.all;
use  ieee.std_logic_1164.all;
use Work.carry_lookahead_4_bitadder_package.all;

entity carry_lookahead_4_bitadder is
 -- p => propogate
 -- g => generate
     port (a, b: in std_logic_vector(BUS_WIDTH-1 downto 0);
           c_in : in std_logic;
           sum: out std_logic_vector (BUS_WIDTH-1 downto 0);
           p_out, g_out: out std_logic;
           c_out: out std_logic);
end entity;

architecture behaviour of carry_lookahead_4_bitadder is
     signal g,p: std_logic_vector (BUS_WIDTH-1 downto 0) := (others => '0');
     signal c: signed (BUS_WIDTH downto 0) := (others => '0');
     signal s: std_logic_vector (BUS_WIDTH-1 downto 0) := (others => '0');
begin
             -- we obtain g and p signals outside this core
             g <= a and b;
             p <= a xor b;
             c(0) <= c_in;
             c(1) <= g(0) or (c(0) and p(0));
             c(2) <= g(1) or (g(0) and p(1)) or (c(0) and p(0) and p(1));
             c(3) <= g(2) or (g(1) and p(2)) or (g(0) and p(1) and p(2)) or (c(0) and p(0) and p(1) and p(2));
             c(4) <= g(3) or (c(3) and p(3));
             s(0) <= p(0) xor c(0);
             s(1) <= p(1) xor c(1);
             s(2) <= p(2) xor c(2);
             s(3) <= p(3) xor c(3);
             sum <= s;
             c_out <= c(BUS_WIDTH);
             -- propogate and generate signals
             g_out <= g(3) or (g(2) and g(3)) or (g(1) and p(2) and p(3)) or (g(0) and p(1) and p(2) and p(3)); 
             p_out <= p(0) and p(1) and p(2) and p(3);
end architecture;
