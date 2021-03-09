library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity VedicMult4x4 is
    Port ( 
        i_A  : in STD_LOGIC_VECTOR(3 downto 0);
        i_B  : in STD_LOGIC_VECTOR(3 downto 0);
        o_AB : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0')
    );
end VedicMult4x4;


architecture Behavioral of VedicMult4x4 is

  signal w_R1   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

  signal w_AB1  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
  signal o_COUT : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

  begin
	w_AB1(0 downto 0) <= (i_A(0 downto 0) AND i_B(0 downto 0));
        o_COUT(0 downto 0) <= "0";


        w_R1(1 downto 0) <= ((i_A(0 downto 0) * i_B(1 downto 1)) + (i_A(1 downto 1) * i_B(0 downto 0))) ;
	w_AB1(1 downto 1)  <= w_R1(0 downto 0);
        o_COUT(1 downto 1) <= w_R1(1 downto 1);


	w_R1(3 downto 2) <= ((i_A(0 downto 0) * i_B(2 downto 2)) + 
			    (i_A(2 downto 2) * i_B(0 downto 0))  + 
			    (i_A(1 downto 1) * i_B(1 downto 1))  + 
                             o_COUT(1 downto 1));
	w_AB1(2 downto 2)  <= w_R1(2 downto 2);
        o_COUT(2 downto 2) <= w_R1(3 downto 3);


	w_R1(5 downto 4) <= ((i_A(0 downto 0) * i_B(3 downto 3)) + 
			    (i_A(3 downto 3) * i_B(0 downto 0))  + 
			    (i_A(1 downto 1) * i_B(2 downto 2))  + 
			    (i_A(2 downto 2) * i_B(1 downto 1))  +
                             o_COUT(2 downto 2));
	w_AB1(3 downto 3)  <= w_R1(4 downto 4);
        o_COUT(3 downto 3) <= w_R1(5 downto 5);


	w_R1(7 downto 6) <= ((i_A(1 downto 1) * i_B(3 downto 3)) + 
			    (i_A(3 downto 3) * i_B(1 downto 1))  + 
			    (i_A(2 downto 2) * i_B(2 downto 2))  +
                             o_COUT(3 downto 3));
	w_AB1(4 downto 4)  <= w_R1(6 downto 6);
        o_COUT(4 downto 4) <= w_R1(7 downto 7);


	w_R1(9 downto 8) <= ((i_A(2 downto 2) * i_B(3 downto 3)) + 
			    (i_A(3 downto 3) * i_B(2 downto 2))  + 
                             o_COUT(4 downto 4));
	w_AB1(5 downto 5)  <= w_R1(8 downto 8);
        o_COUT(5 downto 5) <= w_R1(9 downto 9);


	w_R1(11 downto 10) <= ((i_A(3 downto 3) * i_B(3 downto 3)) + 
                             o_COUT(5 downto 5));

	w_AB1(7 downto 6)  <= w_R1(11 downto 10);


-- A0 X B6 + A6 X B0 + A1 X B5 + A5 X B1 + A2 X B4 + A4 X B2 + A3 X B3

	w_R1(17 downto 15) <= '0'&((i_A(0 downto 0) * i_B(6 downto 6)) + 
			    (i_A(6 downto 6) * i_B(0 downto 0))  + 
			    (i_A(1 downto 1) * i_B(5 downto 5))  + 
			    (i_A(5 downto 5) * i_B(1 downto 1))  + 
			    (i_A(2 downto 2) * i_B(4 downto 4))  + 
			    (i_A(4 downto 4) * i_B(2 downto 2))  + 
			    (i_A(3 downto 3) * i_B(3 downto 3))  + 
                             o_COUT(10 downto 9));

	w_AB1(6 downto 6)  <= w_R1(15 downto 15);
        o_COUT(12 downto 11) <= w_R1(17 downto 16);


-- A0 X B7 + A7 X B0 + A1 X B6 + A6 X B1 + A2 X B5 + A5 X B2 + A3 X B4 + A4 X B3

	w_R1(20 downto 18) <= '0'&((i_A(0 downto 0) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(0 downto 0))  + 
			    (i_A(1 downto 1) * i_B(6 downto 6))  + 
			    (i_A(6 downto 6) * i_B(1 downto 1))  + 
			    (i_A(2 downto 2) * i_B(5 downto 5))  + 
			    (i_A(5 downto 5) * i_B(2 downto 2))  + 
			    (i_A(3 downto 3) * i_B(4 downto 4))  + 
			    (i_A(4 downto 4) * i_B(3 downto 3))  + 
                             o_COUT(12 downto 11));

	w_AB1(7 downto 7)  <= w_R1(18 downto 18);
        o_COUT(14 downto 13) <= w_R1(20 downto 19);



-- A1 X B7 + A7 X B1 + A2 X B6 + A6 X B2 + A3 X B5 + A5 X B3 + A4 X B4

	w_R1(23 downto 21) <= '0'&((i_A(1 downto 1) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(1 downto 1))  + 
			    (i_A(2 downto 2) * i_B(6 downto 6))  + 
			    (i_A(6 downto 6) * i_B(2 downto 2))  + 
			    (i_A(3 downto 3) * i_B(5 downto 5))  + 
			    (i_A(5 downto 5) * i_B(3 downto 3))  + 
			    (i_A(4 downto 4) * i_B(4 downto 4))  + 
                             o_COUT(14 downto 13));

	w_AB1(8 downto 8)  <= w_R1(21 downto 21);
        o_COUT(16 downto 15) <= w_R1(23 downto 22);


-- A2 X B7 + A7 X B2 + A3 X B6 + A6 X B3 + A4 X B5 + A5 X B4 

	w_R1(26 downto 24) <= '0'&((i_A(2 downto 2) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(2 downto 2))  + 
			    (i_A(3 downto 3) * i_B(6 downto 6))  + 
			    (i_A(6 downto 6) * i_B(3 downto 3))  + 
			    (i_A(4 downto 4) * i_B(5 downto 5))  + 
			    (i_A(5 downto 5) * i_B(4 downto 4))  + 
                             o_COUT(16 downto 15));

	w_AB1(9 downto 9)  <= w_R1(24 downto 24);
        o_COUT(18 downto 17) <= w_R1(26 downto 25);

-- A3 X B7 + A7 X B3 + A4 X B6 + A6 X B4 + A5 X B5

	w_R1(29 downto 27) <= '0'&((i_A(3 downto 3) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(3 downto 3))  + 
			    (i_A(4 downto 4) * i_B(6 downto 6))  + 
			    (i_A(6 downto 6) * i_B(4 downto 4))  + 
			    (i_A(5 downto 5) * i_B(5 downto 5))  + 
                             o_COUT(18 downto 17));

	w_AB1(10 downto 10)  <= w_R1(27 downto 27);
        o_COUT(20 downto 19) <= w_R1(29 downto 28);

-- A4 X B7 + A7 X B4 + A5 X B6 + A6 X B5

	w_R1(32 downto 30) <= '0'&((i_A(4 downto 4) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(4 downto 4))  + 
			    (i_A(5 downto 5) * i_B(6 downto 6))  + 
			    (i_A(6 downto 6) * i_B(5 downto 5))  + 
                             o_COUT(20 downto 19));

	w_AB1(11 downto 11)  <= w_R1(30 downto 30);
        o_COUT(22 downto 21) <= w_R1(32 downto 31);

-- A5 X B7 + A7 X B5 + A6 X B6

	w_R1(35 downto 33) <= '0'&((i_A(5 downto 5) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(5 downto 5))  + 
			    (i_A(6 downto 6) * i_B(6 downto 6))  + 
                             o_COUT(22 downto 21));

	w_AB1(12 downto 12)  <= w_R1(33 downto 33);
        o_COUT(24 downto 23) <= w_R1(35 downto 34);

-- A6 X B7 + A7 X B6

	w_R1(38 downto 36) <= '0'&((i_A(6 downto 6) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(6 downto 6))  + 
                             o_COUT(24 downto 23));

	w_AB1(13 downto 13)  <= w_R1(36 downto 36);
        o_COUT(26 downto 25) <= w_R1(38 downto 37);


-- A7 X B7

	w_R1(41 downto 39) <= '0'&((i_A(7 downto 7) * i_B(7 downto 7)) + 
			     o_COUT(26 downto 25));

	w_AB1(16 downto 14)  <= w_R1(41 downto 39);

        o_AB <= w_AB1;

end Behavioral;