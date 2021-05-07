library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VedicMult8x8 is
    Port ( 
        i_A  : in STD_LOGIC_VECTOR(7 downto 0);
        i_B  : in STD_LOGIC_VECTOR(7 downto 0);
	o_AB : out STD_LOGIC_VECTOR(15 downto 0)
    );
end VedicMult8x8;

architecture Behavioral of VedicMult8x8 is
  type   t_P  is array (15 downto 0) OF std_logic_vector(2 downto 0); -- Custom type vector of vectors
  signal w_R1   : t_P;						      -- Vector that contains the sum and the carry outs
  signal w_AB1  : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');   -- Vector that contains the result of the multiplication

  begin

	-- Computes i_A(0) * i_B(0)
        w_R1(0)(2 downto 0) <=  "000" + (i_A(0 downto 0) AND i_B(0 downto 0));
	w_AB1(0 downto 0)  <= w_R1(0)(0 downto 0);

	-- Computes i_A(0) * i_B(1) + i_A(1) * i_B(0)
        w_R1(1)(2 downto 0) <=  "000" + (i_A(0 downto 0) AND i_B(1 downto 1)) + 
				"000" + (i_A(1 downto 1) AND i_B(0 downto 0)) + 
				"000" + w_R1(0)(2 downto 1);
	w_AB1(1 downto 1)  <= w_R1(1)(0 downto 0);

	-- Computes i_A(0) * i_B(2) + i_A(2) * i_B(0) + i_A(1) * i_B(1)
	w_R1(2)(2 downto 0)   <= "000" + (i_A(0 downto 0) AND i_B(2 downto 2)) + 
			         "000" + (i_A(2 downto 2) AND i_B(0 downto 0)) +
			         "000" + (i_A(1 downto 1) AND i_B(1 downto 1)) +
                                 "000" + w_R1(1)(2 downto 1);
	w_AB1(2 downto 2)  <= w_R1(2)(0 downto 0);


	-- Computes i_A(0) * i_B(3) + i_A(3) * i_B(0) + i_A(1) * i_B(2) + i_A(2) * i_B(1)
	w_R1(3)(2 downto 0)   <= "000" + (i_A(0 downto 0) AND i_B(3 downto 3)) + 
			         "000" + (i_A(3 downto 3) AND i_B(0 downto 0)) +
			         "000" + (i_A(1 downto 1) AND i_B(2 downto 2)) +
			         "000" + (i_A(2 downto 2) AND i_B(1 downto 1)) +
                                 "000" + w_R1(2)(2 downto 1);

	w_AB1(3 downto 3)  <= w_R1(3)(0 downto 0);

	-- Computes i_A(0) * i_B(4) + i_A(4) * i_B(0) + i_A(1) * i_B(3) + i_A(3) * i_B(1) + i_A(2) * i_B(2)
	w_R1(4)(2 downto 0) <=  "000" + (i_A(0 downto 0) AND i_B(4 downto 4)) +
			    	"000" + (i_A(4 downto 4) AND i_B(0 downto 0)) +
			    	"000" + (i_A(1 downto 1) AND i_B(3 downto 3)) +
			    	"000" + (i_A(3 downto 3) AND i_B(1 downto 1)) +
			    	"000" + (i_A(2 downto 2) AND i_B(2 downto 2)) +
                             	"000" + w_R1(3)(2 downto 1);
	w_AB1(4 downto 4)  <= w_R1(4)(0 downto 0);

	-- Computes i_A(0) * i_B(5) + i_A(5) * i_B(0) + i_A(1) * i_B(4) + i_A(4) * i_B(1) + i_A(3) * i_B(2) + i_A(2) * i_B(3)
	w_R1(5)(2 downto 0) <=  "000" + (i_A(0 downto 0) AND i_B(5 downto 5)) +
			    	"000" + (i_A(5 downto 5) AND i_B(0 downto 0)) +
			    	"000" + (i_A(1 downto 1) AND i_B(4 downto 4)) +
			    	"000" + (i_A(4 downto 4) AND i_B(1 downto 1)) +
			    	"000" + (i_A(2 downto 2) AND i_B(3 downto 3)) + 
				"000" + (i_A(3 downto 3) AND i_B(2 downto 2)) +
				"000" + w_R1(4)(2 downto 1);
	w_AB1(5 downto 5)    <= w_R1(5)(0 downto 0);

	-- Computes i_A(0) * i_B(6) + i_A(6) * i_B(0) + i_A(1) * i_B(5) + i_A(5) * i_B(1) + i_A(2) * i_B(4) + i_A(4) * i_B(2) + i_A(3) * i_B(3)
	w_R1(6)(2 downto 0)  <= "000" + (i_A(0 downto 0) AND i_B(6 downto 6)) +
			    	"000" + (i_A(6 downto 6) AND i_B(0 downto 0)) + 
			    	"000" + (i_A(1 downto 1) AND i_B(5 downto 5)) +
			    	"000" + (i_A(5 downto 5) AND i_B(1 downto 1)) + 
 			    	"000" + (i_A(2 downto 2) AND i_B(4 downto 4)) +
			    	"000" + (i_A(4 downto 4) AND i_B(2 downto 2)) + 
			    	"000" + (i_A(3 downto 3) AND i_B(3 downto 3)) + 
                             	"000" + w_R1(5)(2 downto 1);
	w_AB1(6 downto 6)    <= w_R1(6)(0 downto 0);

	-- Computes i_A(0) * i_B(7) + i_A(7) * i_B(0) + i_A(1) * i_B(6) + i_A(6) * i_B(1) + i_A(2) * i_B(5) + i_A(5) * i_B(2) + i_A(3) * i_B(4) + i_A(4) * i_B(3)
	w_R1(7)(2 downto 0)  <= "000" + (i_A(0 downto 0) AND i_B(7 downto 7)) + 
				"000" + (i_A(7 downto 7) AND i_B(0 downto 0)) + 
				"000" + (i_A(1 downto 1) AND i_B(6 downto 6)) + 
				"000" + (i_A(6 downto 6) AND i_B(1 downto 1)) +
				"000" + (i_A(2 downto 2) AND i_B(5 downto 5)) +
				"000" + (i_A(5 downto 5) AND i_B(2 downto 2)) +
				"000" + (i_A(3 downto 3) AND i_B(4 downto 4)) + 
				"000" + (i_A(4 downto 4) AND i_B(3 downto 3)) +
				"000" + w_R1(6)(2 downto 1);
	w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);

	-- Computes i_A(1) * i_B(7) + i_A(7) * i_B(1) + i_A(2) * i_B(6) + i_A(6) * i_B(2) + i_A(3) * i_B(5) + i_A(5) * i_B(3) + i_A(4) * i_B(4)
	w_R1(8)(2 downto 0)   <= "000" + (i_A(1 downto 1) AND i_B(7 downto 7)) + 
			    	 "000" + (i_A(7 downto 7) AND i_B(1 downto 1)) + 
			    	 "000" + (i_A(2 downto 2) AND i_B(6 downto 6)) +
			    	 "000" + (i_A(6 downto 6) AND i_B(2 downto 2)) +
			    	 "000" + (i_A(3 downto 3) AND i_B(5 downto 5)) +
			    	 "000" + (i_A(5 downto 5) AND i_B(3 downto 3)) +
			    	 "000" + (i_A(4 downto 4) AND i_B(4 downto 4)) +
                             	 "000" + w_R1(7)(2 downto 1);
	w_AB1(8 downto 8)    <= w_R1(8)(0 downto 0);

	-- Computes i_A(2) * i_B(7) + i_A(7) * i_B(2) + i_A(3) * i_B(6) + i_A(6) * i_B(3) + i_A(4) * i_B(5) + i_A(5) * i_B(4)
	w_R1(9)(2 downto 0)   <= "000" + (i_A(2 downto 2) AND i_B(7 downto 7)) + 
			    	 "000" + (i_A(7 downto 7) AND i_B(2 downto 2)) + 
			    	 "000" + (i_A(3 downto 3) AND i_B(6 downto 6)) + 
			    	 "000" + (i_A(6 downto 6) AND i_B(3 downto 3)) +
			    	 "000" + (i_A(4 downto 4) AND i_B(5 downto 5)) +
			    	 "000" + (i_A(5 downto 5) AND i_B(4 downto 4)) +
                             	 "000" + w_R1(8)(2 downto 1);
	w_AB1(9 downto 9)    <= w_R1(9)(0 downto 0);

	-- Computes i_A(3) * i_B(7) + i_A(7) * i_B(3) + i_A(4) * i_B(6) + i_A(6) * i_B(4) + i_A(5) * i_B(5)
	w_R1(10)(2 downto 0)   <= "000" + (i_A(3 downto 3) AND i_B(7 downto 7)) +
			    	  "000" + (i_A(7 downto 7) AND i_B(3 downto 3)) +
			    	  "000" + (i_A(4 downto 4) AND i_B(6 downto 6)) +
			    	  "000" + (i_A(6 downto 6) AND i_B(4 downto 4)) +
			    	  "000" + (i_A(5 downto 5) AND i_B(5 downto 5)) +
                             	  "000" + w_R1(9)(2 downto 1);
	w_AB1(10 downto 10)  <= w_R1(10)(0 downto 0);

	-- Computes i_A(4) * i_B(7) + i_A(7) * i_B(4) + i_A(5) * i_B(6) + i_A(6) * i_B(5)
	w_R1(11)(2 downto 0)   <= "000" + (i_A(4 downto 4) AND i_B(7 downto 7)) +
			    	  "000" + (i_A(7 downto 7) AND i_B(4 downto 4)) +
			    	  "000" + (i_A(5 downto 5) AND i_B(6 downto 6)) +
			    	  "000" + (i_A(6 downto 6) AND i_B(5 downto 5)) +
                            	  "000" + w_R1(10)(2 downto 1);
	w_AB1(11 downto 11)  <= w_R1(11)(0 downto 0);

	-- Computes i_A(5) * i_B(7) + i_A(7) * i_B(5) + i_A(6) * i_B(6)
	w_R1(12)(2 downto 0)   <= "000" + (i_A(5 downto 5) AND i_B(7 downto 7)) +
			    	  "000" + (i_A(7 downto 7) AND i_B(5 downto 5)) +
			    	  "000" + (i_A(6 downto 6) AND i_B(6 downto 6)) +
                             	  "000" + w_R1(11)(2 downto 1);
	w_AB1(12 downto 12)  <= w_R1(12)(0 downto 0);

	-- Computes i_A(6) * i_B(7) + i_A(7) * i_B(6)
	w_R1(13)(2 downto 0)   <= "000" + (i_A(6 downto 6) AND i_B(7 downto 7)) +
			    	  "000" + (i_A(7 downto 7) AND i_B(6 downto 6)) +
                             	  "000" + w_R1(12)(2 downto 1);
	w_AB1(13 downto 13)  <= w_R1(13)(0 downto 0);


	-- Computes i_A(7) * i_B(7)
	w_R1(14)(2 downto 0)   <= "000" + (i_A(7 downto 7) AND i_B(7 downto 7)) +
			     	  "000" + w_R1(13)(2 downto 1);
	w_AB1(15 downto 14)  <= w_R1(14)(1 downto 0);

	-- Final result
	o_AB <= w_AB1;

end Behavioral;