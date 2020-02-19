----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/28/2019 07:12:54 PM
-- Design Name: 
-- Module Name: RX_FSM - Behavioral
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

entity RX_FSM is
    Port ( RX : in STD_LOGIC;
           RX_RDY : out STD_LOGIC;
           RX_DATA : out STD_LOGIC_VECTOR (7 downto 0);
           BAUD_EN : in STD_LOGIC;
           RST : in STD_LOGIC;
           clk: in STD_LOGIC);
end RX_FSM;

architecture Behavioral of RX_FSM is
type state_type is(idle,start,bitt,stop,waitt);
signal state: state_type;
signal BIT_CNT: std_logic_vector(2 downto 0):="000";
signal BAUD_CNT: std_logic_vector(3 downto 0):="0000";
begin
process(clk,RST,BAUD_EN)
begin
if RST='1' then
    state <= idle;
elsif rising_edge(clk) and BAUD_EN = '1' then
        case state is 
            when idle => 
                BAUD_CNT<="0000";
                BIT_CNT<="000";
                if RX='0' then state<=start;
                end if;
            when start =>
                if RX='1' then state<=idle;
                elsif BAUD_CNT="0111" then state<=bitt;
                                           BAUD_CNT<="0000";
                else BAUD_CNT<=BAUD_CNT+1;
                end if;
            when bitt => 
                if BAUD_CNT<"1111" then
                  BAUD_CNT<=BAUD_CNT+1;
                elsif BIT_CNT<"111" then
                    BIT_CNT<=BIT_CNT+1;
                    BAUD_CNT<="0000";
                else
                    state<=stop;
                    BIT_CNT<="000";
                    BAUD_CNT<="0000";
                end if;
            when stop => 
                if BAUD_CNT="1111" then
                    state<=waitt;
                    BAUD_CNT<="0000";
                else 
                    BAUD_CNT<=BAUD_CNT+1;
                end if;
            when waitt=>
                if BAUD_CNT="0111" then
                    state<=idle;
                    BAUD_CNT<="0000";
                else     
                    BAUD_CNT<=BAUD_CNT+1;
                end if;
        end case;   
end if;
end process;
process(state,BAUD_CNT)
begin
    case state is
        when idle =>
           RX_RDY<='0';
        when start =>
           RX_RDY<='0';
        when bitt =>
           RX_RDY<='0';
            RX_DATA(conv_integer(BIT_CNT))<=RX; 
        when stop =>
           RX_RDY<='0';
        when waitt =>
           RX_RDY<='1';
    end case;
end process;
end Behavioral;
