library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity VedicMult16x16 is
    Port ( 
        i_A  : in STD_LOGIC_VECTOR(15 downto 0);
        i_B  : in STD_LOGIC_VECTOR(15 downto 0);
	o_AB : out STD_LOGIC_VECTOR(31 downto 0)
    );
end VedicMult16x16;


architecture Behavioral of VedicMult16x16 is

  type   t_P  is array (31 downto 0) OF std_logic_vector(4 downto 0);

  signal w_R1   : t_P;

  signal w_AB1  : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

  begin


-- A0 X B0
        w_R1(0)(2 downto 0) <=  "000" + (
				(i_A(0 downto 0) * i_B(0 downto 0)) -- 0
				);
	w_AB1(0 downto 0)  <= w_R1(0)(0 downto 0);

-- A0 X B1 + A1 X B0
        w_R1(1)(2 downto 0) <=  "000" + (i_A(0 downto 0) * i_B(1 downto 1)) +  -- 1
				"000" + (i_A(1 downto 1) * i_B(0 downto 0)) + -- 0
				"000" + w_R1(0)(2 downto 1);

	w_AB1(1 downto 1)  <= w_R1(1)(0 downto 0);

-- A0 X B2 + A2 X B0 + A2 X B2
	w_R1(2)(2 downto 0)   <= "000" + (i_A(0 downto 0) * i_B(2 downto 2))  +  -- 0
			         "000" + (i_A(2 downto 2) * i_B(0 downto 0))  +  -- 0
			         "000" + (i_A(1 downto 1) * i_B(1 downto 1)) +  -- 1
                                 "000" + w_R1(1)(2 downto 1);
	w_AB1(2 downto 2)  <= w_R1(2)(0 downto 0);


-- A0 X B3 + A3 X B0 + A1 X B2 + A2 X B1
	w_R1(3)(2 downto 0)   <= "000" + (i_A(0 downto 0) * i_B(3 downto 3)) +   -- 1
			         "000" + (i_A(3 downto 3) * i_B(0 downto 0)) +   -- 0
			         "000" + (i_A(1 downto 1) * i_B(2 downto 2)) +   -- 0
			         "000" + (i_A(2 downto 2) * i_B(1 downto 1)) +  -- 1
                                 "000" + w_R1(2)(2 downto 1);

	w_AB1(3 downto 3)  <= w_R1(3)(0 downto 0);


-- A0 X B4 + A4 X B0 + A1 X B3 + A3 X B1 + A2 X B2
	w_R1(4)(2 downto 0) <=  "000" + (i_A(0 downto 0) * i_B(4 downto 4)) +  -- 0
			    	"000" + (i_A(4 downto 4) * i_B(0 downto 0)) +  -- 0
			    	"000" + (i_A(1 downto 1) * i_B(3 downto 3)) +  -- 1
			    	"000" + (i_A(3 downto 3) * i_B(1 downto 1)) +  -- 1
			    	"000" + (i_A(2 downto 2) * i_B(2 downto 2)) + -- 0
                             	"000" + w_R1(3)(2 downto 1);

	w_AB1(4 downto 4)  <= w_R1(4)(0 downto 0);


-- A0 X B5 + A5 X B0 + A1 X B4 + A4 X B1 + A3 X B2 + A2 X B3
	w_R1(5)(2 downto 0) <=  "000" + (i_A(0 downto 0) * i_B(5 downto 5)) +   -- 1
			    	"000" + (i_A(5 downto 5) * i_B(0 downto 0)) +   -- 0
			    	"000" + (i_A(1 downto 1) * i_B(4 downto 4)) +   -- 0
			    	"000" + (i_A(4 downto 4) * i_B(1 downto 1)) +   -- 1
			    	"000" + (i_A(2 downto 2) * i_B(3 downto 3)) +   -- 1
				"000" + (i_A(3 downto 3) * i_B(2 downto 2)) +  -- 0
				"000" + w_R1(4)(2 downto 1);
	w_AB1(5 downto 5)    <= w_R1(5)(0 downto 0);


-- A0 X B6 + A6 X B0 + A1 X B5 + A5 X B1 + A2 X B4 + A4 X B2 + A3 X B3
	w_R1(6)(2 downto 0)  <= "000" + (i_A(0 downto 0) * i_B(6 downto 6))  +  -- 0
			    	"000" + (i_A(6 downto 6) * i_B(0 downto 0))  +  -- 0
			    	"000" + (i_A(1 downto 1) * i_B(5 downto 5))  +  -- 1
			    	"000" + (i_A(5 downto 5) * i_B(1 downto 1))  +  -- 1
 			    	"000" + (i_A(2 downto 2) * i_B(4 downto 4))  +  -- 0
			    	"000" + (i_A(4 downto 4) * i_B(2 downto 2))  +  -- 0
			    	"000" + (i_A(3 downto 3) * i_B(3 downto 3)) +  -- 1
                             	"000" + w_R1(5)(2 downto 1);

	w_AB1(6 downto 6)    <= w_R1(6)(0 downto 0);


-- A0 X B7 + A7 X B0 + A1 X B6 + A6 X B1 + A2 X B5 + A5 X B2 + A3 X B4 + A4 X B3
	w_R1(7)(2 downto 0)  <= "000" + (i_A(0 downto 0) * i_B(7 downto 7)) +  -- 1
				"000" + (i_A(7 downto 7) * i_B(0 downto 0)) +  -- 0
				"000" + (i_A(1 downto 1) * i_B(6 downto 6)) +  -- 0
				"000" + (i_A(6 downto 6) * i_B(1 downto 1)) +  -- 1
				"000" + (i_A(2 downto 2) * i_B(5 downto 5)) +  -- 1
				"000" + (i_A(5 downto 5) * i_B(2 downto 2)) +  -- 0
				"000" + (i_A(3 downto 3) * i_B(4 downto 4)) +  -- 0
				"000" + (i_A(4 downto 4) * i_B(3 downto 3)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A0 X B8 + A8 X B0 + A1 X B7 + A7 X B1 + A2 X B6 + A6 X B2 + A3 X B5 + A5 X B3 + A4 X B4
	w_R1(7)(2 downto 0)  <= "000" + (i_A(0 downto 0) * i_B(8 downto 8)) +  -- 1
				"000" + (i_A(8 downto 8) * i_B(0 downto 0)) +  -- 0
				"000" + (i_A(1 downto 1) * i_B(7 downto 7)) +  -- 0
				"000" + (i_A(7 downto 7) * i_B(1 downto 1)) +  -- 1
				"000" + (i_A(2 downto 2) * i_B(6 downto 6)) +  -- 1
				"000" + (i_A(6 downto 6) * i_B(2 downto 2)) +  -- 0
				"000" + (i_A(3 downto 3) * i_B(5 downto 5)) +  -- 0
				"000" + (i_A(5 downto 5) * i_B(3 downto 3)) +  -- 1
				"000" + (i_A(4 downto 4) * i_B(4 downto 4)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A0 X B9 + A9 X B0 + A1 X B8 + A8 X B1 + A2 X B7 + A7 X B2 + A3 X B6 + A6 X B3 + A5 X B4 + A4 X B5
	w_R1(7)(2 downto 0)  <= "000" + (i_A(0 downto 0) * i_B(9 downto 9)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(0 downto 0)) +  -- 0
				"000" + (i_A(1 downto 1) * i_B(8 downto 8)) +  -- 0
				"000" + (i_A(8 downto 8) * i_B(1 downto 1)) +  -- 1
				"000" + (i_A(2 downto 2) * i_B(7 downto 7)) +  -- 1
				"000" + (i_A(7 downto 7) * i_B(2 downto 2)) +  -- 0
				"000" + (i_A(3 downto 3) * i_B(6 downto 6)) +  -- 0
				"000" + (i_A(6 downto 6) * i_B(3 downto 3)) +  -- 1
				"000" + (i_A(5 downto 5) * i_B(4 downto 4)) +  -- 1
				"000" + (i_A(4 downto 4) * i_B(5 downto 5)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);

-- A0 X B10 + A10 X B0 + A1 X B9 + A9 X B1 + A2 X B8 + A8 X B2 + A3 X B7 + A7 X B3 + A4 X B6 + A6 X B4 + A5 X B5
	w_R1(7)(2 downto 0)  <= "000" + (i_A(0 downto 0) * i_B(10 downto 10)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(0 downto 0)) +  -- 0
				"000" + (i_A(1 downto 1) * i_B(9 downto 9)) +  -- 0
				"000" + (i_A(9 downto 9) * i_B(1 downto 1)) +  -- 1
				"000" + (i_A(2 downto 2) * i_B(8 downto 8)) +  -- 1
				"000" + (i_A(8 downto 8) * i_B(2 downto 2)) +  -- 0
				"000" + (i_A(3 downto 3) * i_B(7 downto 7)) +  -- 0
				"000" + (i_A(7 downto 7) * i_B(3 downto 3)) +  -- 1
				"000" + (i_A(4 downto 4) * i_B(6 downto 6)) +  -- 1
				"000" + (i_A(6 downto 6) * i_B(4 downto 4)) +  -- 1
				"000" + (i_A(5 downto 5) * i_B(5 downto 5)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A0 X B11 + A11 X B0 + A1 X B10 + A10 X B1 + A2 X B9 + A9 X B2 + A3 X B8 + A8 X B3 + A4 X B7 + A7 X B4 + A5 X B6 + A6 X B5
	w_R1(7)(2 downto 0)  <= "000" + (i_A(0 downto 0) * i_B(11 downto 11)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(0 downto 0)) +  -- 0
				"000" + (i_A(1 downto 1) * i_B(10 downto 10)) +  -- 0
				"000" + (i_A(10 downto 10) * i_B(1 downto 1)) +  -- 1
				"000" + (i_A(2 downto 2) * i_B(9 downto 9)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(2 downto 2)) +  -- 0
				"000" + (i_A(3 downto 3) * i_B(8 downto 8)) +  -- 0
				"000" + (i_A(8 downto 8) * i_B(3 downto 3)) +  -- 1
				"000" + (i_A(4 downto 4) * i_B(7 downto 7)) +  -- 1
				"000" + (i_A(7 downto 7) * i_B(4 downto 4)) +  -- 1
				"000" + (i_A(5 downto 5) * i_B(6 downto 6)) +  -- 1
				"000" + (i_A(6 downto 6) * i_B(5 downto 5)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);



-- A0 X B12 + A12 X B0 + A1 X B11 + A11 X B1 + A2 X B10 + A10 X B2 + A3 X B9 + A9 X B3 + A4 X B8 + A8 X B4 + A5 X B7 + A7 X B5 + A6 X B6
	w_R1(7)(2 downto 0)  <= "000" + (i_A(0 downto 0) * i_B(12 downto 12)) +  -- 1
				"000" + (i_A(12 downto 12) * i_B(0 downto 0)) +  -- 0
				"000" + (i_A(1 downto 1) * i_B(11 downto 11)) +  -- 0
				"000" + (i_A(11 downto 11) * i_B(1 downto 1)) +  -- 1
				"000" + (i_A(2 downto 2) * i_B(10 downto 10)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(2 downto 2)) +  -- 0
				"000" + (i_A(3 downto 3) * i_B(9 downto 9)) +  -- 0
				"000" + (i_A(9 downto 9) * i_B(3 downto 3)) +  -- 1
				"000" + (i_A(4 downto 4) * i_B(8 downto 8)) +  -- 1
				"000" + (i_A(8 downto 8) * i_B(4 downto 4)) +  -- 1
				"000" + (i_A(5 downto 5) * i_B(7 downto 7)) +  -- 1
				"000" + (i_A(7 downto 7) * i_B(5 downto 5)) +  -- 1
				"000" + (i_A(6 downto 6) * i_B(6 downto 6)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);

-- A0 X B13 + A13 X B0 + A1 X B12 + A12 X B1 + A2 X B11 + A11 X B2 + A3 X B10 + A10 X B3 + A4 X B9 + A9 X B4 + A5 X B8 + A8 X B5 + A6 X B7 + A7 X B6
	w_R1(7)(2 downto 0)  <= "000" + (i_A(0 downto 0) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(0 downto 0)) +  -- 0
				"000" + (i_A(1 downto 1) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(1 downto 1)) +  -- 1
				"000" + (i_A(2 downto 2) * i_B(11 downto 11)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(2 downto 2)) +  -- 0
				"000" + (i_A(3 downto 3) * i_B(10 downto 10)) +  -- 0
				"000" + (i_A(10 downto 10) * i_B(3 downto 3)) +  -- 1
				"000" + (i_A(4 downto 4) * i_B(9 downto 9)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(4 downto 4)) +  -- 1
				"000" + (i_A(5 downto 5) * i_B(8 downto 8)) +  -- 1
				"000" + (i_A(8 downto 8) * i_B(5 downto 5)) +  -- 1
				"000" + (i_A(6 downto 6) * i_B(7 downto 7)) +  -- 1
				"000" + (i_A(7 downto 7) * i_B(6 downto 6)) + -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A0 X B14 + A14 X B0 + A1 X B13 + A13 X B1 + A2 X B12 + A12 X B2 + A3 X B11 + A11 X B3 + A4 X B10 + A10 X B4 + A5 X B9 + A9 X B5 + A6 X B8 + A8 X B6 + A7 X B7
	w_R1(7)(2 downto 0)  <= "000" + (i_A(0 downto 0) * i_B(14 downto 14)) +  -- 1
				"000" + (i_A(14 downto 14) * i_B(0 downto 0)) +  -- 0
				"000" + (i_A(1 downto 1) * i_B(13 downto 13)) +  -- 0
				"000" + (i_A(13 downto 13) * i_B(1 downto 1)) +  -- 1
				"000" + (i_A(2 downto 2) * i_B(12 downto 12)) +  -- 1
				"000" + (i_A(12 downto 12) * i_B(2 downto 2)) +  -- 0
				"000" + (i_A(3 downto 3) * i_B(11 downto 11)) +  -- 0
				"000" + (i_A(11 downto 11) * i_B(3 downto 3)) +  -- 1
				"000" + (i_A(4 downto 4) * i_B(10 downto 10)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(4 downto 4)) +  -- 1
				"000" + (i_A(5 downto 5) * i_B(9 downto 9)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(5 downto 5)) +  -- 1
				"000" + (i_A(6 downto 6) * i_B(8 downto 8)) +  -- 1
				"000" + (i_A(8 downto 8) * i_B(6 downto 6)) + -- 1
				"000" + (i_A(7 downto 7) * i_B(7 downto 7)) + -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);

-- A0 X B15 + A15 X B0 + A1 X B14 + A14 X B1 + A2 X B13 + A13 X B2 + A3 X B12 + A12 X B3 + A4 X B11 + A11 X B4 + A5 X B10 + A10 X B5 + A6 X B9 + A9 X B6 + A7 X B8 + A8 X B7
	w_R1(7)(2 downto 0)  <= "000" + (i_A(0 downto 0) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(0 downto 0)) +  -- 0
				"000" + (i_A(1 downto 1) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(1 downto 1)) +  -- 1
				"000" + (i_A(2 downto 2) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(2 downto 2)) +  -- 0
				"000" + (i_A(3 downto 3) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(3 downto 3)) +  -- 1
				"000" + (i_A(4 downto 4) * i_B(11 downto 11)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(4 downto 4)) +  -- 1
				"000" + (i_A(5 downto 5) * i_B(10 downto 10)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(5 downto 5)) +  -- 1
				"000" + (i_A(6 downto 6) * i_B(9 downto 9)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(6 downto 6)) + -- 1
				"000" + (i_A(7 downto 7) * i_B(8 downto 8)) + -- 1
				"000" + (i_A(8 downto 8) * i_B(7 downto 7)) + -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);

--- FINAL 0 X 16

-- A1 X B15 + A15 X B1 + A2 X B14 + A14 X B2 + A3 X B13 + A13 X B3 + A4 X B12 + A12 X B4 + A5 X B11 + A11 X B5 + A6 X B10 + A10 X B6 + A7 X B9 + A9 X B7 + A8 X B8
	w_R1(7)(2 downto 0)  <= "000" + (i_A(1 downto 1) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(1 downto 1)) +  -- 0
				"000" + (i_A(2 downto 2) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(2 downto 2)) +  -- 1
				"000" + (i_A(3 downto 3) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(3 downto 3)) +  -- 0
				"000" + (i_A(4 downto 4) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(4 downto 4)) +  -- 1
				"000" + (i_A(5 downto 5) * i_B(11 downto 11)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(5 downto 5)) +  -- 1
				"000" + (i_A(6 downto 6) * i_B(10 downto 10)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(6 downto 6)) +  -- 1
				"000" + (i_A(7 downto 7) * i_B(9 downto 9)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(7 downto 7)) + -- 1
				"000" + (i_A(8 downto 8) * i_B(8 downto 8)) + -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A2 X B15 + A15 X B2 + A3 X B14 + A14 X B3 + A4 X B13 + A13 X B4 + A5 X B12 + A12 X B5 + A6 X B11 + A11 X B6 + A7 X B10 + A10 X B7 + A8 X B9 + A9 X B8
	w_R1(7)(2 downto 0)  <= "000" + (i_A(2 downto 2) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(2 downto 2)) +  -- 0
				"000" + (i_A(3 downto 3) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(3 downto 3)) +  -- 1
				"000" + (i_A(4 downto 4) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(4 downto 4)) +  -- 0
				"000" + (i_A(5 downto 5) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(5 downto 5)) +  -- 1
				"000" + (i_A(6 downto 6) * i_B(11 downto 11)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(6 downto 6)) +  -- 1
				"000" + (i_A(7 downto 7) * i_B(10 downto 10)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(7 downto 7)) +  -- 1
				"000" + (i_A(8 downto 8) * i_B(9 downto 9)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(8 downto 8)) + -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A3 X B15 + A15 X B3 + A4 X B14 + A14 X B4 + A5 X B13 + A13 X B5 + A6 X B12 + A12 X B6 + A7 X B11 + A11 X B7 + A8 X B10 + A10 X B8 + A9 X B9
	w_R1(7)(2 downto 0)  <= "000" + (i_A(3 downto 3) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(3 downto 3)) +  -- 0
				"000" + (i_A(4 downto 4) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(4 downto 4)) +  -- 1
				"000" + (i_A(5 downto 5) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(5 downto 5)) +  -- 0
				"000" + (i_A(6 downto 6) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(6 downto 6)) +  -- 1
				"000" + (i_A(7 downto 7) * i_B(11 downto 11)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(7 downto 7)) +  -- 1
				"000" + (i_A(8 downto 8) * i_B(10 downto 10)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(8 downto 8)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(9 downto 9)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A4 X B15 + A15 X B4 + A5 X B14 + A14 X B5 + A6 X B13 + A13 X B6 + A7 X B12 + A12 X B7 + A8 X B11 + A11 X B8 + A9 X B10 + A10 X B9
	w_R1(7)(2 downto 0)  <= "000" + (i_A(4 downto 4) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(4 downto 4)) +  -- 0
				"000" + (i_A(5 downto 5) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(5 downto 5)) +  -- 1
				"000" + (i_A(6 downto 6) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(6 downto 6)) +  -- 0
				"000" + (i_A(7 downto 7) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(7 downto 7)) +  -- 1
				"000" + (i_A(8 downto 8) * i_B(11 downto 11)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(8 downto 8)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(10 downto 10)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(9 downto 9)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A5 X B15 + A15 X B5 + A6 X B14 + A14 X B6 + A7 X B13 + A13 X B7 + A8 X B12 + A12 X B8 + A9 X B11 + A11 X B9 + A10 X B10
	w_R1(7)(2 downto 0)  <= "000" + (i_A(5 downto 5) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(5 downto 5)) +  -- 0
				"000" + (i_A(6 downto 6) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(6 downto 6)) +  -- 1
				"000" + (i_A(7 downto 7) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(7 downto 7)) +  -- 0
				"000" + (i_A(8 downto 8) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(8 downto 8)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(11 downto 11)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(9 downto 9)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(10 downto 10)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A6 X B15 + A15 X B6 + A7 X B14 + A14 X B7 + A8 X B13 + A13 X B8 + A9 X B12 + A12 X B9 + A10 X B11 + A11 X B10
	w_R1(7)(2 downto 0)  <= "000" + (i_A(6 downto 6) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(6 downto 6)) +  -- 0
				"000" + (i_A(7 downto 7) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(7 downto 7)) +  -- 1
				"000" + (i_A(8 downto 8) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(8 downto 8)) +  -- 0
				"000" + (i_A(9 downto 9) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(9 downto 9)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(11 downto 11)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(10 downto 10)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A7 X B15 + A15 X B7 + A8 X B14 + A14 X B8 + A9 X B13 + A13 X B9 + A10 X B12 + A12 X B10 + A11 X B11
	w_R1(7)(2 downto 0)  <= "000" + (i_A(7 downto 7) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(7 downto 7)) +  -- 0
				"000" + (i_A(8 downto 8) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(8 downto 8)) +  -- 1
				"000" + (i_A(9 downto 9) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(9 downto 9)) +  -- 0
				"000" + (i_A(10 downto 10) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(10 downto 10)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(11 downto 11)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);



-- A8 X B15 + A15 X B8 + A9 X B14 + A14 X B9 + A10 X B13 + A13 X B10 + A11 X B12 + A12 X B11
	w_R1(7)(2 downto 0)  <= "000" + (i_A(8 downto 8) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(8 downto 8)) +  -- 0
				"000" + (i_A(9 downto 9) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(9 downto 9)) +  -- 1
				"000" + (i_A(10 downto 10) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(10 downto 10)) +  -- 0
				"000" + (i_A(11 downto 11) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(11 downto 11)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A9 X B15 + A15 X B9 + A10 X B14 + A14 X B10 + A11 X B13 + A13 X B11 + A12 X B12
	w_R1(7)(2 downto 0)  <= "000" + (i_A(9 downto 9) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(9 downto 9)) +  -- 0
				"000" + (i_A(10 downto 10) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(10 downto 10)) +  -- 1
				"000" + (i_A(11 downto 11) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(11 downto 11)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(12 downto 12)) +  -- 0
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A10 X B15 + A15 X B10 + A11 X B14 + A14 X B11 + A12 X B13 + A13 X B12
	w_R1(7)(2 downto 0)  <= "000" + (i_A(10 downto 10) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(10 downto 10)) +  -- 0
				"000" + (i_A(11 downto 11) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(11 downto 11)) +  -- 1
				"000" + (i_A(12 downto 12) * i_B(13 downto 13)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(12 downto 12)) +  -- 0
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);

-- A11 X B15 + A15 X B11 + A12 X B14 + A14 X B12 + A13 X B13
	w_R1(7)(2 downto 0)  <= "000" + (i_A(11 downto 11) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(11 downto 11)) +  -- 0
				"000" + (i_A(12 downto 12) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(12 downto 12)) +  -- 1
				"000" + (i_A(13 downto 13) * i_B(13 downto 13)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A12 X B15 + A15 X B12 + A13 X B14 + A14 X B13
	w_R1(7)(2 downto 0)  <= "000" + (i_A(12 downto 12) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(12 downto 12)) +  -- 0
				"000" + (i_A(13 downto 13) * i_B(14 downto 14)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(13 downto 13)) +  -- 1
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A13 X B15 + A15 X B13 + A14 X B14
	w_R1(7)(2 downto 0)  <= "000" + (i_A(13 downto 13) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(13 downto 13)) +  -- 0
				"000" + (i_A(14 downto 14) * i_B(14 downto 14)) +  -- 0
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A14 X B15 + A15 X B14
	w_R1(7)(2 downto 0)  <= "000" + (i_A(14 downto 14) * i_B(15 downto 15)) +  -- 1
				"000" + (i_A(15 downto 15) * i_B(14 downto 14)) +  -- 0
				"000" + w_R1(6)(2 downto 1);

	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);


-- A15 X B15
	w_R1(14)(2 downto 0)   <= "000" + (i_A(15 downto 15) * i_B(15 downto 15)) + -- 1
			     	  "000" + w_R1(13)(2 downto 1);

	w_AB1(15 downto 14)  <= w_R1(14)(1 downto 0);

-- FINAL
	o_AB <= w_AB1;



end Behavioral;