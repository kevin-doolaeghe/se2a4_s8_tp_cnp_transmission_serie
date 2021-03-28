----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2021 21:47:00
-- Design Name: 
-- Module Name: frequency_divider_tb - Behavioral
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

entity frequency_divider_tb is
end frequency_divider_tb;

architecture behavioral of frequency_divider_tb is

component frequency_divider
    generic (
        MAX_CNT : integer := 8
    );
    port (
        iClk : in std_logic;
        oClk : out std_logic
    );
end component;

signal clk : std_logic;
signal oClk : std_logic;

constant clk_period: time:= 1ns;

begin

    test : frequency_divider port map (
        iClk => clk,
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
        wait;
    end process;

end behavioral;
