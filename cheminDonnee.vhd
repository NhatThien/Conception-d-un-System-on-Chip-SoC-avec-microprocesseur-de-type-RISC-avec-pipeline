----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:03:47 06/01/2018 
-- Design Name: 
-- Module Name:    cheminDonnee - Behavioral 
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

entity cheminDonnee is
    Port ( 
		ins_di: in  std_logic_vector(31 downto 0);	
		ck: in std_logic);
end cheminDonnee;

architecture Behavioral of cheminDonnee is

type t_stage is record
    op    : std_logic_vector(7 downto 0);
    a,b,c  : std_logic_vector(15 downto 0);
end record t_stage;

component decodeur is
    Port ( ins_di : in  std_logic_vector(31 downto 0);
           OP : out  std_logic_vector(7 downto 0);
           A : out  std_logic_vector(15 downto 0);
           B : out  std_logic_vector(15 downto 0);
           C : out  std_logic_vector(15 downto 0));
end component;

component pipeline is
    Port ( 
			  CK: in STD_LOGIC;
			  op_in : in  std_logic_vector(7 downto 0);
			  a_in : in  std_logic_vector(15 downto 0);
           b_in : in  std_logic_vector(15 downto 0);
           c_in : in  std_logic_vector(15 downto 0);
           op_out : out  std_logic_vector(7 downto 0);
           a_out : out  std_logic_vector(15 downto 0);
           b_out : out  std_logic_vector(15 downto 0);
           c_out : out  std_logic_vector(15 downto 0)
			);
end component;

component alu is
    Port ( A : in  std_logic_vector(15 downto 0);
           B : in  std_logic_vector(15 downto 0);
           OP : in std_logic_vector(3 downto 0);
           S : out std_logic_vector(15 downto 0);
           Flag : out  std_logic_vector(3 downto 0));
end component;

component Banc is
    Port ( DATA : in  std_logic_vector(15 downto 0); 
			  RST : in  STD_LOGIC;  
           W  : in  STD_LOGIC;
           aW : in  std_logic_vector(15 downto 0);
			  aA : in  std_logic_vector(15 downto 0);
           aB : in  std_logic_vector(15 downto 0);
			  CK : in STD_LOGIC;
			  QA : out  std_logic_vector(15 downto 0);
           QB : out  std_logic_vector(15 downto 0));
end component;

component bram16
  generic (
    init_file : String := "none";
    adr_width : Integer := 11);
  port (
  -- System
  sys_clk : in std_logic;
  sys_rst : in std_logic;
  -- Master
  di : out std_logic_vector(15 downto 0);
  we : in std_logic;
  a : in std_logic_vector(15 downto 0);
  do : in std_logic_vector(15 downto 0));
end component;

signal d1, d2, d3, d4, d5: t_stage;
signal W_reg  :  STD_LOGIC;
signal mux: std_logic_vector(15 downto 0);
signal muxual: std_logic_vector(15 downto 0);
signal muxload: std_logic_vector(15 downto 0);
signal qa: std_logic_vector(15 downto 0);
signal qb: std_logic_vector(15 downto 0);
signal s :std_logic_vector(15 downto 0);
signal lcual:std_logic_vector(3 downto 0);

signal data_di: std_logic_vector(15 downto 0);
signal data_we: std_logic;
signal data_do: std_logic_vector(15 downto 0);
signal data_a: std_logic_vector(15 downto 0);

begin
	deco: decodeur port map(ins_di, d1.op, d1.a, d1.b, d1.c);
	lidi: pipeline port map(ck, d1.op, d1.a, d1.b, d1.c, d2.op, d2.a, d2.b, d2.c);
	diex: pipeline port map(ck, d2.op, d2.a, mux, qb, d3.op, d3.a, d3.b, d3.c);
	exmem : pipeline port map(ck, d3.op, d3.a, muxual, d3.c, d4.op, d4.a, d4.b, d4.c);
	memre: pipeline port map(ck, d4.op, d4.a, d4.b, d4.c, d5.op, d5.a, d5.b, d5.c);
	br: banc port map(muxload, '1', W_reg, d5.a,     d2.b, d2.c, ck, qa, qb);
	myalu: alu port map(d3.b, d3.c, lcual, s, open);
	bram: bram16 port map(ck, '1', data_di, data_we, data_a, data_do);
	
	W_reg <= '0' when d5.op = x"08" or d5.op = x"0E" else '1';
	mux <=  d2.b when d2.op = x"06" or d2.op=x"07" else qa;  
	muxual <= s when d3.op= x"01" or  d3.op= x"02" or d3.op= x"03" or  d3.op= x"04"
		else d3.b ; 
	muxload <= data_di  when d5.op=x"07" else d5.b;
	lcual <= d3.op(3 downto 0);
	
	data_a <= d4.a when d4.op = x"08" else d4.b; 
	data_we <=  '1' when d4.op = x"08" else '0';
	data_do <= d4.b when d4.op = x"08" else x"0000";
	
end Behavioral;

