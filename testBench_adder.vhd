LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity test is
end test ; 

architecture arch of test is


    signal tb_op_0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal tb_op_1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal tb_sum : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal tb_C :  STD_LOGIC;

begin

    parallelregister : ENTITY WORK.Adder port map(
        op_0    => tb_op_0,
        op_1    => tb_op_1,
        sum     => tb_sum,
        C       => tb_C);
    
    
    tb_op_0 <= x"00000000", x"0000f000" after 10 ns, x"0000f000" after 20 ns, x"0000f000" after 30 ns, x"ffffffff" after 40 ns, x"00000000" after 60 ns;
    tb_op_1 <= x"00000000", x"00fff000" after 10 ns, x"00a0f000" after 20 ns, x"0000f001" after 30 ns, x"ffffffff" after 40 ns, x"00000000" after 60 ns;


    
end architecture ;