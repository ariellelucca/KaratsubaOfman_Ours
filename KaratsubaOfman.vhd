library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity KaratsubaOfman is
    Generic(
	Size  : natural := 32;
	WSize : natural := 4
    );
    Port ( 
        i_X    : in STD_LOGIC_VECTOR(Size-1 downto 0);
        i_Y    : in STD_LOGIC_VECTOR(Size-1 downto 0);
	i_CLK  : in std_logic;
	i_RSTn : in std_logic;
        o_XY   : out STD_LOGIC_VECTOR(2*Size-1 downto 0)
    );
end KaratsubaOfman;

architecture RecursiveArchitecture of KaratsubaOfman is
  -- ADD1 e ADD2
  -- OK
  signal r_X, r_Y: std_logic_vector (Size-1 downto 0);


  -- The two one-bit carryin of these additions are represented in by CX and CY respectively
  signal w_CIX : STD_LOGIC := '0';
  signal w_CIY : STD_LOGIC := '0';

  -- The two one-bit carryout of these additions are represented in by CX and CY respectively
  -- OK
  signal w_CX  : STD_LOGIC;
  signal w_CY  : STD_LOGIC;
  -- OK

  -- High X and High Y
  -- OK
  signal w_HX  : STD_LOGIC_VECTOR(Size/2-1 downto 0);
  signal w_HY  : STD_LOGIC_VECTOR(Size/2-1 downto 0);
  -- OK

  -- Low X and Low Y
  -- OK
  signal w_LX  : STD_LOGIC_VECTOR(Size/2-1 downto 0);
  signal w_LY  : STD_LOGIC_VECTOR(Size/2-1 downto 0);
  -- OK

  -- PRODUCTS
  signal w_P1  : STD_LOGIC_VECTOR(Size-1 downto 0);
  signal w_P2  : STD_LOGIC_VECTOR(Size-1 downto 0);
  signal w_P3  : STD_LOGIC_VECTOR(Size-1 downto 0);
  signal w_PRODUCT3 : STD_LOGIC_VECTOR(Size+1 downto 0);


  -- ADDER
  signal w_ADD1_X : STD_LOGIC_VECTOR(Size/2-1 downto 0);
  signal w_ADD2_Y : STD_LOGIC_VECTOR(Size/2-1 downto 0);


  BEGIN 
    process(i_CLK, i_RSTn)
      begin
        if (i_RSTn = '0') then 
	  r_X <= (others => '0');
	  r_Y <= (others => '0');
        elsif (rising_edge(i_CLK)) then
          r_X <= i_X;
          r_Y <= i_Y;
        end if;
    end process;

    -- High X and High Y
    w_HX <= i_X(Size-1 downto Size/2);
    w_HY <= i_Y(Size-1 downto Size/2);

    -- Low X and Low Y
    w_LX <= i_X(Size/2-1 downto 0);
    w_LY <= i_Y(Size/2-1 downto 0);

    -- Selects the Vedic multiplier based on the size of WSize
    -- Case WSize = 4, generates VEDIC4X4 
    Termination4: if Size <= WSize and WSize = 4 generate
        VEDIC4X4: entity work.VedicMult4x4
            port map(
		i_A    => i_X,
		i_B    => i_Y,
		o_AB   => o_XY
	    );
    end generate Termination4;

    -- Case WSize = 8, generates VEDIC8X8     
    Termination8: if Size <= WSize and WSize = 8 generate
	VEDIC8X8: entity work.VedicMult8x8
	    port map(
		i_A    => i_X,
		i_B    => i_Y,
		o_AB   => o_XY
	    );
    end generate Termination8;
    
    -- Case WSize = 16, generates VEDIC16X16
    Termination16: if Size <= WSize and WSize = 16 generate
	VEDIC16X16: entity work.VedicMult16x16
	    port map(
		i_A    => i_X,
		i_B    => i_Y,
		o_AB   => o_XY
	    );
    end generate Termination16;


	
    -- Recursive KOA calls
    Recursion: if Size > WSize generate
    
    -- XH and XL adder
    ADDl: entity work.Adder
        generic map ( 
          p_K => Size/2
        )
        port map(
          i_X1    => i_X(Size/2-1 downto 0),
          i_X2    => i_X(Size-1 downto Size/2),
          i_CARRY => w_CIX,
          o_XX    => w_ADD1_X, 
	  o_CARRY => w_CX
    );

    -- YH and YL adder
    ADD2: entity work.Adder
        generic map ( 
          p_K => Size/2
        )
        port map(
          i_X1    => i_Y(Size/2-1 downto 0),
          i_X2    => i_Y(Size-1 downto Size/2),
          i_CARRY => w_CIY,
          o_XX    => w_ADD2_Y, 
	  o_CARRY => w_CY
    );
	

    -- First recursive call that multiplies XH and YH
    KOA1: entity work.KaratsubaOfman
         generic map (
           Size => Size/2
         )
         port map (
          i_X    => w_HX,
          i_Y    => w_HY,
          i_CLK => i_CLK,
          i_RSTn => i_RSTn,
          o_XY   => w_P1
    );


    -- Second recursive call that multiplies XL and YL
    KOA2: entity work.KaratsubaOfman
         generic map (
           Size => Size/2
         )
         port map (
          i_X    => w_LX,
          i_Y    => w_LY,
	  i_CLK => i_CLK,
          i_RSTn => i_RSTn,
          o_XY   => w_P2
    );


    -- Thirs recursive call that multiplies XH+XL (w_ADD1_X) and YH+XL (w_ADD2_Y)
    KO3: entity work.KaratsubaOfman
         generic map (
           Size => Size/2
         )
         port map (
          i_X    => w_ADD1_X,
          i_Y    => w_ADD2_Y,
	  i_CLK  => i_CLK,
          i_RSTn => i_RSTn,
          o_XY   => w_P3
    );
    
    
    SA: entity work.ShiftnAdder
         generic map (
           p_K => Size/2
         )
         port map (
          i_CLK      => i_CLK,
          i_RSTn     => i_RSTn,
          i_SXL      => w_ADD1_X,
          i_SYL      => w_ADD2_Y,
	  i_CX       => w_CX,
          i_CY       => w_CY,
	  i_P        => w_P3,
          o_PRODUCT3 => w_PRODUCT3
    );


    SSA: entity work.ShifterSubnAdder
         generic map (
           p_K => Size/2
         )
         port map (
          i_CLK      => i_CLK,
          i_RSTn     => i_RSTn,
          i_PRODUCT1 => w_P1,
          i_PRODUCT2 => w_P2,
	  i_PRODUCT3 => w_PRODUCT3,
          o_XY       => o_XY
    );


    end generate Recursion;

end RecursiveArchitecture;