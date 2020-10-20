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
signal E_CLK			: STD_LOGIC;

signal rs             	: STD_LOGIC_VECTOR(4 DOWNTO 0);
signal tb_data_out_0    : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal rt             	: STD_LOGIC_VECTOR(4 DOWNTO 0);
signal tb_data_out_1    : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal rd          		: STD_LOGIC_VECTOR(4 DOWNTO 0);
signal data             : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal wr               : STD_LOGIC;


begin

--------------------------
-- definition de l'horloge
P_E_CLK: process
begin
	E_CLK <= '1';
	wait for clkpulse;
	E_CLK <= '0';
	wait for clkpulse;
end process P_E_CLK;

-----------------------------------------
-- definition du timeout de la simulation
P_TIMEOUT: process
begin
	wait for TIMEOUT;
	assert FALSE report "SIMULATION TIMEOUT!!!" severity FAILURE;
end process P_TIMEOUT;


    register_bank : ENTITY WORK.RegisterBank port map(
        source_register_0      => rs,      
		data_out_0             => tb_data_out_0,     
		source_register_1      => rt,      
		data_out_1             => tb_data_out_1,             
		destination_register   => rd,   
		data_in                => data,
		write_register         => wr,         
        clk                    => E_CLK );



	wr <= '1', '0' after 15 ns, '1' after 25 ns, '0' after 40 ns, '1' after 50 ns, '0' after 60 ns;
	data <= conv_std_logic_vector(23, data'length), conv_std_logic_vector(5, data'length) after 15 ns, conv_std_logic_vector(67, data'length) after 20 ns, conv_std_logic_vector(33, data'length) after 40 ns;
	rs <= "00000", "01000" after 10 ns, "00100" after 30 ns;
	rt <= "01000", "00010" after 15 ns, "11111" after 20 ns, "00000" after 50 ns;
	rd <= "01000", "00100" after 20 ns, "11111" after 25 ns, "00100" after 45 ns;

	
    
    



end architecture ;