----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2019 19:02:32
-- Design Name: 
-- Module Name: RAM - Behavioral
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

entity RAM is
    Port ( clk : in STD_LOGIC;
           we : in STD_LOGIC;
           en : in STD_LOGIC;
           adr : in STD_LOGIC_VECTOR (7 downto 0);
           i : in STD_LOGIC_VECTOR (15 downto 0);
           o : out STD_LOGIC_VECTOR (15 downto 0));
end RAM;

architecture Behavioral of RAM is
type ram_array is array(0 to 255) of STD_LOGIC_VECTOR(15 downto 0);
signal RAM:ram_array:=(
"0000000000000000",
"0000000000000001",
"0000000000000010",
"0000000000000011",
"0000000000000100",
"0000000000000101",
"0000000000000110",
"0000000000000111",
"0000000000001000",
"0000000000001001",
"0000000000001010",
others => "0000000000000000");
begin
process(clk)
begin
    if rising_edge(clk) then
        if en ='1' then
            if we='1' then
                RAM(conv_integer(adr))<=i;
            else 
                o <=RAM(conv_integer(adr));
            end if;
        end if;
    end if;
end process;
end Behavioral;
