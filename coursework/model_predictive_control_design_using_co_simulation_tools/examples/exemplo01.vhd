LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
 
ENTITY exemplo01 IS
    PORT (
        A     :  IN  STD_LOGIC;
        B     :  IN  STD_LOGIC;
        C     :  IN  STD_LOGIC;
        D	  :  IN  STD_LOGIC;
        Saida :  OUT STD_LOGIC
    );
END exemplo01;
 
ARCHITECTURE mfe OF exemplo01 IS
SIGNAL r, s, t : STD_LOGIC;
BEGIN

r <= A AND(B OR C);
s <= D XOR C;
t <= C NAND D;
Saida <= r AND (s OR t);

END mfe;