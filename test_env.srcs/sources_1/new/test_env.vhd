----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.02.2019 16:01:45
-- Design Name: 
-- Module Name: test_env - Behavioral
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

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           TX: out std_logic;
           RX: in std_logic);
end test_env;

architecture Behavioral of test_env is
signal cnt,DO: STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal o,nr1,nr2,iesire,i1,i2,afispc,afisinstr,afisare,undeSare: STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal s1,s2,s3,s4,reset,enable,enable2,enable3,we: STD_LOGIC;
signal cnt2 :STD_LOGIC_VECTOR(1 downto 0):="00";
signal cnt3,cnt33 :STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal cnt32 :STD_LOGIC_VECTOR(3 downto 0):="0000";
signal rd1,rd2,sum:STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal ext_imm,ALURes,ALUSalt,readData,iesire_dr: STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
signal func : STD_LOGIC_VECTOR (2 downto 0):="000";
signal sa,Zero,btnFSM : STD_LOGIC:='0';
signal RegDst,ExtOp,AluSrc,Branch,Jump,MemWrite,MemtoReg,RegWrite,pcsrc:STD_LOGIC:='0';
signal ALUOp:STD_LOGIC_VECTOR(2 downto 0):="000";
signal IFID_PC, IFID_Instruction:STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal IDEX_MemtoReg,IDEX_RegWrite,IDEX_MemWrite,IDEX_Branch,IDEX_AluSrc,IDEX_Sa:STD_LOGIC:='0';
signal IDEX_PC,IDEX_RD1,IDEX_RD2,IDEX_Ext :STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal IDEX_ALUOp,IDEX_Opcode,IDEX_Func:STD_LOGIC_VECTOR(2 downto 0):="000";
signal EXMEM_MemtoReg,EXMEM_RegWrite,EXMEM_MemWrite,EXMEM_Branch,EXMEM_Zero:STD_LOGIC:='0';
signal EXMEM_BranchAddr, EXMEM_AluRez,EXMEM_RD2:STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal MEMWB_MemtoReg, MEMWB_RegWrite:STD_LOGIC:='0';
signal MEMWB_RD,MEMWB_AluRez:STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal IDEX_WA,EXMEM_WA,MEMWB_WA,wa: std_logic_vector(2 downto 0):="000";
signal count: STD_LOGIC_VECTOR(9 downto 0):="0000000000";
signal BAUD_EN,TX_EN,RST,TX_RDY,RX_RDY :STD_LOGIC;
signal RX_DATA:STD_LOGIC_VECTOR(7 downto 0):="00000000";
type arr_type is array( 0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal r_name: arr_type :=(

b"000_000_000_001_0_000",   --add  $0 $0 $1
b"001_000_100_0001010",     --addi $0 10 $4
b"000_000_000_010_0_000",   --add  $0 $0 $2
b"000_000_000_101_0_000",   --add  $0 $0 $5
b"100_100_001_0000110",     --beq  $4 $1 6
b"010_011_010_0000001",     --lw   $3 1($2)
b"001_000_110_0000001",     --addi $0 1  $6
b"000_011_110_111_0_100",   --and  $3 $6 $7
b"100_111_000_0000001",     --beq  $7 $0 1
b"000_101_011_101_0_000",   --add  $5 $3 $6
--add $6 $0 $5
b"111_0000000000100",       --j    4
b"011_101_000_0010100",     --sw   $5 20($0)
others => "0000000000000000");
component mpg is
    Port ( en : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end component mpg;

component SSD is
    Port ( Digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           Digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           CLK : in STD_LOGIC;
           CAT : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (3 downto 0));
end component SSD;


component EX is
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
end component EX;

component MEM is
    Port ( Address : in STD_LOGIC_VECTOR (15 downto 0);
           WriteData : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           en:in STD_LOGIC;
           ReadData : out STD_LOGIC_VECTOR (15 downto 0));
end component;

--component RF is
--    Port ( RA1 : in STD_LOGIC_VECTOR (3 downto 0);
--           RA2 : in STD_LOGIC_VECTOR (3 downto 0);
--           WA : in STD_LOGIC_VECTOR (3 downto 0);
--           WD : in STD_LOGIC_VECTOR (15 downto 0);
--           clk : in STD_LOGIC;
--           RegWr : in STD_LOGIC;
--           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
--           RD2 : out STD_LOGIC_VECTOR (15 downto 0));
--end component RF;

component RAM is
    Port ( clk : in STD_LOGIC;
           we : in STD_LOGIC;
           en : in STD_LOGIC;
           adr : in STD_LOGIC_VECTOR (7 downto 0);
           i : in STD_LOGIC_VECTOR (15 downto 0);
           o : out STD_LOGIC_VECTOR (15 downto 0));
end component RAM;

component inst_fetch
    Port ( en : in STD_LOGIC;
           RST : in STD_LOGIC;
           branch_addr : in STD_LOGIC_VECTOR (15 downto 0);
           jump_addr : in STD_LOGIC_VECTOR (15 downto 0);
           jump : in STD_LOGIC;
           PcSrc : in STD_LOGIC;
           pc1 : out STD_LOGIC_VECTOR (15 downto 0);
           instr : out STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC);
end component inst_fetch;
component ID is
    Port ( RegWrite : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (15 downto 0);
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           Ext_Imm : out STD_LOGIC_VECTOR (15 downto 0);
           func : out STD_LOGIC_VECTOR (2 downto 0);
           sa : out STD_LOGIC;
           clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           write_addr_in:in std_logic_vector(2 downto 0);
           write_addr_out:out std_logic_vector(2 downto 0));
end component ID;
component TX_FSM is
    Port ( TX_DATA : in STD_LOGIC_VECTOR (7 downto 0);
           TX_EN : in STD_LOGIC;
           RST : in STD_LOGIC;
           BAUD_EN : in STD_LOGIC;
           clk : in STD_LOGIC;
           TX : out STD_LOGIC;
           TX_RDY : out STD_LOGIC);
end component TX_FSM;

component RX_FSM is
    Port ( RX : in STD_LOGIC;
           RX_RDY : out STD_LOGIC;
           RX_DATA : out STD_LOGIC_VECTOR (7 downto 0);
           BAUD_EN : in STD_LOGIC;
           RST : in STD_LOGIC;
           clk: in STD_LOGIC);
end component RX_FSM;
begin
--led<=sw;
--an<=btn(3 downto 0);
--cat<=(others=>'0');

--MPG_inst: mpg port map(s1,btn(0),clk);
--process (clk)
--begin
--   if clk='1' and clk'event then
--      if s1='1' then
--         if sw(0)='1' then
--            cnt <= cnt + 1;
--         else
--            cnt <= cnt - 1;
--         end if;
--      end if;
--   end if;
--   --led<=cnt;
--end process;

--SSD_inst: SSD port map(cnt(3 downto 0),cnt(7 downto 4),cnt(11 downto 8),cnt(15 downto 12),clk,cat,an);

----------------------lab2----------------------

--MPG_inst2: mpg port map(s2,btn(1),clk);

--process (clk)
--begin
--   if clk='1' and clk'event then
--      if s2='1' then
--            cnt2 <= cnt2 + 1;
--      end if;
--   end if;
--end process;

--process(clk)
--begin
--nr1 <= "000000000000"&sw(3 downto 0); 
--nr2 <= "000000000000"&sw(7 downto 4); 


--case cnt2 is
--when "00" => o <= nr1+nr2;
--when "01" => o <=  nr1-nr2;
--when "10" => o <= sw(14 downto 0)&'0';
--when "11" => o <= '0'&sw(15 downto 1);
--end case;
--end process;

--process(clk)
--begin
--if o="0000000000000000" then led(7)<='1';
--else led(7)<='0';
--end if;
--end process;
--SSD_inst2: SSD port map(o(3 downto 0),o(7 downto 4),o(11 downto 8),o(15 downto 12),clk,cat,an);


----------------------lab3----------------------
--MPG_inst3: mpg port map(reset,btn(0),clk);
--MPG_inst31: mpg port map(s3,btn(1),clk);
--process (clk,reset)
--begin
--   if reset='1' then 
--        cnt3<="00000000";
--   end if;
--   if clk='1' and clk'event then
--      if s3='1' then
--            cnt3 <= cnt3 + 1;
--      end if;
--   end if;
--end process;

--DO<=r_name(conv_integer(cnt3));
--SSD_inst3: SSD port map(DO(3 downto 0),DO(7 downto 4),o(11 downto 8),DO(15 downto 12),clk,cat,an);

--MPG_inst3: mpg port map(reset,btn(0),clk);
--MPG_inst31: mpg port map(s3,btn(1),clk);
--MPG_inst32: mpg port map(enable,btn(2),clk);
--process (clk,reset)
--begin
--   if reset='1' then 
--        cnt32<="0000";
--   end if;
--   if clk='1' and clk'event then
--      if s3='1' then
--            cnt32 <= cnt32 + 1;
--      end if;
--   end if;
--end process;
--iesire<=i1+i2;
--RF_inst3: RF port map(cnt32,cnt32,cnt32,iesire,clk,enable,i1,i2);
--SSD_inst3: SSD port map(iesire(3 downto 0),iesire(7 downto 4),iesire(11 downto 8),iesire(15 downto 12),clk,cat,an);


--MPG_inst3: mpg port map(reset,btn(0),clk);
--MPG_inst31: mpg port map(s3,btn(1),clk);
----MPG_inst32: mpg port map(enable,btn(2),clk);
--MPG_inst33: mpg port map(we,btn(3),clk);
--process (clk,reset)
--begin
--   if reset='1' then 
--        cnt33<="00000000";
--   end if;
--   if clk='1' and clk'event then
--      if s3='1' then
--            cnt33 <= cnt33 + 1;
--      end if;
--   end if;
--end process;
--iesire<=i1(13 downto 0)&"00";
--RAM_inst3: RAM port map(clk,we,'1',cnt33,iesire,i1);
--SSD_inst3: SSD port map(iesire(3 downto 0),iesire(7 downto 4),iesire(11 downto 8),iesire(15 downto 12),clk,cat,an);

------------------------------lab4-------------------------------------

--MPG_inst3: mpg port map(reset,btn(0),clk);
--MPG_inst31: mpg port map(s3,btn(1),clk);
----MPG_inst32: mpg port map(enable,btn(2),clk);
----MPG_inst33: mpg port map(we,btn(3),clk);
--process (clk,reset)
--begin
--   if reset='1' then 
--        cnt33<="0000000000000000";
--   end if;
--   if clk='1' and clk'event then
--      if s3='1' then
--            cnt33 <= cnt33 + 1;
--      end if;
--   end if;
--end process;
--iesire<=r_name(conv_integer(cnt33));
--SSD_inst3: SSD port map(iesire(3 downto 0),iesire(7 downto 4),iesire(11 downto 8),iesire(15 downto 12),clk,cat,an);


-------------------lab5---------------
--MPG_inst1: mpg port map(reset,btn(0),clk);
--MPG_inst2: mpg port map(enable,btn(1),clk);
--inst_fetch_inst: inst_fetch port map(reset,enable,"0000000000000001","0000000000000010",sw(0),sw(1),afispc,afisinstr,clk);


--process(clk)
--begin
--if sw(7) ='0' then afisare<=afispc;
--else afisare<=afisinstr;
--end if;
--end process;

--SSD_inst3: SSD port map(afisare(3 downto 0),afisare(7 downto 4),afisare(11 downto 8),afisare(15 downto 12),clk,cat,an);


----------------------lab 6-------------------
MPG_inst1: mpg port map(enable,btn(0),clk);
MPG_inst2: mpg port map(reset,btn(1),clk);
--MPG_inst3: mpg port map(enable2,btn(2),clk);
--inst_fetch_inst: inst_fetch port map(reset,enable,AluSalt,undeSare,jump,pcSrc,afispc,afisinstr,clk);
inst_fetch_inst: inst_fetch port map(enable,reset,EXMEM_BranchAddr,undeSare,jump,pcSrc,afispc,afisinstr,clk);

process(enable,clk)
begin
if enable = '1' then
    if rising_edge(clk) then
        IFID_PC <= afispc;
        IFID_Instruction<=afisinstr;
    end if;
end if;
end process;
process(enable,clk)
begin
if enable = '1' then
    if rising_edge(clk) then
       IDEX_MemtoReg<= MemtoReg;
       IDEX_RegWrite<= RegWrite;
       IDEX_MemWrite<= MemWrite;
       IDEX_Branch<= Branch;
       IDEX_AluSrc<= AluSrc;
       IDEX_Sa<= sa; 
       IDEX_PC<= IFID_PC;
       IDEX_RD1<= rd1;
       IDEX_RD2<= rd2; 
       IDEX_Ext<= ext_imm;
       IDEX_WA <= wa;
       IDEX_ALUOp<= AluOp;
       IDEX_Opcode<= IFID_Instruction(2 downto 0);
       IDEX_Func<= Func;
    end if;
end if;
end process;
process(enable,clk)
begin
if enable = '1' then
    if rising_edge(clk) then
       EXMEM_MemtoReg<= IDEX_MemtoReg;
       EXMEM_RegWrite<= IDEX_RegWrite;
       EXMEM_MemWrite<= IDEX_MemWrite;
       EXMEM_Branch<= IDEX_Branch;
       EXMEM_BranchAddr<=ALUSalt;
       EXMEM_Zero<=zero;
       EXMEM_AluRez<=ALURes;
       EXMEM_RD2<=IDEX_RD2;
       EXMEM_wa<=IDEX_wa;
    end if;
end if;
end process;
process(enable,clk)
begin
if enable = '1' then
    if rising_edge(clk) then
       MEMWB_MemtoReg<= EXMEM_MemtoReg;
       MEMWB_RegWrite<= EXMEM_RegWrite;
       MEMWB_RD<= readData;
       MEMWB_ALURez<= EXMEM_ALURez;
       MEMWB_wa<=EXMEM_wa;
    end if;
end if;
end process;
process(clk)
begin
case sw(7 downto 5) is
--when "000" => afisare<=afisinstr;
--when "001" => afisare<=afispc;
--when "010" => afisare<=rd1;
--when "011" => afisare<=rd2;
--when "100" => afisare<=ext_imm;
--when "101" => afisare<=aluRes;
--when "110" => afisare<=readData;
--when "111" => afisare<=iesire_dr;
when "000" => afisare<=IFID_Instruction;
when "001" => afisare<=IFID_PC;
when "010" => afisare<=IDEX_RD1;
when "011" => afisare<=IDEX_RD2;
when "100" => afisare<=IDEX_Ext;
when "101" => afisare<=EXMEM_AluRez;
when "110" => afisare<=MEMWB_RD;
when "111" => afisare<=iesire_dr;
end case;
end process;

--sum<=rd1+rd2;
--ID_inst: ID port map(RegWrite,IFID_Instruction,RegDst,ExtOp,rd1,rd2,iesire_dr,ext_imm,func,sa,clk,RegWrite);
ID_inst: ID port map(MEMWB_RegWrite,IFID_Instruction,RegDst,ExtOp,rd1,rd2,iesire_dr,ext_imm,func,sa,clk,MEMWB_RegWrite,MEMWB_wa,wa);
--SSD_inst3: SSD port map(afisare(3 downto 0),afisare(7 downto 4),afisare(11 downto 8),afisare(15 downto 12),clk,cat,an);


process(IFID_Instruction)
begin
if IFID_Instruction(15 downto 13)="000" then
    RegDst <= '1';
    RegWrite<='1';
    ALUsrc<='0';
    jump<='0';
    Branch<='0';
    MemWrite<='0';
    MemtoReg<='0';
    ALUOp<="000"; 
elsif IFID_Instruction(15 downto 13)="001" then --addi
    RegDst <= '0';
    RegWrite<='1';
    ALUsrc<='1';
    jump<='0';
    Branch<='0';
    MemWrite<='0';
    MemtoReg<='0';
    ALUOp<="001"; 
elsif IFID_Instruction(15 downto 13)="010" then --lw
    RegDst <= '0';
    RegWrite<='1';
    ALUsrc<='1';
    jump<='0';
    Branch<='0';
    MemWrite<='0';
    MemtoReg<='1';
    ALUOp<="010";
elsif IFID_Instruction(15 downto 13)="011" then --sw
    RegDst <= '1';
    RegWrite<='0';
    ALUsrc<='1';
    jump<='0';
    Branch<='0';
    MemWrite<='1';
    MemtoReg<='0';
    ALUOp<="011";
elsif IFID_Instruction(15 downto 13)="100" then --beq
    RegDst <= '0';
    RegWrite<='0';
    ALUsrc<='0';
    jump<='0';
    Branch<='1';
    MemWrite<='0';
    MemtoReg<='0';
    ALUOp<="100";
elsif IFID_Instruction(15 downto 13)="101" then --andi
    RegDst <= '0';
    RegWrite<='0';
    ALUsrc<='0';
    jump<='0';
    Branch<='0';
    MemWrite<='0';
    MemtoReg<='0';
    ALUOp<="101";    --?
elsif IFID_Instruction(15 downto 13)="110" then --ori
    RegDst <= '0';
    RegWrite<='0';
    ALUsrc<='0';
    jump<='0';
    Branch<='0';
    MemWrite<='0';
    MemtoReg<='0';
    ALUOp<="110";    --?
elsif IFID_Instruction(15 downto 13)="111" then --j
    RegDst <= '0';
    RegWrite<='0';
    ALUsrc<='0';
    jump<='1';
    Branch<='0';
    MemWrite<='0';
    MemtoReg<='0';
    ALUOp<="111"; --?
end if;
end process;
led(0)<=RegDst;
led(1)<=RegWrite;
led(2)<=ALUsrc;
led(3)<=jump;
led(4)<=Branch;
led(5)<=MemWrite;
led(6)<=MemtoReg;
led(9 downto 7)<=ALUOp;


mpg_inst_4: MPG port map(enable3,btn(3),clk);
--ALU_inst: EX port map(afispc,rd1,AluSrc,rd2,ext_imm,sa,func,ALUOp,Zero,ALURes,ALUSalt);
ALU_inst: EX port map(IDEX_PC,IDEX_RD1,IDEX_AluSrc,IDEX_RD2,IDEX_Ext,IDEX_Sa,IDEX_Func,IDEX_ALUOp,Zero,ALURes,ALUSalt);
--MEM_inst: MEM port map(ALURes,rd2,clk,memwrite,enable,readData);
MEM_inst: MEM port map(EXMEM_ALURez,EXMEM_RD2,clk,EXMEM_MemWrite,enable,readData);
--mux dreapta
--process(MemToReg)
--begin
--if (MemToReg = '1') then iesire_dr<=readData;
--else iesire_dr<=ALURes;
--end if;
--end process;
process(MEMWB_MemToReg)
begin
if (MEMWB_MemToReg = '1') then iesire_dr<=MEMWB_RD;
else iesire_dr<=MEMWB_ALURez;
end if;
end process;
pcSrc <= EXMEM_Branch and EXMEM_Zero; 
--undeSare <= "000"&afisinstr(12 downto 0);
undeSare <= "000"&IFID_Instruction(12 downto 0);

--------------LAB11------------------

MPG_inst3: mpg port map(btnFSM,btn(2),clk);
MPG_inst4: mpg port map(RST,btn(4),clk);
--process(clk)
--begin
--if rising_edge(clk) then
--    if btnFSM = '1' then TX_EN <= '1';
--    end if;
--    if BAUD_EN ='1' then TX_EN <= '0';
--    end if;
--end if;
--end process;

--process(clk)
--begin
--if rising_edge(clk) then
--if count = "10100010110000" then 
--    BAUD_EN <= '1';
--    count<="00000000000000";
--else count<=count+1;
--     BAUD_EN <= '0';
--end if;
--end if;
--end process;

--FSM_inst: TX_FSM port map(sw(15 downto 8),TX_EN,RST,BAUD_EN,clk,TX,TX_RDY);


---------------lab12--------------
process(clk)
begin
if rising_edge(clk) then
if count = "1010001011" then
    BAUD_EN <= '1';
    count<="0000000000";
else count<=count+1;
     BAUD_EN <= '0';
end if;
end if;
end process;

FSM_inst: RX_FSM port map(RX,RX_RDY,RX_DATA,BAUD_EN,RST,clk);
SSD_inst3: SSD port map(RX_DATA(3 downto 0),RX_DATA(7 downto 4),"0000","0000",clk,cat,an);

end Behavioral;
