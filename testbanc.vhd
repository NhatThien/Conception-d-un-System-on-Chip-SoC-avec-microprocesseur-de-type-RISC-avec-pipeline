--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:10:12 05/18/2018
-- Design Name:   
-- Module Name:   /home/tn_van/Bureau/4eAnnee/Kompiler/microprocesseur/testbanc.vhd
-- Project Name:  microprocesseur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Banc
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
 
ENTITY testbanc IS
END testbanc;
 
ARCHITECTURE behavior OF testbanc IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Banc
    PORT(
         RST : IN  std_logic;
         QA : OUT  std_logic_vector(15 downto 0);
         QB : OUT  std_logic_vector(15 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(15 downto 0);
         aW : IN  std_logic_vector(15 downto 0);
         aA : IN  std_logic_vector(15 downto 0);
         aB : IN  std_logic_vector(15 downto 0);
         CK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal W : std_logic := '0';
   signal DATA : std_logic_vector(15 downto 0) := (others => '0');
   signal aW : std_logic_vector(15 downto 0) := (others => '0');
   signal aA : std_logic_vector(15 downto 0) := (others => '0');
   signal aB : std_logic_vector(15 downto 0) := (others => '0');
   signal CK : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(15 downto 0);
   signal QB : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant ck_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Banc PORT MAP (
          RST => RST,
          QA => QA,
          QB => QB,
          W => W,
          DATA => DATA,
          aW => aW,
          aA => aA,
          aB => aB,
          CK => CK
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
      wait for 100 ns;
		wait until ck = '1';
		RST<='1';
		DATA<=x"0123";
	   W<='1';

      -- insert stimulus here 

      wait;
   end process;

END;
