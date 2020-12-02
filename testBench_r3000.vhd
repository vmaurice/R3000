LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;

entity test is
end test ; 

architecture arch of test is

    constant clkpulse   : Time := 5 ns; -- 1/2 periode horloge
    constant TIMEOUT 	: time := 100 ns; -- timeout de la simulation
    
     
	signal tb_CLK : STD_LOGIC;
	signal tb_DMem_Abus, tb_IMem_Abus : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal tb_IMem_WR : STD_LOGIC;
	signal tb_DMem_Dbus, tb_IMem_Dbus : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal tb_DMem_WR : STD_LOGIC;

begin

--------------------------
-- definition de l'horloge
P_TB_CLK: process
begin
	tb_CLK <= '1';
	wait for clkpulse;
	tb_CLK <= '0';
	wait for clkpulse;
end process P_TB_CLK;

-----------------------------------------
-- definition du timeout de la simulation
P_TIMEOUT: process
begin
	wait for TIMEOUT;
	assert FALSE report "SIMULATION TIMEOUT!!!" severity FAILURE;
end process P_TIMEOUT;



    r3000 : ENTITY WORK.r3000 port map(
        CLK         => tb_CLK,
        DMem_Abus   => tb_DMem_Abus,
        IMem_Abus   => tb_IMem_Abus,
        IMem_WR     => tb_IMem_WR,
        DMem_Dbus   => tb_DMem_Dbus,
        IMem_Dbus   => tb_IMem_Dbus,
        DMem_WR     => tb_DMem_WR );

    -- Instruction
    tb_IMem_Dbus <= x"00000000", x"24010005" after 5 ns, x"ac010008" after 15 ns, x"24010002" after 25 ns, x"ac010004" after 35 ns, x"8c010008" after 45 ns, x"8c020004" after 55 ns, x"00220821" after 65 ns, x"ac010000" after 70 ns;
    tb_IMem_WR <= '0';

    -- Data
    --tb_DMem_Dbus <= x"00000000"; 
    tb_DMem_WR <= '1', '0' after 15 ns, '1' after 25 ns, '0' after 35 ns, '1' after 100 ns;


end architecture ;