library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.NUMERIC_STD.ALL;


entity VedicMult4x4 is
    Port ( 
        i_A  : in STD_LOGIC_VECTOR(3 downto 0);
        i_B  : in STD_LOGIC_VECTOR(3 downto 0);
        o_AB : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0')
    );
end VedicMult4x4;


architecture Behavioral of VedicMult4x4 is

  signal w_R1   : STD_LOGIC_VECTOR(17 downto 0) := (others => '0');

  signal w_AB1  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
  signal o_COUT : STD_LOGIC_VECTOR(14 downto 0) := (others => '0');

  begin
	w_AB1(0 downto 0)  <= (i_A(0 downto 0) AND i_B(0 downto 0));  
   	o_COUT(0 downto 0) <= "0";


   	w_R1(2 downto 0)   <=  "000" + (
					"000" +(i_A(0 downto 0) AND i_B(1 downto 1)) + 
			       		"000" +(i_A(1 downto 1) AND i_B(0 downto 0))
				);
	w_AB1(1 downto 1)  <= w_R1(0 downto 0);
   	o_COUT(2 downto 1) <= w_R1(2 downto 1);


	w_R1(5 downto 3)   <=  "000" + (
					"000" + (i_A(0 downto 0) AND i_B(2 downto 2)) + 
			       		"000" + (i_A(2 downto 2) AND i_B(0 downto 0)) + 
			       		"000" + (i_A(1 downto 1) AND i_B(1 downto 1)) + 
                              		o_COUT(2 downto 1)
				);
	w_AB1(2 downto 2)  <= w_R1(3 downto 3);
        o_COUT(4 downto 3) <= w_R1(5 downto 4);


	w_R1(8 downto 6)   <=  "000" + (
					"000" + (i_A(0 downto 0) AND i_B(3 downto 3)) + 
			       		"000" + (i_A(3 downto 3) AND i_B(0 downto 0)) + 
			                "000" + (i_A(1 downto 1) AND i_B(2 downto 2)) + 
			       		"000" + (i_A(2 downto 2) AND i_B(1 downto 1)) +
                               		o_COUT(4 downto 3)
				);
	w_AB1(3 downto 3)  <= w_R1(6 downto 6);
        o_COUT(6 downto 5) <= w_R1(8 downto 7);


	w_R1(11 downto 9)   <=  "000" + (
					"000" + (i_A(1 downto 1) AND i_B(3 downto 3)) + 
			       		"000" + (i_A(3 downto 3) AND i_B(1 downto 1)) + 
			       		"000" +(i_A(2 downto 2) AND i_B(2 downto 2))  +
                               		o_COUT(6 downto 5)
				);
	w_AB1(4 downto 4)  <= w_R1(9 downto 9);
        o_COUT(8 downto 7) <= w_R1(11 downto 10);


	w_R1(14 downto 12)  <=  "000" + (
					"000" + (i_A(2 downto 2) AND i_B(3 downto 3)) + 
			       		"000" + (i_A(3 downto 3) AND i_B(2 downto 2))  + 
                              		o_COUT(8 downto 7)
				);
	w_AB1(5 downto 5)  <= w_R1(12 downto 12);
        o_COUT(10 downto 9) <= w_R1(14 downto 13);


	w_R1(17 downto 15) <=  "000" + (
					"000" + (i_A(3 downto 3) AND i_B(3 downto 3)) + 
                               		o_COUT(10 downto 9)
				);

	w_AB1(7 downto 6)  <= w_R1(16 downto 15);



   o_AB <= w_AB1;

end Behavioral;