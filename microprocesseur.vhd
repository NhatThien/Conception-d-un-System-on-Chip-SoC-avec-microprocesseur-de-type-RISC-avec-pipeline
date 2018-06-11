----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:07:11 05/03/2018 
-- Design Name: 
-- Module Name:    microprocesseur - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity microprocesseur is
    Port ( A : in  std_logic_vector(15 downto 0);
           B : in  std_logic_vector(15 downto 0);
           OP : in std_logic_vector(3 downto 0);
           S : out std_logic_vector(15 downto 0);
           Flag : out  std_logic_vector(3 downto 0));
end microprocesseur;

architecture Behavioral of microprocesseur is

	signal Smul:std_logic_vector(31 downto 0);
	signal	Sadd:std_logic_vector(16 downto 0);
	
begin
	
			Sadd <= ('0' & A) + ('0' & B);
			flag<="0001" 
			when (Sadd(16)='1') else
			"0000";
			Smul <= A*B;
			
			S <= Sadd(15 downto 0)
				when (OP="0000") else 					
					A-B
            when (OP="0001") else			  
					Smul(15 downto 0) 
	         when (OP="0011") else		 
					"0"&A(15 downto 1)
			   when (OP="0111") else 
					A(14 downto 0)&"0"
				when (OP="1111" ); 
		


end Behavioral;

