LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY adder IS
	GENERIC 
	(
		word_size : INTEGER :=32
	);
	PORT
	(
		op_0 : IN STD_LOGIC_VECTOR(word_size-1 DOWNTO 0);
		op_1 : IN STD_LOGIC_VECTOR(word_size-1 DOWNTO 0);
		sum : OUT STD_LOGIC_VECTOR(word_size-1 DOWNTO 0);
		C : OUT STD_LOGIC
	);
END ENTITY adder;

ARCHITECTURE adder_arch of adder IS

    signal carry : STD_LOGIC_VECTOR(32 DOWNTO 0);

BEGIN

    carry(0) <= '0';

    adder_inst : for i in 0 to 31 generate
        sum(i) <= op_0(i) xor op_1(i) xor carry(i);
        carry(i+1) <= ((op_0(i) xor op_1(i)) and carry(i)) or (op_0(i) and op_1(i));
    end generate ; -- adder_inst

    C <= carry(32);

END adder_arch ; -- adder_arch