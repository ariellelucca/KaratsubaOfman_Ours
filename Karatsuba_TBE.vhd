library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Karatsuba_TBE is
    Generic(
	Size  : natural := 16;
	WSize : natural := 4
    );
end Karatsuba_TBE;

architecture arch_1 of Karatsuba_TBE is
    signal w_X   : STD_LOGIC_VECTOR(Size-1 downto 0);
    signal w_Y   : STD_LOGIC_VECTOR(Size-1 downto 0);
    signal w_CLK : STD_LOGIC;
    signal w_RSTn: STD_LOGIC;
    signal w_XY  : STD_LOGIC_VECTOR(2*Size-1 downto 0);
begin 

  KO1: entity work.KaratsubaOfman
    generic map (
      Size => Size,
      WSize => WSize
    )
    port map (
     i_X    => w_X,
     i_Y    => w_Y,
     i_CLK  => w_CLK,
     i_RSTn => w_RSTn,
     o_XY   => w_XY
   );
  

  process
  begin
    w_RSTn <= '0';
    wait for 2 ns;
    w_RSTn <= '1';
    wait;
  end process;      


  process
  begin
    w_CLK <= '1';
    wait for 1 ns;
    w_CLK <= '0';
    wait for 1 ns;
  end process;     


  process 
  begin
    w_X <= "1101000010100010";
    w_Y <= "0000000010111101";
    wait for 10 ns;
  end process;

end arch_1;