LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


LIBRARY CombinationalTools;
USE CombinationalTools.bus_mux_pkg.ALL;
LIBRARY SequentialTools;
USE SequentialTools.ALL;

ENTITY InstructionDecoder IS
	PORT
	(
		code_op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		Saut : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		EcrireMem_W : OUT STD_LOGIC;
		EcrireMem_H : OUT STD_LOGIC;
		EcrireMem_B : OUT STD_LOGIC;
		LireMem_W : OUT STD_LOGIC;
		LireMem_UH : OUT STD_LOGIC;
		LireMem_UB : OUT STD_LOGIC;
		LireMem_SH : OUT STD_LOGIC;
		LireMem_SB : OUT STD_LOGIC;
		B_ltz_ltzAl_gez_gezAl : OUT STD_LOGIC;
		B_gtz : OUT STD_LOGIC;
		B_lez : OUT STD_LOGIC;
		B_ne : OUT STD_LOGIC;
		B_eq : OUT STD_LOGIC;
		UALOp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		UALSrc : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		EcrireReg : OUT STD_LOGIC;
		RegDst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		OpExt : OUT STD_LOGIC;
		MemVersReg : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END ENTITY InstructionDecoder;


ARCHITECTURE instructionDecoder_arch of InstructionDecoder IS

    signal outDec : std_logic_vector( (2**code_op'length -1) DOWNTO 0);

BEGIN

    -- decoder
    outDec <= STD_LOGIC_VECTOR(to_unsigned(1, outDec'length) sll to_integer(unsigned(code_op)));

    OpExt <= outDec(1) or outDec(4) or outDec(5) or outDec(6) or outDec(7) or outDec(8) or outDec(10) or outDec(32) or outDec(33) or outDec(35) or outDec(36) or outDec(37) or outDec(40) or outDec(41) or outDec(43);

    RegDst(1) <= outDec(1) or outDec(3);
    RegDst(0) <= outDec(0);

    UALSrc(1) <= outDec(1) or outDec(15);
    UALSrc(0) <= outDec(8) or outDec(9) or outDec(10) or outDec(11) or outDec(12) or outDec(13) or outDec(14) or outDec(15) or outDec(32) or outDec(33) or outDec(35) or outDec(36) or outDec(37);
    
    MemVersReg(1) <= outDec(0) or outDec(1) or outDec(3);
    MemVersReg(0) <= outDec(32) or outDec(33) or outDec(35) or outDec(36) or outDec(37);

    EcrireReg <= outDec(0) or outDec(1) or outDec(3) or outDec(8) or outDec(9) or outDec(10) or outDec(11) or outDec(12) or outDec(13) or outDec(14) or outDec(15) or outDec(32) or outDec(33) or outDec(35) or outDec(36) or outDec(37);
     
    LireMem_SB <= outDec(32);
    LireMem_SH <= outDec(33);
    LireMem_W <= outDec(35);
    LireMem_UB <= outDec(36);
    LireMem_UH <= outDec(37);


    EcrireMem_B <= outDec(40);
	EcrireMem_H <= outDec(41);
    EcrireMem_W <= outDec(43);


    B_eq <= outDec(4);
    B_ne <= outDec(5);
    B_lez <= outDec(6);
    B_gtz <= outDec(7);

    B_ltz_ltzAl_gez_gezAl <= outDec(1);

    Saut(1) <= outDec(0);
    Saut(0) <= outDec(2) or outDec(3);

    UALOp(1) <= outDec(0) or outDec(8) or outDec(9) or outDec(10) or outDec(11) or outDec(12) or outDec(13) or outDec(14) or outDec(15);
    UALOp(0) <= outDec(1) or outDec(4) or outDec(5) or outDec(6) or outDec(7) or outDec(8) or outDec(9) or outDec(10) or outDec(11) or outDec(12) or outDec(13) or outDec(14) or outDec(15);

    

    
    

END instructionDecoder_arch  ; -- instructionDecoder_arch 