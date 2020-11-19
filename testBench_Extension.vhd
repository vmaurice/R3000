LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity test is
end test ; 

architecture arch of test is

    signal tb_OpExt : STD_LOGIC;
	signal tb_inst : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal tb_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
    

begin

    parallelregister : ENTITY WORK.Extension port map(
       OpExt    => tb_OpExt,
       inst     => tb_inst,
       output   => tb_output);


    tb_OpExt <= '0', '1' after 10 ns, '0' after 30 ns, '1' after 40 ns, '0' after 60 ns;
    tb_inst <= x"0000", x"A74C" after 10 ns, x"ffff" after 20 ns, x"7fff" after 40 ns;
    
       
    

    
end architecture ;