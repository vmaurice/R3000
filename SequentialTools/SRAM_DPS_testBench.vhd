LIBRARY IEEE;
LIBRARY WORK;


USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use WORK.bus_mux_pkg.ALL;

entity test is
end test ; 

architecture arch of test is

    constant clkpulse   : Time := 5 ns; -- 1/2 periode horloge
    constant TIMEOUT 	: time := 150 ns; -- timeout de la simulation

    constant address_width  : NATURAL := 32;
	constant data_bus_width : NATURAL := 32;
    
     
	signal tb_address : STD_LOGIC_VECTOR(address_width-1 DOWNTO 0);
	signal tb_data_in : STD_LOGIC_VECTOR(data_bus_width-1 DOWNTO 0); 
	signal tb_data_out : STD_LOGIC_VECTOR(data_bus_width-1 DOWNTO 0); 
	signal tb_WE, tb_CS, tb_OE, tb_CLK : STD_LOGIC;

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



    multiplexer : ENTITY WORK.SRAM_DPS port map(
        address     => tb_address, 
        data_in     => tb_data_in,
        data_out    => tb_data_out,
        WE          => tb_WE,
        CS          => tb_CS,
        OE          => tb_OE,
        CLK         => tb_CLK);


    tb_address <= x"00000000", conv_std_logic_vector(3, tb_address'length) after 10 ns, conv_std_logic_vector(6, tb_address'length) after 70 ns;
    tb_data_in <= x"00000000", conv_std_logic_vector(68, tb_address'length) after 10 ns, conv_std_logic_vector(128, tb_address'length) after 70 ns;
    tb_WE <= '0', '1' after 20 ns, '0' after 60 ns;
    tb_CS <= '1', '0' after 10 ns, '1' after 40 ns, '0' after 50 ns;
    tb_OE <= '1', '0' after 25 ns, '1' after 40 ns;


end architecture ;