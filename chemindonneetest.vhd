--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:49:42 06/01/2018
-- Design Name:   
-- Module Name:   /home/tn_van/Bureau/4eAnnee/Kompiler/microprocesseur/chemindonneetest.vhd
-- Project Name:  microprocesseur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cheminDonnee
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY chemindonneetest IS
END chemindonneetest;
 
ARCHITECTURE behavior OF chemindonneetest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cheminDonnee
    PORT(
         ins_di : IN  std_logic_vector(31 downto 0);
			ck : in std_logic);
			--data_di: in  std_logic_vector(15 downto 0);
			--data_we: out  std_logic;
			--data_do: out  std_logic_vector(15 downto 0);
			--data_a: out std_logic_vector(15 downto 0));
    END COMPONENT;
    

   --Inputs
   signal ins_di : std_logic_vector(31 downto 0) := (others => '0');
	signal ck: std_logic;
	--signal data_di: std_logic_vector(15 downto 0);
	--Outputs
	--signal data_we: std_logic;
	--signal data_do: std_logic_vector(15 downto 0);
	--signal data_a:  std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name
	
   constant ck_period : time := 10 ns;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cheminDonnee PORT MAP (
          ins_di => ins_di,
			 ck => ck
			 --data_di => data_di,
			 --data_we => data_we,
			 --data_do => data_do,
			 --data_a => data_a 
   );
		  
	-- Clock process definitions
   ck_process :process
   begin
		ck<= '0';
		wait for ck_period/2;
		ck <= '1';
		wait for ck_period/2;
   end process;

   
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
			ins_di <= x"06003456";
      wait for 100 ns;	
			ins_di <= x"08010200";
      wait;
   end process;

END;
