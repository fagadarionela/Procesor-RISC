----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2019 06:15:19 PM
-- Design Name: 
-- Module Name: ID - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ID is
    Port ( RegWrite : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (15 downto 0);
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           Ext_Imm : out STD_LOGIC_VECTOR (15 downto 0);
           func : out STD_LOGIC_VECTOR (2 downto 0);
           sa : out STD_LOGIC;
           clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           write_addr_in:in std_logic_vector(2 downto 0);
           write_addr_out:out std_logic_vector(2 downto 0));
end ID;

architecture Behavioral of ID is
component RF is
    Port ( RA1 : in STD_LOGIC_VECTOR (2 downto 0);
           RA2 : in STD_LOGIC_VECTOR (2 downto 0);
           WA : in STD_LOGIC_VECTOR (2 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           RegWr : in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0));
end component RF;
--signal write_addr:std_logic_vector(2 downto 0):="000";
signal regwsienable:std_logic;
begin
RFinst: RF port map(Instr(12 downto 10),Instr(9 downto 7),write_addr_in,wd,clk,regwrite,RD1,RD2);
process(clk)
begin
--if enable='1' then
if RegDst='0' then write_addr_out <= Instr(9 downto 7);
else write_addr_out <= Instr(6 downto 4);
end if;
--end if;
end process;

process(clk)
begin
--if enable='1' then
if ExtOp='1' then 
    if Instr(6)='0' then Ext_Imm<="000000000"&Instr(6 downto 0);
    else Ext_Imm<="111111111"&Instr(6 downto 0);
    end if;
else Ext_Imm<="000000000"&Instr(6 downto 0);
--end if;
end if;
end process;
func <= Instr(2 downto 0);
sa <= Instr(3);
end Behavioral;
