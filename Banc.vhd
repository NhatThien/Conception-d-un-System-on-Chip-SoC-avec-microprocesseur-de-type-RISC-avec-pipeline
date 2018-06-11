----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:35:22 05/18/2018 
-- Design Name: 
-- Module Name:    Banc - Behavioral 
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
USE ieee.numeric_std.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Banc is
    Port ( DATA : in  std_logic_vector(15 downto 0); 
			  RST : in  STD_LOGIC;  
           W  : in  STD_LOGIC;
           aW : in  std_logic_vector(15 downto 0);
			  aA : in  std_logic_vector(15 downto 0);
           aB : in  std_logic_vector(15 downto 0);
			  CK : in STD_LOGIC;
			  QA : out  std_logic_vector(15 downto 0);
           QB : out  std_logic_vector(15 downto 0));
end Banc;

architecture Behavioral of Banc is

   type registreArray is array (integer range <>) of std_logic_vector(15 downto 0);
	signal table: registreArray (0 to 15) :=  (others=>x"0000");

begin
	process
	begin
		wait until CK'event and CK='1';
		if RST='1' and W='1' THEN table(to_integer(unsigned(aW(3 downto 0))))<=DATA;				
						end if;
	end process;
	
	QA<=DATA
		when RST='1' and W='1' and (aA(3 downto 0)=aW(3 downto 0))else
		x"0000"
		when RST='0' else
		table(to_integer(unsigned(aA(3 downto 0))));

	QB<=DATA
		when RST='1' and W='1' and (aB(3 downto 0)=aW(3 downto 0))else
		x"0000"
		when RST='0' else
		table(to_integer(unsigned(aB(3 downto 0))));
    
end Behavioral;

