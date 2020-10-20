LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

---- Decoder


ENTITY decoder IS
	GENERIC 
	(
		dec_size : INTEGER :=5
	);
	PORT
	(
		input : IN STD_LOGIC_VECTOR(dec_size-1 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR((2**dec_size)-1 DOWNTO 0)
	);
END ENTITY decoder;

ARCHITECTURE decoder_arch of decoder is
begin
	output <= STD_LOGIC_VECTOR(to_unsigned(1, output'length) sll to_integer(unsigned(input)));


END ARCHITECTURE decoder_arch;
