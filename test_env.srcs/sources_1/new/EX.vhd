----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2019 11:02:55 AM
-- Design Name: 
-- Module Name: EX - Behavioral
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

entity EX is
    Port ( pc:in STD_LOGIC_VECTOR(15 downto 0);
           RD1 : in STD_LOGIC_VECTOR (15 downto 0);
           AluSrc : in STD_LOGIC;
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           Ext_Imm : in STD_LOGIC_VECTOR (15 downto 0);
           sa : in STD_LOGIC;
           func : in STD_LOGIC_VECTOR (2 downto 0);
           AluOp : in STD_LOGIC_VECTOR(2 downto 0);
           Zero : out STD_LOGIC;
           ALURes : out STD_LOGIC_VECTOR (15 downto 0);
           ALUSalt: out STD_LOGIC_VECTOR( 15 downto 0));
end EX;

architecture Behavioral of EX is
signal in2 : std_logic_vector(15 downto 0);
begin
process(ALUSrc,Ext_Imm,RD2) 
begin
if ALUSrc = '1' then in2 <=Ext_Imm;
else in2<=RD2;
end if;
end process;

process(RD1,RD2,Ext_Imm,pc,aluOp,sa) 
begin

if ALUOp = "000" then --tip R
    --ALUSalt <= "0000000000000000";
    if func="000" then
        ALURes<=RD1+in2;   --daca apare transport?
        zero<='0';
    elsif func="001" then
        ALURes<=RD1-in2;
        zero<='0';
    elsif func="010" then
        if sa='0' then ALURes<=RD1(14 downto 0)&'0';
        else ALURes<=RD1(15)&RD1(13 downto 0)&'0'; --?
        end if;
        zero<='0';
    elsif func="011" then
        if sa='0' then ALURes<='0'&RD1(15 downto 1);
        else ALURes<=RD1(15)&RD1(15 downto 1);
        end if;
        zero<='0';
    elsif func="100" then
        ALURes<=RD1 and in2;
        zero<='0';
    elsif func="101" then
        ALURes<=RD1 or in2;
        zero<='0';
    elsif func="110" then
        ALURes<=RD1 + in2;
        zero<='0';
    else
        ALURes<=RD1 - in2;
        zero<='0';    
    end if;
elsif ALUOp="001" then  --addi
    ALURes<=RD1 + in2;
    zero<='0';
    --ALUSalt <= "0000000000000000";
elsif ALUOp="010" then  --lw
    ALURes<=RD1 + in2; 
    zero<='0';
   -- ALUSalt <= "0000000000000000";
elsif ALUOp="011" then  --sw
    ALURes<=RD1 + in2; 
    zero<='0';
    --ALUSalt <= "0000000000000000";
elsif ALUOp="100" then --beq
    ALURes <="0000000000000000";
    --ALUSalt <= pc +ext_imm-7;
    if RD1 - in2 = 0 then zero<='1';
    else zero<='0';
    end if;
elsif ALUOp="101" then  --andi
    ALURes<=RD1 and in2; 
    zero<='0';
    --ALUSalt <= "0000000000000000"; 
elsif ALUOp="110" then  --ori
    ALURes<=RD1 or in2; 
    zero<='0';
    --ALUSalt <= "0000000000000000"; 
else ALURes <="0000000000000000"; --j
    --ALUSalt <= "0000000000000000";
    zero<='0';
end if;
end process;
ALUSalt <= pc +ext_imm;
end Behavioral;
