----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2019 11:38:48 AM
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
    Port ( Address : in STD_LOGIC_VECTOR (15 downto 0);
           WriteData : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           en:in STD_LOGIC;
           ReadData : out STD_LOGIC_VECTOR (15 downto 0));
end MEM;

architecture Behavioral of MEM is
type ram_array is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal MEM:ram_array:=(
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
        --if en='1' then
            if MemWrite='1' then
                MEM(conv_integer(Address))<=WriteData;
            end if;
       -- end if;
    end if;
end process;
ReadData <=MEM(conv_integer(Address));
end Behavioral;
