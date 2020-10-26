LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;


entity test is
end test ; 

architecture arch of test is

-- definition de constantes
constant TIMEOUT 	: time := 150 ns; -- timeout de la simulation
constant shift_size : INTEGER := 5;
constant shifter_width : INTEGER := 32;

-- definition de ressources externes
signal inB : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal nbshift : STD_LOGIC_VECTOR(shift_size-1 DOWNTO 0);
signal left : STD_LOGIC;
signal logic : STD_LOGIC;
signal rotate : STD_LOGIC;
signal outB : STD_LOGIC_VECTOR(31 DOWNTO 0);


begin

-----------------------------------------
-- definition du timeout de la simulation
P_TIMEOUT: process
begin
	wait for TIMEOUT;
	assert FALSE report "SIMULATION TIMEOUT!!!" severity FAILURE;
end process P_TIMEOUT;


    register_bank : ENTITY WORK.barrel_shifter port map(
        input           => inB,     
		shift_amount    => nbshift,
		LeftRight       => left, 
		LogicArith      => logic, 
		ShiftRotate     => rotate, 
        output          => outB);   
        

    inB <= conv_std_logic_vector(8, inB'length), conv_std_logic_vector(32, inB'length) after 20 ns, conv_std_logic_vector(4, inB'length) after 40 ns;
    nbshift <= "00010";
    left <= '0';
    logic <= '0';
    rotate <= '0';
    



	

	
    
    



end architecture ;