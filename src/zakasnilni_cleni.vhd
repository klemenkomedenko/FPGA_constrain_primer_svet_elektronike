library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zakasnilni_cleni is
    Port ( 
        clk   : in  STD_LOGIC;
        d_in  : in  STD_LOGIC;
        d_out : out STD_LOGIC
    );
end zakasnilni_cleni;

architecture Behavioral of zakasnilni_cleni is
    -- Signali za registre
    signal reg_in  : std_logic := '0';
    signal reg_out : std_logic := '0';
    
    -- Veriga signalov za negatorje (101 povezava za 100 negatorjev)
    signal chain   : std_logic_vector(100 downto 0);
    
    -- ATRIBUT: Prepreči Vivadu, da bi optimiziral te negatorje stran
    attribute DONT_TOUCH : string;
    attribute DONT_TOUCH of chain : signal is "true";

begin

    -- Vhodni D Flip-Flop (DFF)
    process(clk)
    begin
        if rising_edge(clk) then
            reg_in <= d_in;
        end if;
    end process;

    -- Veriga 100 negatorjev
    chain(0) <= reg_in;
    
    gen_inv: for i in 0 to 99 generate
        chain(i+1) <= not chain(i);
    end generate;

    -- Izhodni D Flip-Flop (DFF)
    process(clk)
    begin
        if rising_edge(clk) then
           reg_out <= chain(100); -- Izhod zadnjega negatorja
        end if;
    end process;

    d_out <= reg_out;

end Behavioral;