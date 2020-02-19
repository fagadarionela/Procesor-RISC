----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2019 18:19:27
-- Design Name: 
-- Module Name: RF - Behavioral
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

entity RF is
    Port ( RA1 : in STD_LOGIC_VECTOR (2 downto 0);
           RA2 : in STD_LOGIC_VECTOR (2 downto 0);
           WA : in STD_LOGIC_VECTOR (2 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           RegWr : in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0));
end RF;

architecture Behavioral of RF is
type reg_a is array(0 to 7) of STD_LOGIC_VECTOR(15 downto 0);
signal RF: reg_a:=(
others => "0000000000000000");
begin
process(clk)
begin
if rising_edge(clk) then
    if RegWr = '1' then
        RF(conv_integer(WA))<=WD;
    end if;
end if;
end process;

RD1<=RF(conv_integer(RA1));
RD2<=RF(conv_integer(RA2));
end Behavioral;
