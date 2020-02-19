----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.02.2019 18:51:20
-- Design Name: 
-- Module Name: mpg - Behavioral
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

entity mpg is
    Port ( en : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end mpg;

architecture Behavioral of mpg is
signal cnt_int:STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal q1:STD_LOGIC;
signal q2:STD_LOGIC;
signal q3:STD_LOGIC;
begin

process(clk)
begin 
if rising_edge(clk) then
    cnt_int<=cnt_int + 1;
end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if cnt_int(15 downto 0)="1111111111111111" then
            q1<=btn;
        end if;
    end if;
end process;    

process(clk)
begin
    if rising_edge(clk) then 
        q2<=q1;
        q3<=q2;
    end if;
end process;

en<=q2 and (not q3);
end Behavioral;
