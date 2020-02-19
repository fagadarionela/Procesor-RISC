----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2019 06:22:51 PM
-- Design Name: 
-- Module Name: PC - Behavioral
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

entity PC is
    Port ( D : in STD_LOGIC_VECTOR (15 downto 0);
           en : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (15 downto 0));
end PC;

architecture Behavioral of PC is

begin
process(clk,rst)
begin
if rst= '1' then
    Q<="0000000000000000";
else
if clk'event and clk='1' then
    if en = '1' then
        Q<=D;
    end if;
end if;
end if;
end process;
end Behavioral;
