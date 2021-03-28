----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2021 21:57:31
-- Design Name: 
-- Module Name: serial_transmitter_tb - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;

entity serial_transmitter_tb is
end serial_transmitter_tb;

architecture behavioral of serial_transmitter_tb is

component serial_transmitter
    generic (
        CLOCK_CNT : integer := 1042     -- 100 MHz / 9600 Bauds = 1042 cycles
    );
    port (
        iClk : in  std_logic;
        iEn : in  std_logic;
        iData : in  std_logic_vector (7 downto 0);
        oTx : out std_logic;
        oClk : out std_logic
    );
end component;

signal clk : std_logic;
signal bt : std_logic;
signal data : std_logic_vector (7 downto 0);
signal tx : std_logic;
signal oClk : std_logic;

constant clk_period: time:= 10ns;

begin

test : serial_transmitter port map (
    iClk => clk,
    iEn => bt,
    iData => data,
    oTx => tx,
    oClk => oClk
);

clk_process : process
begin
    clk <= '0';
    wait for clk_period / 2;
    clk <= '1';
    wait for clk_period / 2;
end process;

stim_proc : process
begin
    wait for 10 ns;
    bt <= '0';
    data <= (others => '0');
    
    wait for 10 ns;
    data <= "00110100";
    
    wait for 100 us;
    bt <= '1';
    
    wait for 100 us;
    bt <= '0';
    
    wait for 10 ns;
    data <= "00000000";
    
    wait for 100 us;
    bt <= '1';
    
    wait for 100 us;
    bt <= '0';
    
    wait for 10 ns;
    data <= "01111010";
    
    wait for 100 us;
    bt <= '1';
    
    wait for 100 us;
    bt <= '0';
    
    wait;
end process;

end behavioral;
