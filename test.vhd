LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY test_1 IS
	GENERIC
	(
		register_size : INTEGER := 32
	);
		PORT 
	(
		wr : IN STD_LOGIC;
		data_in : IN STD_LOGIC_VECTOR(register_size-1 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR(register_size-1 DOWNTO 0)
	);
END ENTITY test_1;


ARCHITECTURE test_1_arch of test_1 IS

    signal tmp, tmp2 : std_logic_vector(31 DOWNTO 0); 

BEGIN 

    tmp2 <= conv_std_logic_vector(5, 32);
    tmp <= (others=>'1');
    tmp <= tmp xor tmp2;


END ARCHITECTURE test_1_arch;