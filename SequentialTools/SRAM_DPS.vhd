LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


PACKAGE bus_mux_pkg IS
	TYPE bus_mux_array IS ARRAY(NATURAL RANGE<>) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
END PACKAGE bus_mux_pkg;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.bus_mux_pkg.ALL;

ENTITY SRAM_DPS IS
	GENERIC (
		address_width : NATURAL := 32;
		data_bus_width : NATURAL := 32
	);
	PORT (
		address : IN STD_LOGIC_VECTOR(address_width-1 DOWNTO 0);
		data_in : IN STD_LOGIC_VECTOR(data_bus_width-1 DOWNTO 0); 
		data_out : OUT STD_LOGIC_VECTOR(data_bus_width-1 DOWNTO 0); 
		WE, CS, OE, CLK : IN STD_LOGIC
	);
END ENTITY SRAM_DPS;

ARCHITECTURE SRAM_DPS_ARCH of SRAM_DPS IS

    signal sram : bus_mux_array(10 DOWNTO 0);

BEGIN


	sram(to_integer(unsigned(address))) <= data_in when CS = '0' and rising_edge(CLK) and WE = '0';

	data_out <= sram(to_integer(unsigned(address))) when CS = '0' and WE = '1' and OE = '0'
				else (others=>'Z');



	--if CS = '0' then
	--	if WE = '0' then 
	--		if rising_edge(CLK) then
	--			sram(conv_integer(address)) <= data_in;
	--		end if;
	--	else
	--		if OE = '0'
	--			data_out <= sram(conv_integer(address));
	--		end if;
	--	end if;
	--else 
	--	data_out <= (others=>'Z');
	--end if;
    

END SRAM_DPS_ARCH ; -- SRAM_DPS_ARCH