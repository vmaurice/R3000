LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity test is
end test ; 

architecture arch of test is

    signal tb_B_ltz_ltzAl_gez_gezAl : STD_LOGIC;
    signal tb_B_gtz : STD_LOGIC;
    signal tb_B_lez : STD_LOGIC;
    signal tb_B_ne : STD_LOGIC;
    signal tb_B_eq : STD_LOGIC;
    signal tb_N : STD_LOGIC;
    signal tb_Z : STD_LOGIC;
    signal tb_rt0 : STD_LOGIC;
    signal tb_CPSrc : STD_LOGIC;

begin

    parallelregister : ENTITY WORK.CpMuxControler port map(
        B_ltz_ltzAl_gez_gezAl   => tb_B_ltz_ltzAl_gez_gezAl,
        B_gtz                   => tb_B_gtz,
        B_lez                   => tb_B_lez,
        B_ne                    => tb_B_ne,
        B_eq                    => tb_B_eq,
        N                       => tb_N,
        Z                       => tb_Z,
        rt0                     => tb_rt0,
        CPSrc                   => tb_CPSrc);
    
        tb_B_ltz_ltzAl_gez_gezAl <= '0', '1' after 80 ns;
        tb_B_gtz <= '0';
        tb_B_lez <= '0', '1' after 20 ns;
        tb_B_ne <= '0';
        tb_B_eq <= '0', '1' after 5 ns, '0' after 15 ns;
        tb_N <= '0', '1' after 20 ns;
        tb_Z <= '0', '1' after 10 ns;
        tb_rt0 <= '0';
    

    
end architecture ;