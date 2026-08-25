library ieee;
library ieee_proposed;

use ieee.std_logic_1164.all;
use ieee_proposed.real_matrix_pkg.all;


entity exemplo01 is
port (
	rst: in std_logic
);
end exemplo01;

architecture sim of exemplo01 is
signal a: real_matrix(0 to 3, 0 to 1);
signal b: real_matrix(0 to 1, 0 to 2);
signal c: real_matrix(0 to 3, 0 to 2);

begin
process(all)
begin
	if rst = '1' then
		a <= ((1.0, 6.0), (4.0, 3.0), (7.0, 1.0), (2.0, 5.0));
		b <= ((2.0, 0.5, 3.0), (7.0, 1.0, 0.0));
	elsif rst = '0' then
		c <= a * b;
	end if;
end process;

end architecture sim;