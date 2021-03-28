library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is
    generic (
        SIZE : integer := 8
    );
    port ( 
        iClk : in std_logic;
        iRst : in std_logic;
        oCnt : out std_logic_vector (SIZE - 1 downto 0)
    );
end counter;

architecture behavioral of counter is

signal cnt : std_logic_vector (SIZE - 1 downto 0);

begin

    process(iClk)
    begin
        if rising_edge(iClk) then
            if (iRst = '1') then
                cnt <= (others => '0');
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
    
    oCnt <= cnt;

end behavioral;
