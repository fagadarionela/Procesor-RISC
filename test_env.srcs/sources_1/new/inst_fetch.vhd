----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2019 06:15:51 PM
-- Design Name: 
-- Module Name: inst_fetch - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inst_fetch is
    Port ( en : in STD_LOGIC;
           RST : in STD_LOGIC;
           branch_addr : in STD_LOGIC_VECTOR (15 downto 0);
           jump_addr : in STD_LOGIC_VECTOR (15 downto 0);
           jump : in STD_LOGIC;
           PcSrc : in STD_LOGIC;
           pc1 : out STD_LOGIC_VECTOR (15 downto 0);
           instr : out STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC);
end inst_fetch;

architecture Behavioral of inst_fetch is
component PC 
    Port ( D : in STD_LOGIC_VECTOR (15 downto 0);
           en : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (15 downto 0));
end component PC;

component ROM
    Port ( addr : in STD_LOGIC_VECTOR (15 downto 0);
           instr : out STD_LOGIC_VECTOR (15 downto 0));
end component ROM;

component mpg is
    Port ( en : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end component mpg;
signal enable:STD_LOGIC;
signal pcin,pcout,pcout1,s:STD_LOGIC_VECTOR(15 downto 0);
begin
pc_inst: PC port map(pcin,en,rst,clk,pcout);
rom_inst: ROM port map(pcout,instr);
pcout1 <= pcout+1;
pc1<=pcout1;
process(pcsrc,clk)
begin
if pcsrc ='0' then s<=pcout1;
else s<=branch_addr;
end if;
end process;

process(jump,clk)
begin
if jump ='0' then pcin<=s;
else pcin<=jump_addr;
end if;
end process;

end Behavioral;
