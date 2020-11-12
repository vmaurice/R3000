LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity test is
end test ; 

architecture arch of test is

    signal tb_code_op : STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal tb_Saut : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal tb_EcrireMem_W : STD_LOGIC;
    signal tb_EcrireMem_H : STD_LOGIC;
    signal tb_EcrireMem_B : STD_LOGIC;
    signal tb_LireMem_W : STD_LOGIC;
    signal tb_LireMem_UH : STD_LOGIC;
    signal tb_LireMem_UB : STD_LOGIC;
    signal tb_LireMem_SH : STD_LOGIC;
    signal tb_LireMem_SB : STD_LOGIC;
    signal tb_B_ltz_ltzAl_gez_gezAl : STD_LOGIC;
    signal tb_B_gtz : STD_LOGIC;
    signal tb_B_lez : STD_LOGIC;
    signal tb_B_ne : STD_LOGIC;
    signal tb_B_eq : STD_LOGIC;
    signal tb_UALOp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal tb_UALSrc : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal tb_EcrireReg : STD_LOGIC;
    signal tb_RegDst : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal tb_OpExt : STD_LOGIC;
    signal tb_MemVersReg : STD_LOGIC_VECTOR(1 DOWNTO 0);

begin

    parallelregister : ENTITY WORK.InstructionDecoder(instructionDecoder_arch) port map(
        code_op                 =>  tb_code_op,
        saut                    =>  tb_Saut,
        EcrireMem_W             =>  tb_EcrireMem_W,
        EcrireMem_H             =>  tb_EcrireMem_H,
        EcrireMem_B             =>  tb_EcrireMem_B,
        LireMem_W               =>  tb_LireMem_W,
        LireMem_UH              =>  tb_LireMem_UH,
        LireMem_UB              =>  tb_LireMem_UB,
        LireMem_SH              =>  tb_LireMem_SH,
        LireMem_SB              =>  tb_LireMem_SB,
        B_ltz_ltzAl_gez_gezAl   =>  tb_B_ltz_ltzAl_gez_gezAl,
        B_gtz                   =>  tb_B_gtz,
        B_lez                   =>  tb_B_lez,
        B_ne                    =>  tb_B_ne,
        B_eq                    =>  tb_B_eq,
        UALOp                   =>  tb_UALOp,
        UALSrc                  =>  tb_UALSrc,
        EcrireReg                =>  tb_EcrireReg,
        RegDst                 =>  tb_RegDst,
        OpExt                   =>  tb_OpExt,
        MemVersReg              =>  tb_MemVersReg);
    
    
    
    tb_code_op <= "001000", "001001" after 10 ns, "001100" after 20 ns, "000100" after 30 ns, "000101" after 40 ns, "100100" after 50 ns, "100101" after 60 ns, "001111" after 70 ns, "110011" after 80 ns, "001100" after 90 ns, "001010" after 100 ns, "001011" after 110 ns, "101000" after 120 ns, "101001" after 130 ns, "101011" after 140 ns, "000000" after 150 ns;

end architecture ;