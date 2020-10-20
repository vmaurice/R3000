
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY parallel_register IS
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
END ENTITY parallel_register;


ARCHITECTURE parallel_register_arch of parallel_register IS

BEGIN 

data_out <= data_in when wr = '1';


END ARCHITECTURE parallel_register_arch;