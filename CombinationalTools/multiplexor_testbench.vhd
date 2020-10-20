LIBRARY IEEE;
LIBRARY WORK;


USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use WORK.bus_mux_pkg.ALL;

entity test is
end test ; 

architecture arch of test is

    constant mux_size		: positive := 2;

    signal inMul : bus_mux_array((2**mux_size)-1 DOWNTO 0);
	signal sel : STD_LOGIC_VECTOR(mux_size-1 DOWNTO 0);
	signal outMul : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin

    multiplexer : ENTITY WORK.multiplexor(multiplexor_arch) port map(input => inMul, sel_input => sel, output => outMul);
    inMul(2) <= conv_std_logic_vector(5,32), conv_std_logic_vector(3,32) after 10 ns, conv_std_logic_vector(1,32) after 30 ns;
    inMul(3) <= conv_std_logic_vector(2,32), conv_std_logic_vector(20,32) after 20 ns, conv_std_logic_vector(4,32) after 40 ns;
    sel <= conv_std_logic_vector(2,sel'length), conv_std_logic_vector(3,sel'length) after 15 ns; 
end architecture ;