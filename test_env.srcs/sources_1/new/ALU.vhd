----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2019 19:04:37
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    Port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (7 downto 0);
           o : out STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is
signal nr1,nr2 : STD_LOGIC_VECTOR(15 downto 0);
signal cnt2 :STD_LOGIC_VECTOR(1 downto 0):="00";
signal s2:STD_LOGIC:='0';
begin
process (clk)
begin
   if clk='1' and clk'event then
      if s2='1' then
            cnt2 <= cnt2 + 1;
      end if;
   end if;
end process;

process(clk)
begin
nr1 <= "000000000000"&sw(3 downto 0); 
nr2 <= "000000000000"&sw(7 downto 4); 


case cnt2 is
when "00" => o <= nr1+nr2;
when "01" => o <= nr1-nr2;
when "10" => o <= sw(14 downto 0)&'0';
when "11" => o <= '0'&sw(15 downto 1);
end case;
end process;

--process(clk)
--begin
--if o="0000000000000000" then led(7)<='1';
--else led(7)<='0';
--end if;
--end process;

end Behavioral;
