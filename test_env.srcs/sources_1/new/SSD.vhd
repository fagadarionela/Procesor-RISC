----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2019 08:16:39 PM
-- Design Name: 
-- Module Name: SSD - Behavioral
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

entity SSD is
    Port ( Digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           CLK : in STD_LOGIC;
           CAT : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (3 downto 0));
end SSD;

architecture Behavioral of SSD is
signal s : std_logic_vector(15 downto 0):="0000000000000000";
signal HEX: std_logic_vector(3 downto 0):="0000";
begin
process(CLK) 
begin
    if rising_edge(CLK) then
        s <=s+1;
    end if;
end process;

process(s)
begin
case s(15 downto 14) is
    when "00" => HEX <=Digit0;
    when "01" => HEX <=Digit1;
    when "10" => HEX <=Digit2;
    when "11" => HEX <=Digit3;
    when others => HEX<="0000";
end case;
end process;

process(s)
begin
case s(15 downto 14) is
    when "00" => AN <= "0111";
    when "01" => AN <= "1011";
    when "10" => AN <= "1111";
    when "11" => AN <= "1110";
    when others => AN <="1111";
end case;
end process;

process(HEX) is 
begin

case HEX is  
     when "0000" => CAT<= "1000000";    --0            
     when "0001" => CAT<= "1111001";    --1
     when "0010" => CAT<= "0100100";    --2
     when "0011" => CAT<= "0110000";    --3
     when "0100" => CAT<= "0011001";    --4
     when "0101" => CAT<= "0010010";    --5
     when "0110" => CAT<= "0000010";    --6
     when "0111" => CAT<= "1111000";    --7
     when "1000" => CAT<= "0000000";    --8
     when "1001" => CAT<= "0010000";    --9
     when "1010" => CAT<= "0001000";    --A
     when "1011" => CAT<= "0000011";    --b
     when "1100" => CAT<= "1000110";    --C
     when "1101" => CAT<= "0100001";    --d
     when "1110" => CAT<= "0000110";    --E
     when "1111" => CAT<= "0001110";    --F
     when others => CAT<= "1111111";    --
end case;
end process;
end Behavioral;
