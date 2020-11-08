LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;


entity test is
end test ; 

architecture arch of test is

-- definition de constantes
constant clkpulse   : Time := 5 ns; -- 1/2 periode horloge
constant TIMEOUT 	: time := 150 ns; -- timeout de la simulation

-- definition de ressources externes
signal tb_A : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_B : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_sel : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal tb_Enable_V : STD_LOGIC;
signal tb_ValDec : STD_LOGIC_VECTOR(4 DOWNTO 0);
signal tb_Slt : STD_LOGIC;
signal tb_CLK : STD_LOGIC;
signal tb_Res : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_N : STD_LOGIC;
signal tb_Z : STD_LOGIC;
signal tb_C : STD_LOGIC;
signal tb_V : STD_LOGIC;


begin

--------------------------
-- definition de l'horloge
P_E_CLK: process
begin
	tb_CLK <= '1';
	wait for clkpulse;
	tb_CLK <= '0';
	wait for clkpulse;
end process P_E_CLK;

-----------------------------------------
-- definition du timeout de la simulation
P_TIMEOUT: process
begin
	wait for TIMEOUT;
	assert FALSE report "SIMULATION TIMEOUT!!!" severity FAILURE;
end process P_TIMEOUT;


    register_bank : ENTITY WORK.ALU port map(
        A           => tb_A,         
		B           => tb_B,
        sel         => tb_sel,
		Enable_V    => tb_Enable_V,
		ValDec      => tb_ValDec,
		Slt         => tb_Slt,
		CLK         => tb_clk,
		Res         => tb_Res,
		N           => tb_N,
		Z           => tb_Z,
		C           => tb_C,
        V           => tb_V );
        

    tb_A <= conv_std_logic_vector(8, tb_A'length), conv_std_logic_vector(64, tb_A'length) after 30 ns, conv_std_logic_vector(256, tb_A'length) after 50 ns, conv_std_logic_vector(2**28, tb_A'length) after 70 ns;
    tb_B <= conv_std_logic_vector(4, tb_B'length), conv_std_logic_vector(128, tb_A'length) after 40 ns, conv_std_logic_vector(1024, tb_A'length) after 60 ns, conv_std_logic_vector(2**31-1, tb_A'length) after 70 ns;
    tb_sel <= "0000", "0010" after 10 ns, "1010" after 40 ns, "0011" after 50 ns, "1011" after 60 ns, "0111" after 80 ns;
	tb_ValDec <= "00010";
	tb_Slt <= '0', '1' after 70 ns, '0' after 80 ns;
	tb_Enable_V <= '0', '1' after 70 ns;


end architecture ;