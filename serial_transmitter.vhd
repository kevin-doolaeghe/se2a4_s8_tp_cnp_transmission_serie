----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 23.03.2021 21:55:41
-- Design Name:
-- Module Name: serial_transmitter - Behavioral
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
use ieee.numeric_std.all;

entity serial_transmitter is
    generic (
        CLOCK_CNT : integer := 5208 -- 100 MHz / 9600 Bds = 10417 clock cycles
    );
    port (
        iClk : in std_logic;
        iEn : in std_logic;
        iData : in std_logic_vector (7 downto 0);
        oTx : out std_logic;
        oClk : out std_logic
    );
end serial_transmitter;

architecture behavioral of serial_transmitter is

    -- Introduce frequency divider
    component frequency_divider
        generic (
            MAX_CNT : integer := CLOCK_CNT
        );
        port (
            iClk : in std_logic;
            oClk : out std_logic
        );
    end component;

    -- Signals definition
    signal state : std_logic_vector (1 downto 0) := (others => '0');
    signal clk : std_logic;
    signal en_old : std_logic := '0';
    signal id : integer range 0 to 7 := 0;
    signal data_tmp : std_logic_vector (7 downto 0) := (others => '0');

begin

    -- Frequency divider port mapping
    freq_div : frequency_divider port map (
        iClk => iClk,
        oClk => clk
    );

    process (clk)
    begin
        -- If there is a rising edge of the clock...
        if rising_edge(clk) then
            -- Detect current state
            case state is
                -- Idle state
                when "00" =>
                    oTx <= '1';    -- High impedance when state is idle

                    -- If serial transmission is enabled
                    if iEn = '1' and en_old = '0' then
                        -- Load data
                        data_tmp <= iData;
                        state <= "01"; -- Start state
                    else
                        state <= "00"; -- Idle state
                    end if;

                -- Start state
                when "01" =>
                    -- Send start bit
                    oTx <= '0';
                    id <= 0;
                    state <= "10"; -- Data state

                -- Data state
                when "10" =>
                    -- Send correct data bit
                    oTx <= data_tmp(id);

                    -- Detect end of data state
                    if id < 7 then
                        -- Increment id to send next data bit
                        id <= id + 1;
                        state <= "10"; -- Data state
                    else
                        state <= "11"; -- Stop state
                    end if;

                -- Stop state
                when "11" =>
                    -- Send stop bit
                    oTx <= '1';
                    state <= "00"; -- Idle state

                -- Other states
                when others =>
                    state <= "00"; -- Idle state

            end case;
            en_old <= iEn;
        end if;
    end process;

    oClk <= clk;

end behavioral;

