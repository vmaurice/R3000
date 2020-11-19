LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY CombinationalTools;
USE CombinationalTools.bus_mux_pkg.ALL;
LIBRARY SequentialTools;
USE SequentialTools.ALL;

ENTITY Extension IS
	PORT
	(
		OpExt : IN STD_LOGIC;
		inst : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY Extension;

architecture Extension_arch of Extension is


begin

    output <= inst & x"ffff" when (inst(15) and OpExt) = '1'
            else inst & x"0000";
    


end Extension_arch ; -- Extension_arch