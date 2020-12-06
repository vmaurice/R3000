LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;

entity test is
end test ; 

architecture arch of test is

    constant clkpulse   : Time := 5 ns; -- 1/2 periode horloge
    constant TIMEOUT 	: time := 170 ns; -- timeout de la simulation
    
     
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

P_CHECK : process
begin
    wait for 60 ns;
    assert (tb_DMem_Dbus = x"00000005")
        report "Data bus wrong value, (5)"
        severity FAILURE;
    wait for 10 ns;
    assert (tb_DMem_Dbus = x"00000003")
        report "Data bus wrong value, (3)"
        severity FAILURE;
    wait for 25 ns;
    assert (tb_DMem_Dbus = x"00000008")
        report "Data bus wrong value, (5 + 3 = 8)"
        severity FAILURE;
    wait for 20 ns;
    assert (tb_DMem_Dbus = x"00000020")
        report "Data bus wrong value, (8 << 2 = 32)"
        severity FAILURE;
end process P_CHECK;



    r3000 : ENTITY WORK.r3000 port map(
        CLK         => tb_CLK,
        DMem_Abus   => tb_DMem_Abus,
        IMem_Abus   => tb_IMem_Abus,
        IMem_WR     => tb_IMem_WR,
        DMem_Dbus   => tb_DMem_Dbus,
        IMem_Dbus   => tb_IMem_Dbus,
        DMem_WR     => tb_DMem_WR );

    -- Instruction
    tb_IMem_Dbus <= x"00000000", 
                    x"241e0000" after 5 ns,     -- addiu    $fp, $zero, $zero 
                    x"24010005" after 15 ns,    -- addiu	$1, $zero, 5
                    x"afc10008" after 25 ns,    -- sw	    $1, 8($fp) 
                    x"24010003" after 35 ns,    -- addiu	$1, $zero, 3
                    x"afc10004" after 45 ns,    -- sw	    $1, 4($fp)
                    x"8fc10008" after 55 ns,    -- lw	    $1, 8($fp)
                    x"8fc20004" after 65 ns,    -- lw	    $2, 4($fp)
                    x"00220821" after 75 ns,    -- addu	    $1, $1, $2
                    x"afc10000" after 80 ns,    -- sw	    $1, 0($fp)
                    x"8fc10000" after 90 ns,    -- lw	    $1, 0($fp)
                    x"00010880" after 95 ns,    -- sll      $1, $1, 2
                    x"afc10000" after 100 ns,   -- sw	    $1, 0($fp)
                    x"8fc10000" after 110 ns,   -- lw   	$1, 0($fp)
                    x"28210040" after 120 ns,   -- slti	    $1, $1, 64
                    x"24020001" after 130 ns,   -- addiu    $2, $zero, 1
                    x"1022004A" after 140 ns;   -- beq   	$1, $2, 74  
    tb_IMem_WR <= '0';

    -- Data
    --tb_DMem_Dbus <= x"00000000"; 
    tb_DMem_WR <= '1', '0' after 25 ns, '1' after 35 ns, '0' after 45 ns, '1' after 150 ns;


end architecture ;