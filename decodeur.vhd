----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:54 05/18/2018 
-- Design Name: 
-- Module Name:    decodeur - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decodeur is
    Port ( ins_di : in  std_logic_vector(31 downto 0);
           OP : out  std_logic_vector(7 downto 0);
           A : out  std_logic_vector(15 downto 0);
           B : out  std_logic_vector(15 downto 0);
           C : out  std_logic_vector(15 downto 0));
end decodeur;

architecture Behavioral of decodeur is
begin
		OP <= ins_di(31 downto 24);
	  
		A <= ins_di(23 downto 8) 
				when ins_di(31 downto 24) = x"08" else
				x"00" & ins_di(23 downto 16);
				
		B <= ins_di(15 downto 0) 
				when ins_di(31 downto 24) = x"07" or ins_di(31 downto 24) = x"06" else
				x"0000"
				when ins_di(31 downto 24) = x"08" else
				x"00" & ins_di(15 downto 8);
				
		C <= x"0000"
				when ins_di(31 downto 24) = x"07" or ins_di(31 downto 24) = x"06" else
				x"00" & ins_di(7 downto 0);
	  
	
end Behavioral;

