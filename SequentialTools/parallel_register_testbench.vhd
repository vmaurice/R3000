LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity test is
end test ; 

architecture arch of test is

    constant register_size : integer := 32;

    
    signal wr           : STD_LOGIC;
	signal data_in      : STD_LOGIC_VECTOR(register_size-1 DOWNTO 0);
	signal data_out     : STD_LOGIC_VECTOR(register_size-1 DOWNTO 0);

begin

    parallelregister : ENTITY WORK.parallel_register(parallel_register_arch) port map(data_in => data_in, data_out => data_out, wr => wr);
    data_in <= conv_std_logic_vector(5,register_size), conv_std_logic_vector(8,register_size) after 20 ns, conv_std_logic_vector(13,register_size) after 30 ns, conv_std_logic_vector(54,register_size) after 40 ns;
    wr <= '0', '1' after 15 ns, '0' after 20 ns, '1' after 30 ns, '0' after 45 ns, '1' after 60 ns; 
end architecture ;