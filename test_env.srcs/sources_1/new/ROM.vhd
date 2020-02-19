----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2019 06:39:27 PM
-- Design Name: 
-- Module Name: ROM - Behavioral
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

entity ROM is
    Port ( addr : in STD_LOGIC_VECTOR (15 downto 0);
           instr : out STD_LOGIC_VECTOR (15 downto 0));
end ROM;

architecture Behavioral of ROM is
type arr_type is array( 0 to 40) of STD_LOGIC_VECTOR(15 downto 0);
signal r_name: arr_type :=(
--b"011_001_011_0000000",          --sw $1 $3
--b"010_001_011_0000000",          --lw $1 $3
--b"000_011_001_110_0_000",        --add $3 $1 $6
--b"000_110_000_111_0_001",        --sub $6 $0 $7
--b"000_111_001_101_0_000",        --add $7 $1 $5
--b"000_101_111_011_0_100",        --and $5 $7 $3
--others => "0000000000000000"
b"000_000_000_001_0_000",   --0 add  $0 $0 $1
b"001_000_100_0001010",     --1 addi $0 10 $4
b"000_000_000_010_0_000",   --2 add  $0 $0 $2
b"000_000_000_101_0_000",   --3 add  $0 $0 $5
b"100_100_001_0011000",     --4 beq  $4 $1 24
b"000_000_000_000_0_000",
b"000_000_000_000_0_000",
b"000_000_000_000_0_000",
b"010_001_011_0000001",     --5 lw   1($1) $3
b"001_000_110_0000001",     --6 addi $0 1  $6
b"000_000_000_000_0_000",
b"000_000_000_000_0_000",
b"000_011_110_111_0_100",   --7 and  $3 $6 $7
b"000_000_000_000_0_000",
b"000_000_000_000_0_000",
b"100_111_000_0000111",     --8 beq  $7 $0 7
b"000_000_000_000_0_000",
b"000_000_000_000_0_000",
b"000_000_000_000_0_000",
b"000_101_011_110_0_000",   --9 add  $5 $3 $6
b"000_000_000_000_0_000",
b"000_000_000_000_0_000",
b"000_110_000_101_0_000",   --a10 add $6 $0 $5    --se aduna la suma
b"001_001_110_0000001",     --b11 addi $1 1 $6    --elementul urmator din memorie+pas urmator de iteratie
b"000_000_000_000_0_000",
b"000_000_000_000_0_000",
b"000_110_000_001_0_000",   --c12 add $6 $0 $1
b"011_000_101_0001100",     --d13 sw  12($0) $5
b"111_0000000000100",       --e14 j   4
b"000_000_000_000_0_000",
b"011_000_101_0001100",     --f15 sw  12($0) $5
b"010_000_011_0001100",     --16 lw   12($0) $3
b"000_000_000_000_0_000",
b"000_000_000_000_0_000",
b"000_011_000_001_0_000",   --0 add  $3 $0 $1
others=> b"0000000000000000");     
begin
instr<=r_name(conv_integer(addr));
end Behavioral;
