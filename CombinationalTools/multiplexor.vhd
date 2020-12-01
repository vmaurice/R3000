LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
USE work.bus_mux_pkg.ALL;


ENTITY multiplexor_5 IS
	GENERIC 
	(
		mux_size : INTEGER := 5
	);
	PORT
	(
		input : IN bus_mux_array((2**mux_size)-1 DOWNTO 0);
		sel_input : IN STD_LOGIC_VECTOR(mux_size-1 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY multiplexor_5;


ARCHITECTURE multiplexor_5_arch of multiplexor_5 is
begin
    output <= input(conv_integer(sel_input));
	

END ARCHITECTURE multiplexor_5_arch;