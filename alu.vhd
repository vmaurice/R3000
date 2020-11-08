LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY CombinationalTools;
USE CombinationalTools.ALL;
USE CombinationalTools.bus_mux_pkg.ALL;
LIBRARY SequentialTools;
USE SequentialTools.ALL;


ENTITY ALU IS
	PORT
	(
		A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Enable_V : IN STD_LOGIC;
		ValDec : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Slt : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		Res : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		N : OUT STD_LOGIC;
		Z : OUT STD_LOGIC;
		C : OUT STD_LOGIC;
		V : OUT STD_LOGIC
	);
END ENTITY ALU;


ARCHITECTURE alu_arch of alu IS

    COMPONENT barrel_shifter IS
    PORT (
        input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		shift_amount : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		LeftRight : IN STD_LOGIC;
		LogicArith : IN STD_LOGIC;
		ShiftRotate : IN STD_LOGIC;
		output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
    END COMPONENT barrel_shifter;

    signal inputMult : bus_mux_array((2**3-1) DOWNTO 0);
    signal carry : STD_LOGIC_VECTOR(32 DOWNTO 0);
    signal tmp, B_tmp : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal c_tmp, v_tmp : STD_LOGIC;

BEGIN

    inputMult(0) <= A and B;
    inputMult(1) <= A or B;


    B_tmp <= B xor "11111111111111111111111111111111" when sel(3) = '1'
            else B;
    
    carry(0) <= sel(3);

    adder : for i in 0 to 31 generate
        inputMult(2)(i) <= A(i) xor B_tmp(i) xor carry(i);
        carry(i+1) <= ((A(i) xor B_tmp(i)) and carry(i)) or (A(i) and B_tmp(i));
    end generate ; -- adder



    v_tmp <= (carry(32) xor carry(31)) and not Slt and Enable_V when rising_edge(CLK);
    c_tmp <= sel(3) xor carry(32) when rising_edge(CLK);

    
    inputMult(3) <= conv_std_logic_vector('0', 32) when ((Enable_V and (inputMult(2)(31) xor v_tmp)) or ((not Enable_V) and c_tmp)) = '0'
            else conv_std_logic_vector('1', 32);
    
    
    inputMult(4) <= A nor B; 
    inputMult(5) <= A xor B; 

    barrel_shifter_inst0 : barrel_shifter
		PORT MAP(
            input => B,
            shift_amount => ValDec,
            LeftRight => '1',
            LogicArith => '0',
            ShiftRotate => '0',
            output => inputMult(6));

    barrel_shifter_inst1 : barrel_shifter
        PORT MAP(
            input => B,
            shift_amount => ValDec,
            LeftRight => '0',
            LogicArith => '0',
            ShiftRotate => '0',
            output => inputMult(7));
            
    Res <= inputMult(conv_integer(Sel(2 DOWNTO 0)));

    N <= inputMult(2)(31) when rising_edge(CLK);
    
    tmp(0) <= inputMult(conv_integer(Sel(2 DOWNTO 0)))(0);

    gen: for i in 1 to 31 generate
        tmp(i) <= tmp(i-1) nor inputMult(conv_integer(Sel(2 DOWNTO 0)))(i);
    end generate; 
    
    Z <= tmp(31) when rising_edge(CLK); 

    
    V <= (carry(32) xor carry(31)) and not Slt and Enable_V when rising_edge(CLK);
    C <= sel(3) xor carry(32) when rising_edge(CLK);

END alu_arch ; -- alu_arch