--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:16:10 05/04/2018
-- Design Name:   
-- Module Name:   /home/tn_van/Bureau/4eAnnee/Kompiler/microprocesseur/testpipeline.vhd
-- Project Name:  microprocesseur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pipeline
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
 
ENTITY testpipeline IS
END testpipeline;
 
ARCHITECTURE behavior OF testpipeline IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pipeline
    PORT(
	      CK: in STD_LOGIC;
			op_in : IN  std_logic_vector(7 downto 0);
         a_in : IN  std_logic_vector(15 downto 0);
         b_in : IN  std_logic_vector(15 downto 0);
         c_in : IN  std_logic_vector(15 downto 0);
         op_out : OUT  std_logic_vector(7 downto 0);
         a_out : OUT  std_logic_vector(15 downto 0);
         b_out : OUT  std_logic_vector(15 downto 0);
         c_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
	signal CK:    STD_LOGIC;
   signal a_in : std_logic_vector(15 downto 0) := (others => '0');
   signal b_in : std_logic_vector(15 downto 0) := (others => '0');
   signal c_in : std_logic_vector(15 downto 0) := (others => '0');
   signal op_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal a_out : std_logic_vector(15 downto 0);
   signal b_out : std_logic_vector(15 downto 0);
   signal c_out : std_logic_vector(15 downto 0);
   signal op_out : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 constant ck_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pipeline PORT MAP (
			 CK=>CK,
          a_in => a_in,
          b_in => b_in,
          c_in => c_in,
          op_in => op_in,
          a_out => a_out,
          b_out => b_out,
          c_out => c_out,
          op_out => op_out
        );

--    --Clock process definitions
   ck_process :process
   begin
		CK <= '0';
		wait for ck_period/2;
		CK <= '1';
		wait for ck_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      a_in<=x"0001";
		b_in<=x"0011";
		c_in<=x"0111";
		op_in<=x"01";
      -- insert stimulus here 

      wait;
   end process;

END;
