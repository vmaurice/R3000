LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity test is
end test ; 

architecture arch of test is

    constant size : positive := 5;

    signal inDec : STD_LOGIC_VECTOR(size-1 DOWNTO 0);
    signal outDec : STD_LOGIC_VECTOR((2**size)-1 DOWNTO 0);

begin

    decodertest : ENTITY WORK.decoder(decoder_arch) port map(input => inDec, output => outDec);
    
P_DECODER : process

begin

    testDec : for i in 0 to 31 loop
        inDec <= conv_std_logic_vector(i,inDec'length);
        wait for 5 ns;
    end loop ; -- identifier

    assert FALSE report "SIMULATION TIMEOUT!!!" severity FAILURE;

end process P_DECODER; 
     
end architecture ;