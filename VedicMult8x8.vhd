library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.NUMERIC_STD.ALL;


-- o problema do 8x8 é que, por exemplo, para somar 1+1+10 dá 3 dígitos
entity VedicMult8x8 is
    Port ( 
        i_A  : in STD_LOGIC_VECTOR(7 downto 0);
        i_B  : in STD_LOGIC_VECTOR(7 downto 0);
	o_AB : out STD_LOGIC_VECTOR(16 downto 0)
    );
end VedicMult8x8;


architecture Behavioral of VedicMult8x8 is

  type   t_P  is array (15 downto 0) OF std_logic_vector(2 downto 0);

  signal w_R1   : t_P;

  signal w_AB1  : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');

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


-- A1 X B7 + A7 X B1 + A2 X B6 + A6 X B2 + A3 X B5 + A5 X B3 + A4 X B4
	w_R1(8)(2 downto 0)   <= "000" + (i_A(1 downto 1) * i_B(7 downto 7)) +  -- 1
			    	 "000" + (i_A(7 downto 7) * i_B(1 downto 1)) +  -- 1
			    	 "000" + (i_A(2 downto 2) * i_B(6 downto 6)) +  -- 0
			    	 "000" + (i_A(6 downto 6) * i_B(2 downto 2)) +  -- 0
			    	 "000" + (i_A(3 downto 3) * i_B(5 downto 5)) +  -- 1
			    	 "000" + (i_A(5 downto 5) * i_B(3 downto 3)) +  -- 1
			    	 "000" + (i_A(4 downto 4) * i_B(4 downto 4)) + -- 0
                             	 "000" + w_R1(7)(2 downto 1);

	w_AB1(8 downto 8)    <= w_R1(8)(0 downto 0);


-- A2 X B7 + A7 X B2 + A3 X B6 + A6 X B3 + A4 X B5 + A5 X B4 
	w_R1(9)(2 downto 0)   <= "000" + (i_A(2 downto 2) * i_B(7 downto 7)) +  -- 1
			    	 "000" + (i_A(7 downto 7) * i_B(2 downto 2)) +  -- 0
			    	 "000" + (i_A(3 downto 3) * i_B(6 downto 6)) +  -- 0
			    	 "000" + (i_A(6 downto 6) * i_B(3 downto 3)) +  -- 1
			    	 "000" + (i_A(4 downto 4) * i_B(5 downto 5)) +  -- 1
			    	 "000" + (i_A(5 downto 5) * i_B(4 downto 4)) + -- 0
                             	 "000" + w_R1(8)(2 downto 1);

	w_AB1(9 downto 9)    <= w_R1(9)(0 downto 0);


-- A3 X B7 + A7 X B3 + A4 X B6 + A6 X B4 + A5 X B5
	w_R1(10)(2 downto 0)   <= "000" + (i_A(3 downto 3) * i_B(7 downto 7)) +  -- 1
			    	  "000" + (i_A(7 downto 7) * i_B(3 downto 3)) +  -- 1
			    	  "000" + (i_A(4 downto 4) * i_B(6 downto 6)) +  -- 0
			    	  "000" + (i_A(6 downto 6) * i_B(4 downto 4)) +  -- 0
			    	  "000" + (i_A(5 downto 5) * i_B(5 downto 5)) + -- 1
                             	  "000" + w_R1(9)(2 downto 1);

	w_AB1(10 downto 10)  <= w_R1(10)(0 downto 0);

-- A4 X B7 + A7 X B4 + A5 X B6 + A6 X B5
	w_R1(11)(2 downto 0)   <= "000" + (i_A(4 downto 4) * i_B(7 downto 7)) +  -- 1
			    	  "000" + (i_A(7 downto 7) * i_B(4 downto 4)) +  -- 0
			    	  "000" + (i_A(5 downto 5) * i_B(6 downto 6)) +  -- 0
			    	  "000" + (i_A(6 downto 6) * i_B(5 downto 5)) + -- 1
                            	  "000" + w_R1(10)(2 downto 1);

	w_AB1(11 downto 11)  <= w_R1(11)(0 downto 0);


-- A5 X B7 + A7 X B5 + A6 X B6
	w_R1(12)(2 downto 0)   <= "000" + (i_A(5 downto 5) * i_B(7 downto 7)) +  -- 1
			    	  "000" + (i_A(7 downto 7) * i_B(5 downto 5)) +  -- 1
			    	  "000" + (i_A(6 downto 6) * i_B(6 downto 6)) + -- 0
                             	  "000" + w_R1(11)(2 downto 1);

	w_AB1(12 downto 12)  <= w_R1(12)(0 downto 0);



-- A6 X B7 + A7 X B6
	w_R1(13)(2 downto 0)   <= "000" + (i_A(6 downto 6) * i_B(7 downto 7)) +  -- 1
			    	  "000" + (i_A(7 downto 7) * i_B(6 downto 6)) + -- 0
                             	  "000" + w_R1(12)(2 downto 1);

	w_AB1(13 downto 13)  <= w_R1(13)(0 downto 0);


-- A7 X B7
	w_R1(14)(2 downto 0)   <= "000" + (i_A(7 downto 7) * i_B(7 downto 7)) + -- 1
			     	  "000" + w_R1(13)(2 downto 1);

	w_AB1(16 downto 14)  <= w_R1(14)(2 downto 0);

-- FINAL
	o_AB <= w_AB1;



end Behavioral;