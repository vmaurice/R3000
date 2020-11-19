LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity test is
end test ; 

architecture arch of test is

    signal tb_op : STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal tb_f : STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal tb_UALOp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal tb_Enable_V : STD_LOGIC;
    signal tb_Slt_Slti : STD_LOGIC;
    signal tb_Sel : STD_LOGIC_VECTOR(3 DOWNTO 0);

begin

    parallelregister : ENTITY WORK.UALControler port map(
        op          => tb_op,
        f           => tb_f,
        UALOp       => tb_UALOp,
        Enable_V    => tb_Enable_V,
        Slt_Slti    => tb_Slt_Slti,
        Sel         => tb_Sel);
    
    
    tb_UALOp <= "11", "10" after 10 ns, "11" after 50 ns, "00" after 70 ns; 
    tb_f <= "000000", "100000" after 15 ns, "000100" after 25 ns, "001010" after 35 ns, "000000" after 45 ns;
    tb_op <= "000000", "000010" after 45 ns;

    
end architecture ;