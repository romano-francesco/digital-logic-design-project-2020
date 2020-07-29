----------------------------------------------------------------------------------
-- Prova Finale Reti Logiche 2019/2020
-- Professore: Palermo Gianluca
-- Studente: Francesco Romano'
-- Matricola: 888514
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity project_reti_logiche is
  port (
    i_clk         : in std_logic;
    i_start       : in std_logic;
    i_rst         : in std_logic;
    i_data        : in std_logic_vector(7 downto 0);
    o_address     : out std_logic_vector(15 downto 0);
    o_done        : out std_logic;
    o_en          : out std_logic;
    o_we          : out std_logic;
    o_data        : out std_logic_vector(7 downto 0)
  );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is

    type state_type is (START, LOAD_WZ0, LOAD_WZ1, LOAD_WZ2, LOAD_WZ3, LOAD_WZ4, LOAD_WZ5, LOAD_WZ6, LOAD_WZ7, LOAD_ADDR, CHECK_WZ, DONE_STATE, WZ_DONE_STATE, TERMINATE_CONVERSION, DONE, NEW_START);
    signal next_state   : state_type;
    signal WZ_BIT       : std_logic := '0';
    signal WZ_NUM       : std_logic_vector(2 downto 0) := (others => '0');
    signal WZ_OFFSET    : std_logic_vector(3 downto 0);
    signal WZ_0         : UNSIGNED(7 downto 0);
    signal WZ_1         : UNSIGNED(7 downto 0);
    signal WZ_2         : UNSIGNED(7 downto 0);
    signal WZ_3         : UNSIGNED(7 downto 0);
    signal WZ_4         : UNSIGNED(7 downto 0);
    signal WZ_5         : UNSIGNED(7 downto 0);
    signal WZ_6         : UNSIGNED(7 downto 0);
    signal WZ_7         : UNSIGNED(7 downto 0);
    signal ADDR_TARGET  : UNSIGNED(7 downto 0);
    constant OFFSET_0   : std_logic_vector(3 downto 0) := ("0001");
    constant OFFSET_1   : std_logic_vector(3 downto 0) := ("0010");
    constant OFFSET_2   : std_logic_vector(3 downto 0) := ("0100");
    constant OFFSET_3   : std_logic_vector(3 downto 0) := ("1000");
    constant WZ_NUM_0   : std_logic_vector(2 downto 0) := ("000");
    constant WZ_NUM_1   : std_logic_vector(2 downto 0) := ("001");
    constant WZ_NUM_2   : std_logic_vector(2 downto 0) := ("010");
    constant WZ_NUM_3   : std_logic_vector(2 downto 0) := ("011");
    constant WZ_NUM_4   : std_logic_vector(2 downto 0) := ("100");
    constant WZ_NUM_5   : std_logic_vector(2 downto 0) := ("101");
    constant WZ_NUM_6   : std_logic_vector(2 downto 0) := ("110");
    constant WZ_NUM_7   : std_logic_vector(2 downto 0) := ("111");


begin
    
    STATE_REGISTER: process(i_clk, i_rst)
    begin
        if i_rst = '1' then
            next_state <= START;
            o_en <= '1';
            o_we <= '0';
            o_done <= '0';
            o_data <= (others => '0');
            o_address <= std_logic_vector(to_unsigned(0, 16));
        elsif (i_clk'event and i_clk = '0') then
        
            case next_state is
               
                when START =>
                    if (i_start = '0') then
                        o_en <= '1';
                        next_state <= START;
                    else
                        o_address <= std_logic_vector(to_unsigned(0, 16));
                        next_state <= LOAD_WZ0;
                    end if;
               
                when LOAD_WZ0 =>
                    WZ_0 <= UNSIGNED(i_data);
                    o_address <= std_logic_vector(to_unsigned(1, 16));
                    next_state <= LOAD_WZ1;
                    
                when LOAD_WZ1 =>
                    WZ_1 <= UNSIGNED(i_data);
                    o_address <= std_logic_vector(to_unsigned(2, 16));
                    next_state <= LOAD_WZ2;
                
                when LOAD_WZ2 =>
                    WZ_2 <= UNSIGNED(i_data);
                    o_address <= std_logic_vector(to_unsigned(3, 16));
                    next_state <= LOAD_WZ3;
                
                when LOAD_WZ3 =>
                    WZ_3 <= UNSIGNED(i_data);
                    o_address <= std_logic_vector(to_unsigned(4, 16));
                    next_state <= LOAD_WZ4;
                    
                when LOAD_WZ4 =>
                    WZ_4 <= UNSIGNED(i_data);
                    o_address <= std_logic_vector(to_unsigned(5, 16));
                    next_state <= LOAD_WZ5;
                    
                when LOAD_WZ5 =>
                    WZ_5 <= UNSIGNED(i_data);
                    o_address <= std_logic_vector(to_unsigned(6, 16));
                    next_state <= LOAD_WZ6;
                    
                when LOAD_WZ6 =>
                    WZ_6 <= UNSIGNED(i_data);
                    o_address <= std_logic_vector(to_unsigned(7, 16));
                    next_state <= LOAD_WZ7;
                    
                when LOAD_WZ7 =>
                    WZ_7 <= UNSIGNED(i_data);
                    o_address <= std_logic_vector(to_unsigned(8, 16));
                    next_state <= LOAD_ADDR;
                    
                when LOAD_ADDR =>
                    ADDR_TARGET <= UNSIGNED(i_data);
                    o_address <= std_logic_vector(to_unsigned(9, 16));
                    next_state <= CHECK_WZ;
                
                when CHECK_WZ =>
                    if ADDR_TARGET = WZ_0 then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_0;
                        WZ_OFFSET <= OFFSET_0;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_0 + to_unsigned(1, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_0;
                        WZ_OFFSET <= OFFSET_1;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_0 + to_unsigned(2, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_0;
                        WZ_OFFSET <= OFFSET_2;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_0 + to_unsigned(3, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_0;
                        WZ_OFFSET <= OFFSET_3;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_1 then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_1;
                        WZ_OFFSET <= OFFSET_0;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_1 + to_unsigned(1, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_1;
                        WZ_OFFSET <= OFFSET_1;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_1 + to_unsigned(2, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_1;
                        WZ_OFFSET <= OFFSET_2;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_1 + to_unsigned(3, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_1;
                        WZ_OFFSET <= OFFSET_3;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_2 then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_2;
                        WZ_OFFSET <= OFFSET_0;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_2 + to_unsigned(1, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_2;
                        WZ_OFFSET <= OFFSET_1;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_2 + to_unsigned(2, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_2;
                        WZ_OFFSET <= OFFSET_2;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_2 + to_unsigned(3, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_2;
                        WZ_OFFSET <= OFFSET_3;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_3 then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_3;
                        WZ_OFFSET <= OFFSET_0;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_3 + to_unsigned(1, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_3;
                        WZ_OFFSET <= OFFSET_1;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_3 + to_unsigned(2, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_3;
                        WZ_OFFSET <= OFFSET_2;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_3 + to_unsigned(3, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_3;
                        WZ_OFFSET <= OFFSET_3;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_4 then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_4;
                        WZ_OFFSET <= OFFSET_0;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_4 + to_unsigned(1, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_4;
                        WZ_OFFSET <= OFFSET_1;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_4 + to_unsigned(2, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_4;
                        WZ_OFFSET <= OFFSET_2;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_4 + to_unsigned(3, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_4;
                        WZ_OFFSET <= OFFSET_3;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_5 then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_5;
                        WZ_OFFSET <= OFFSET_0;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_5 + to_unsigned(1, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_5;
                        WZ_OFFSET <= OFFSET_1;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_5 + to_unsigned(2, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_5;
                        WZ_OFFSET <= OFFSET_2;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_5 + to_unsigned(3, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_5;
                        WZ_OFFSET <= OFFSET_3;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_6 then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_6;
                        WZ_OFFSET <= OFFSET_0;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_6 + to_unsigned(1, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_6;
                        WZ_OFFSET <= OFFSET_1;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_6 + to_unsigned(2, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_6;
                        WZ_OFFSET <= OFFSET_2;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_6 + to_unsigned(3, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_6;
                        WZ_OFFSET <= OFFSET_3;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_7 then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_7;
                        WZ_OFFSET <= OFFSET_0;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_7 + to_unsigned(1, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_7;
                        WZ_OFFSET <= OFFSET_1;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_7 + to_unsigned(2, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_7;
                        WZ_OFFSET <= OFFSET_2;
                        next_state <= WZ_DONE_STATE;
                    elsif ADDR_TARGET = WZ_7 + to_unsigned(3, 8) then
                        WZ_BIT <= '1';
                        WZ_NUM <= WZ_NUM_7;
                        WZ_OFFSET <= OFFSET_3;
                        next_state <= WZ_DONE_STATE;
                    else
                        next_state <= DONE_STATE;
                    end if;
                    
                when WZ_DONE_STATE =>
                    o_we <= '1';
                    o_data <= WZ_BIT & WZ_NUM & WZ_OFFSET;
                    next_state <= TERMINATE_CONVERSION;
                
                when DONE_STATE =>
                    o_we <= '1';
                    o_data <= std_logic_vector(ADDR_TARGET);
                    next_state <= TERMINATE_CONVERSION;
                
                when TERMINATE_CONVERSION =>
                    o_we <= '0';
                    o_done <= '1';
                    o_data <= (others => '0');
                    WZ_NUM <= "000";
                    WZ_BIT <= '0';
                    WZ_OFFSET <= "0000";
                    next_state <= DONE;
                    
                when DONE =>
                    o_done <= '0';
                    o_address <= std_logic_vector(to_unsigned(8, 16));
                    next_state <= NEW_START;
                    
                --Nuovo segnale di i_start    
                when NEW_START =>
                    if(i_start = '0') then
                        next_state <= NEW_START;
                    else
                        ADDR_TARGET <= UNSIGNED(i_data);
                        o_address <= std_logic_vector(to_unsigned(9, 16));
                        next_state <= CHECK_WZ;
                    end if;
            end case;
        end if;
    end process;              
                    
end Behavioral;
