----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.02.2019 15:35:00
-- Design Name: 
-- Module Name: numarator - Behavioral
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

entity numarator is
    Port ( en : in STD_LOGIC;
            dir: in STD_LOGIC;
           clk : in STD_LOGIC;
           q: out STD_LOGIC_VECTOR(15 downto 0));
end numarator;


architecture Behavioral of numarator is
signal cnt: STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
begin
process (clk)
begin
   if clk='1' and clk'event then
      if en='1' then
         if dir='1' then
            cnt <= cnt + 1;
         else
            cnt <= cnt - 1;
         end if;
      end if;
   end if;
   q<=cnt;
end process;



end Behavioral;
