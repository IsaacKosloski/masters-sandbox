-------------------------------------------------------------------------------
-- Title      : testbench for the fixed point matrix package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_fixed_matrix.vhdl
-- Author     : David Bishop  <dbishop@vhdl.org>
-- Company    : 
-- Created    : 2010-04-15
-- Last update: 2011-02-07
-- Platform   : 
-- Standard   : VHDL'2008
-------------------------------------------------------------------------------
-- Description: testbench for the fixed point matrix package
-------------------------------------------------------------------------------
-- Copyright (c) 2010 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2010-04-15  1.0      dbishop@vhdl.org Created
-------------------------------------------------------------------------------

--

entity test_fixed_matrix is
  
  generic (
    quiet : BOOLEAN := true);

end entity test_fixed_matrix;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ieee_proposed;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
--%VHDL2008% use ieee_proposed.numeric_std_additions.all;
use ieee_proposed.real_matrix_pkg.all;
use ieee_proposed.fixed_matrix_pkg.all;

architecture testbench of test_fixed_matrix is

  -- purpose: converts "downto" and none zero ranges into normal matrices
  function reorder (
    arg : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in arg'low(1) to arg'high(1) loop
      for j in arg'low(2) to arg'high(2) loop
        result (i - arg'low(1), j - arg'low(2)) := arg(i, j);
      end loop;
    end loop;
    return result;
  end function reorder;

  function reorder (
    arg : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in arg'low(1) to arg'high(1) loop
      for j in arg'low(2) to arg'high(2) loop
        result (i - arg'low(1), j - arg'low(2)) := arg(i, j);
      end loop;
    end loop;
    return result;
  end function reorder;

  function reorder (
    arg : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in arg'low(1) to arg'high(1) loop
      for j in arg'low(2) to arg'high(2) loop
        result (i - arg'low(1), j - arg'low(2)) := arg(i, j);
      end loop;
    end loop;
    return result;
  end function reorder;

  function reorder (
    arg : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length(1)-1,
                                       0 to arg'length(2)-1);
  begin
    for i in arg'low(1) to arg'high(1) loop
      for j in arg'low(2) to arg'high(2) loop
        result (i - arg'low(1), j - arg'low(2)) := arg(i, j);
      end loop;
    end loop;
    return result;
  end function reorder;

  -- purpose: reports an error
  procedure report_error (
    constant errmes   : in STRING;      -- error message
    actual            : in ufixed;      -- data from algorithm
    constant expected : in ufixed) is   -- reference data
  begin  -- function report_error
    assert actual = expected
      report errmes & LF
      & "Actual: " & to_string(actual)
      & " (" & REAL'image(to_real(actual)) & ")" & LF
      & "     /= " & to_string(expected)
      & " (" & REAL'image(to_real(expected)) & ")"
      severity error;
    return;
  end procedure report_error;

  procedure report_error (
    constant errmes   :    STRING;      -- error message
    actual            : in sfixed;      -- data from algorithm
    constant expected :    sfixed) is   -- reference data
  begin  -- function report_error
    assert actual = expected
      report errmes & LF
      & "Actual: " & to_string(actual)
      & " (" & REAL'image(to_real(actual)) & ")" & LF
      & "     /= " & to_string(expected)
      & " (" & REAL'image(to_real(expected)) & ")"
      severity error;
    return;
  end procedure report_error;

  constant sfh : INTEGER := ieee_proposed.fixed_matrix_pkg.sfixed_matrix_high;
  constant sfl : INTEGER := ieee_proposed.fixed_matrix_pkg.sfixed_matrix_low;
  constant ufh : INTEGER := ieee_proposed.fixed_matrix_pkg.ufixed_matrix_high;
  constant ufl : INTEGER := ieee_proposed.fixed_matrix_pkg.ufixed_matrix_low;
  constant sh  : INTEGER := ieee_proposed.fixed_matrix_pkg.signed_matrix_high;
  constant uh  : INTEGER := ieee_proposed.fixed_matrix_pkg.unsigned_matrix_high;

  signal testersf_start        : BOOLEAN := false;
  signal testersf_done         : BOOLEAN := false;
  signal testeruf_start        : BOOLEAN := false;
  signal testeruf_done         : BOOLEAN := false;
  signal tester_signed_start   : BOOLEAN := false;
  signal tester_signed_done    : BOOLEAN := false;
  signal tester_unsigned_start : BOOLEAN := false;
  signal tester_unsigned_done  : BOOLEAN := false;
  signal test_round_start : BOOLEAN := false;
  signal test_round_done : BOOLEAN := false;
  signal test_roundu_start : BOOLEAN := false;
  signal test_roundu_done : BOOLEAN := false;
begin

  -- purpose: main test loop
  main_test : process is
    constant submatxc : sfixed_matrix (0 to 1, 0 to 1) :=
    ((to_sfixed (1, sfh, sfl), to_sfixed (2, sfh, sfl)),
     (to_sfixed (4, sfh, sfl), to_sfixed (3, sfh, sfl)));
    constant ac                        : integer_matrix := ((1, 3, 2), (4, 1, 3), (2, 5, 2));
    variable a, b, c                   : sfixed_matrix (0 to 2, 0 to 2);
    variable m, n, o                   : sfixed (sfh downto sfl);
    variable submatx, submaty, submatz : sfixed_matrix (0 to 1, 0 to 1);
    variable submatxi                  : integer_matrix (0 to 1, 0 to 1);
    variable submatxr                  : real_matrix (0 to 1, 0 to 1);
    variable m1, n1 : sfixed_matrix (0 to 0, 0 to 0);  -- 1x1 matrix
    constant one : sfixed(sfh downto sfl) := (0 => '1', others => '0');
    constant oneh : sfixed (9 downto 0) := to_sfixed (100, 9, 0);

  begin
    m := det (submatxc);
    n := to_sfixed (-5, n'high, n'low);
    if m /= n then
      report "det problem, result was " & to_string (m) severity error;
    end if;
    a := to_sfixed (ac);
    m := det (a);
    n := to_sfixed (17, n'high, n'low);
    if m /= n then
      report "det 3x3 problem, result was " & to_string (m) severity error;
    end if;
    submatxi := ((1, 2), (3, 4));
    submatx  := to_sfixed (submatxi);
    submaty  := inv (submatx);
    submatxr := ((-2.0, 1.0), (1.5, -0.5));
    submatz  := to_sfixed (submatxr);
    if submaty /= submatz then
      report "inv (2x2) problem " severity error;
      print_matrix (submaty);
    end if;
    m1 := (others => (others => one));
    n1 := inv(m1);
    if n1(0,0) /= one then
      report "inv (1x1) problem " severity error;
      print_matrix (n1);
    end if;
    submatxi := ((10, 20), (30, 40));
    submatx  := to_sfixed (submatxi);
    submaty := normalize (submatx, oneh);
    submatxi := ((25, 50), (75, 100));
    submatz := to_sfixed(submatxi);
    if submaty /= submatz then
      report "normalize (mat, 100) problem" severity error;
      print_matrix (submaty);
    end if;

    test_round_start <= true;
    wait until test_round_done;
    test_roundu_start <= true;
    wait until test_roundu_done;
    tester_signed_start   <= true;
    wait until tester_signed_done;
    tester_unsigned_start <= true;
    wait until tester_unsigned_done;
    testeruf_start        <= true;
    wait until testeruf_done;
    testersf_start        <= true;
    wait until testersf_done;
    report "test_fixed_matrix completed" severity note;
    wait;
  end process main_test;

  -- purpose: Test the round and precision funcitons
  -- This test may eventually be moved into the fixed point package test.
  test_round: process is
    variable a, b, c, d : sfixed (3 downto -3);
    variable al, bl, cl : sfixed (0 downto -3);
    variable ah, bh, ch : sfixed (5 downto 2);
  begin
    wait until test_round_start;
    -- basic rounding test
    a := "0000000";                     -- 0.0
    b := xround (a);
    c := "0000000";
    report_error ("sfixed round zero", b, c);
    a := "0001000";                     -- 1.0
    b := xround (a);
    c := "0001000";
    report_error ("sfixed round one", b, c);
    a := "0001111";                     -- 1.825
    b := xround (a);
    c := "0010000";                     -- 2
    report_error ("sfixed round 1.5+", b, c);
    a := "0001001";                     -- 1.125
    b := xround (a);
    c := "0001000";
    report_error ("sfixed round 1.125", b, c);
    a := "0001100";                     -- 1.5
    b := xround (a);
    c := "0010000";                     -- 2
    report_error ("sfixed round 1.5", b, c);
    a := "0001101";                     -- 1.625
    b := xround (a);
    c := "0010000";                     -- 2
    report_error ("sfixed round 1.625", b, c);
    a := "0010000";                     -- 2.0
    b := xround (a);
    c := "0010000";
    report_error ("sfixed round 2", b, c);
    a := "0010111";                     -- 2.825
    b := xround (a);
    c := "0011000";                     -- 3
    report_error ("sfixed round 2.825", b, c);
    a := "0010001";                     -- 2.125
    b := xround (a);
    c := "0010000";
    report_error ("sfixed round 2.125", b, c);
    a := "0010100";                     -- 2.5
    b := xround (a);
    c := "0010000";                     -- 2
    report_error ("sfixed round 2.5", b, c);
    a := "0010101";                     -- 2.625
    b := xround (a);
    c := "0011000";                     -- 3
    report_error ("sfixed round 2.625", b, c);

    a := "1111000";                     -- -1.0
    b := xround (a);
    c := "1111000";
    report_error ("sfixed round -1", b, c);
    a := "1110001";                     -- -1.825
    b := xround (a);
    c := "1110000";                     -- -2
    report_error ("sfixed round -1.825", b, c);
    a := "1110111";                     -- -1.125
    b := xround (a);
    c := "1111000";
    report_error ("sfixed round -.125", b, c);
    a := "1110100";                     -- -1.5
    b := xround (a);
    c := "1110000";                     -- -2
    report_error ("sfixed round -1.5", b, c);
    a := "1110011";                     -- -1.625
    b := xround (a);
    c := "1110000";                     -- -2
    report_error ("sfixed round -1.625", b, c);
    a := "1110000";                     -- -2.0
    b := xround (a);
    c := "1110000";
    report_error ("sfixed round -2", b, c);
    a := "1101001";                     -- -2.825
    b := xround (a);
    c := "1101000";                     -- -3
    report_error ("sfixed round -2.825", b, c);
    a := "1101111";                     -- -2.125
    b := xround (a);
    c := "1110000";                     -- -2
    report_error ("sfixed round -2.125", b, c);
    a := "1101100";                     -- -2.5
    b := xround (a);
    c := "1110000";                     -- -2
    report_error ("sfixed round -2.5", b, c);
    a := "1101011";                     -- -2.625
    b := xround (a);
    c := "1101000";                     -- 3
    report_error ("sfixed round -2.625", b, c);
    -- round to zero
    a := "0000001";                     -- 0.125
    b := xround (a);
    c := "0000000";
    report_error ("sfixed round " & real'image(to_real(a)), b, c);
    a := "0000100";                     -- 0.5
    b := xround (a);
    c := "0000000";
    report_error ("sfixed round " & real'image(to_real(a)), b, c);
    a := "0000101";                     -- 0.625
    b := xround (a);
    c := "0001000";
    report_error ("sfixed round " & real'image(to_real(a)), b, c);
    a := "1111111";                     -- -0.125
    b := xround (a);
    c := "0000000";
    report_error ("sfixed round " & real'image(to_real(a)), b, c);
    a := "1111100";                     -- -0.5
    b := xround (a);
    c := "0000000";
    report_error ("sfixed round " & real'image(to_real(a)), b, c);
    a := "1111011";                     -- -0.625
    b := xround (a);
    c := "1111000";                     -- -1.0
    report_error ("sfixed round " & real'image(to_real(a)), b, c);
    -- disable rounding
    a := "0001111";                     -- 1.825
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "0001000";                     -- 1
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "0001001";                     -- 1.125
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "0001000";
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "0001101";                     -- 1.625
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "0001000";                     -- 1
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "0010000";                     -- 2.0
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "0010000";
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "0010111";                     -- 2.825
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "0010000";                     -- 2
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);

    a := "1111000";                     -- -1.0
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "1111000";
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "1110001";                     -- -1.825
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "1110000";                     -- -2
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "1110111";                     -- -1.125
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "1110000";
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "1110100";                     -- -1.5
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "1110000";                     -- -2
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "1110011";                     -- -1.625
    b := xround (a);
    c := "1110000";                     -- -2
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "1110000";                     -- -2.0
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "1110000";
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "1101001";                     -- -2.825
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "1101000";                     -- -3
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "1101111";                     -- -2.125
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "1101000";                     -- -3
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "1101100";                     -- -2.5
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "1101000";                     -- -3
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    a := "1101011";                     -- -2.625
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "1101000";                     -- -3
    report_error ("sfixed round truncate " & real'image(to_real(a)), b, c);
    -- saturation
    a := "0111000";                     -- 7
    b := xround (a);
    c := "0111000";
    report_error ("sfixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "0111001";                     -- 7.125
    b := xround (a);
    c := "0111000";
    report_error ("sfixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "0111100";                     -- 7.5
    b := xround (a);
    c := "0111000";                     -- return largest max integer
    report_error ("sfixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "0111111";                     -- 7.825
    b := xround (a);
    c := "0111000";                     -- return largest max integer
    report_error ("sfixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);

    a := "1001000";                     -- -7
    b := xround (a);
    c := "1001000";
    report_error ("sfixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1000000";                     -- -8
    b := xround (a);
    c := "1000000";
    report_error ("sfixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1000111";                     -- -7.125
    b := xround (a);
    c := "1001000";
    report_error ("sfixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1000100";                     -- -7.5
    b := xround (a);
    c := "1000000";                     -- return largest max integer
    report_error ("sfixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1000001";                     -- -7.825
    b := xround (a);
    c := "1000000";                     -- return largest max integer
    report_error ("sfixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    -- no saturate
    a := "0111001";                     -- 7.125
    b := xround (arg => a,
                 overflow_style => fixed_wrap);
    c := "0111000";
    report_error ("sfixed round wrap " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "0111100";                     -- 7.5
    b := xround (arg => a,
                 overflow_style => fixed_wrap);
    c := "1000000";                     -- wrap into sign bit
    report_error ("sfixed round wrap " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "0111111";                     -- 7.825
    b := xround (arg => a,
                 overflow_style => fixed_wrap);
    c := "1000000";                     -- wrap into sign bit
    report_error ("sfixed round wrap " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1000000";                     -- -8
    b := xround (arg => a,
                 overflow_style => fixed_wrap);
    c := "1000000";
    report_error ("sfixed round wrap " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1000111";                     -- -7.125
    b := xround (arg => a,
                 overflow_style => fixed_wrap);
    c := "1001000";
    report_error ("sfixed round wrap " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1000100";                     -- -7.5
    b := xround (arg => a,
                 overflow_style => fixed_wrap);
    c := "1000000";                     -- return largest max integer
    report_error ("sfixed round wrap " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1000001";                     -- -7.825
    b := xround (arg => a,
                 overflow_style => fixed_wrap);
    c := "1000000";                     -- return largest max integer
    report_error ("sfixed round wrap " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);

    -- High bits only
    ah := "0000";
    bh := xround (ah);
    ch := "0000";
    report_error ("sfixed high " & to_string (ah) & " = "
                  & real'image(to_real(ah)), bh, ch);
    ah := "0001";                       -- 4.0
    bh := xround (ah);
    ch := "0001";
    report_error ("sfixed high " & to_string (ah) & " = "
                  & real'image(to_real(ah)), bh, ch);
    ah := "0111";                       -- 28.0
    bh := xround (ah);
    ch := "0111";
    report_error ("sfixed high " & to_string (ah) & " = "
                  & real'image(to_real(ah)), bh, ch);
    ah := "1111";                       -- -4.0
    bh := xround (ah);
    ch := "1111";
    report_error ("sfixed high " & to_string (ah) & " = "
                  & real'image(to_real(ah)), bh, ch);
    ah := "1000";                       -- -4.0
    bh := xround (ah);
    ch := "1000";
    report_error ("sfixed high " & to_string (ah) & " = "
                  & real'image(to_real(ah)), bh, ch);

    -- Small numbers
    al := "0000";
    bl := xround(al);
    cl := "0000";
    report_error ("sfixed low " & to_string (al) & " = "
                  & real'image(to_real(al)), bl, cl);
    al := "0001";
    bl := xround(al);
    cl := "0000";
    report_error ("sfixed low " & to_string (al) & " = "
                  & real'image(to_real(al)), bl, cl);
--    al := "0111";   %%%%
--    bl := xround(al);
--    cl := "0000";
--    report_error ("sfixed low " & to_string (al) & " = "
--                  & real'image(to_real(al)), bl, cl);
    al := "1111";
    bl := xround(al);
    cl := "0000";
    report_error ("sfixed low " & to_string (al) & " = "
                  & real'image(to_real(al)), bl, cl);
    al := "1100";
    bl := xround(al);
    cl := "0000";
    report_error ("sfixed low " & to_string (al) & " = "
                  & real'image(to_real(al)), bl, cl);
    al := "1000";                       -- -1.0
    bl := xround(al);
    cl := "1000";
    report_error ("sfixed low " & to_string (al) & " = "
                  & real'image(to_real(al)), bl, cl);

    -- Test the precision funciton
    a := "0100000";                     -- 4
    b := xprecision (a);
    report_error ("precision "& to_string (a) & " = "
                  & real'image(to_real(a)), b, a);
    a := "0101010";
    b := xprecision (a);
    report_error ("precision "& to_string (a) & " = "
                  & real'image(to_real(a)), b, a);
    a := "1010101";
    b := xprecision (a);
    report_error ("precision "& to_string (a) & " = "
                  & real'image(to_real(a)), b, a);
    a := "1010101";
    b := xprecision (a, 2);             -- Two bits of precision
    c := "1010100";
    report_error ("precision 2 "& to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "0101010";
    b := xprecision (a,2);
    report_error ("precision 2"& to_string (a) & " = "
                  & real'image(to_real(a)), b, a);

    a := "1010101";
    b := xprecision (a, 1); 
    c := "1010100";
    report_error ("precision 1 "& to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1010101";
    b := xprecision (a, 0); 
    c := "1011000";
    report_error ("precision 0 "& to_string (a) & " = "
                  & real'image(to_real(a)), b, c);


    
    test_round_done <= true;
    wait;

  end process test_round;

  test_roundu: process is
    variable a, b, c, d : ufixed (3 downto -3);
    variable al, bl, cl : ufixed (0 downto -3);
    variable ah, bh, ch : ufixed (5 downto 2);
  begin
    wait until test_roundu_start;
    -- basic rounding test
    a := "0000000";                     -- 0.0
    b := xround (a);
    c := "0000000";
    report_error ("ufixed round zero", b, c);
    a := "0001000";                     -- 1.0
    b := xround (a);
    c := "0001000";
    report_error ("ufixed round one", b, c);
    a := "0001111";                     -- 1.825
    b := xround (a);
    c := "0010000";                     -- 2
    report_error ("ufixed round 1.5+", b, c);
    a := "0001001";                     -- 1.125
    b := xround (a);
    c := "0001000";
    report_error ("ufixed round 1.125", b, c);
    a := "0001100";                     -- 1.5
    b := xround (a);
    c := "0010000";                     -- 2
    report_error ("ufixed round 1.5", b, c);
    a := "0001101";                     -- 1.625
    b := xround (a);
    c := "0010000";                     -- 2
    report_error ("ufixed round 1.625", b, c);
    a := "0010000";                     -- 2.0
    b := xround (a);
    c := "0010000";
    report_error ("ufixed round 2", b, c);
    a := "0010111";                     -- 2.825
    b := xround (a);
    c := "0011000";                     -- 3
    report_error ("ufixed round 2.925", b, c);
    a := "0010001";                     -- 2.125
    b := xround (a);
    c := "0010000";
    report_error ("ufixed round 2.125", b, c);
    a := "0010100";                     -- 2.5
    b := xround (a);
    c := "0010000";                     -- 2
    report_error ("ufixed round 2.5", b, c);
    a := "0010101";                     -- 2.625
    b := xround (a);
    c := "0011000";                     -- 3
    report_error ("ufixed round 2.625", b, c);

    -- round to zero
    a := "0000001";                     -- 0.125
    b := xround (a);
    c := "0000000";
    report_error ("ufixed round 0.125", b, c);
    a := "0000100";                     -- 0.5
    b := xround (a);
    c := "0000000";
    report_error ("ufixed round 0.5", b, c);
    a := "0000101";                     -- 0.625
    b := xround (a);
    c := "0001000";
    report_error ("ufixed round 0.625", b, c);


    -- disable rounding
    a := "0001111";                     -- 1.825
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "0001000";                     -- 1
    report_error ("ufixed round truncate " & real'image(to_real(a)), b, c);
    a := "0001001";                     -- 1.125
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "0001000";
    report_error ("ufixed round truncate " & real'image(to_real(a)), b, c);
    a := "0001101";                     -- 1.625
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "0001000";                     -- 1
    report_error ("ufixed round truncate " & real'image(to_real(a)), b, c);
    a := "0010000";                     -- 2.0
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "0010000";
    report_error ("ufixed round truncate " & real'image(to_real(a)), b, c);
    a := "0010111";                     -- 2.825
    b := xround (arg => a,
                 round_style => fixed_truncate);
    c := "0010000";                     -- 2
    report_error ("ufixed round truncate " & real'image(to_real(a)), b, c);

    -- saturation
    a := "1111000";                     -- 15
    b := xround (a);
    c := "1111000";
    report_error ("ufixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1111001";                     -- 15.125
    b := xround (a);
    c := "1111000";
    report_error ("ufixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1111100";                     -- 15.5
    b := xround (a);
    c := "1111000";
    report_error ("ufixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1111111";                     -- 15.825
    b := xround (a);
    c := "1111000";
    report_error ("ufixed round " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);

    -- no saturate
    a := "1111001";                     -- 15.125
    b := xround (arg => a,
                 overflow_style => fixed_wrap);
    c := "1111000";
    report_error ("ufixed round wrap " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1111100";                     -- 15.5
    b := xround (arg => a,
                 overflow_style => fixed_wrap);
    c := "0000000";                     -- wrap to 0
    report_error ("ufixed round wrap " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1111111";                     -- 15.825
    b := xround (arg => a,
                 overflow_style => fixed_wrap);
    c := "0000000";                     -- wrap to 0
    report_error ("ufixed round wrap " & to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    -- High bits only
    ah := "0000";
    bh := xround (ah);
    ch := "0000";
    report_error ("ufixed high " & to_string (ah) & " = "
                  & real'image(to_real(ah)), bh, ch);
    ah := "0001";                       -- 4.0
    bh := xround (ah);
    ch := "0001";
    report_error ("ufixed high " & to_string (ah) & " = "
                  & real'image(to_real(ah)), bh, ch);
    ah := "0111";                       -- 28.0
    bh := xround (ah);
    ch := "0111";
    report_error ("ufixed high " & to_string (ah) & " = "
                  & real'image(to_real(ah)), bh, ch);
    ah := "1111";                       -- -4.0
    bh := xround (ah);
    ch := "1111";
    report_error ("ufixed high " & to_string (ah) & " = "
                  & real'image(to_real(ah)), bh, ch);
    ah := "1000";                       -- -4.0
    bh := xround (ah);
    ch := "1000";
    report_error ("ufixed high " & to_string (ah) & " = "
                  & real'image(to_real(ah)), bh, ch);

        -- Test the precision funciton
    a := "0100000";                     -- 4
    b := xprecision (a);
    report_error ("precision "& to_string (a) & " = "
                  & real'image(to_real(a)), b, a);
    a := "0101010";
    b := xprecision (a);
    report_error ("precision "& to_string (a) & " = "
                  & real'image(to_real(a)), b, a);
    a := "1010101";
    b := xprecision (a);
    report_error ("precision "& to_string (a) & " = "
                  & real'image(to_real(a)), b, a);
    a := "1010101";
    b := xprecision (a, 2);             -- Two bits of precision
    c := "1010100";
    report_error ("precision 2 "& to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "0101010";
    b := xprecision (a,2);
    report_error ("precision 2"& to_string (a) & " = "
                  & real'image(to_real(a)), b, a);

    a := "1010101";
    b := xprecision (a, 1); 
    c := "1010100";
    report_error ("precision 1 "& to_string (a) & " = "
                  & real'image(to_real(a)), b, c);
    a := "1010101";
    b := xprecision (a, 0); 
    c := "1011000";
    report_error ("precision 0 "& to_string (a) & " = "
                  & real'image(to_real(a)), b, c);

    test_roundu_done <= true;
    wait;

  end process test_roundu;

  -- purpose: apply stims
  tester : process is
    constant one  : sfixed (sfh downto sfl) := (0      => '1', others => '0');  --
    constant zero : sfixed (sfh downto sfl) := (others => '0');        --
    constant mones : sfixed_matrix := ((one, one, one),
                                       (one, one, one),
                                       (one, one, one));        --matrix
    constant am : real_matrix := ((7.0, 3.0), (2.0, 5.0),
                                  (6.0, 8.0), (9.0, 0.0));
    constant bm : real_matrix := ((7.0, 4.0, 9.0), (8.0, 1.0, 5.0));
    variable e1 : sfixed_matrix (0 to 1, 0 to 1);               -- bm * am
    constant ambmans : real_matrix := ((73.0, 31.0, 78.0),
                                       (54.0, 13.0, 43.0),
                                       (106.0, 32.0, 94.0),
                                       (63.0, 36.0, 81.0));     -- am * bm
    variable ambm      : sfixed_matrix (0 to 3, 0 to 2);        -- am * bm
    constant amv       : real_vector := (1.0, 4.0, 6.0);        -- real_vector
    constant bmv       : real_matrix := ((2.0, 3.0), (5.0, 8.0), (7.0, 9.0));
    constant amvbmvans : real_vector := (64.0, 89.0);
    variable amvbmv    : sfixed_vector (0 to 1);  -- amv * bmv
    constant avm : real_matrix := ((1.0, 2.0, 3.0),
                                   (4.0, 5.0, 6.0),
                                   (7.0, 8.0, 9.0));
    constant bvm       : real_vector := (3.0, 5.0, 7.0);
    variable avmm, bvmm : sfixed_matrix (0 to 2, 0 to 0);
    variable avmbvm    : sfixed_matrix (0 to 2, 0 to 0);  -- matrix * vector
    constant avmbvmans : real_vector := (34.0, 79.0, 124.0);
    constant avv       : real_vector := (-1.0, -2.0);
    constant bvv       : real_vector := (-1.0, 1.0, 5.0);
    variable avvbvv    : sfixed_matrix (0 to 1, 0 to 2);        -- matrix
    variable avvbvvt   : sfixed_matrix (0 to 2, 0 to 1);        -- matrix
    variable avvbvvx   : real_matrix (0 to 2, 0 to 1);          -- matrix
    -- vector * vector (assuming left is a column not a row)
    constant avvbvvans : real_matrix := ((1.0, -1.0, -5.0),
                                         (2.0, -2.0, -10.0));
    constant dtestx : real_matrix := ((3.0, 2.0, 0.0, 1.0),
                                      (4.0, 0.0, 1.0, 2.0),
                                      (3.0, 0.0, 2.0, 1.0),
                                      (9.0, 2.0, 3.0, 1.0));
    variable mx5x5r                 : real_matrix (0 to 4, 0 to 4);    -- 4x4
    variable mx5x5                  : sfixed_matrix (0 to 4, 0 to 4);  -- 4x4
    variable submatx, submatans     : sfixed_matrix (0 to 1, 0 to 1);
    variable submatr                : real_matrix (0 to 1, 0 to 1);
    variable iv2                    : integer_vector (0 to 1);  -- integer vector
    variable ar, br, cr, dr         : real_matrix (0 to 2, 0 to 2);
    variable a, b, c, d             : sfixed_matrix (0 to 2, 0 to 2);
    variable apr, bpr, cpr, dpr     : real_matrix (9 downto 7, 6 downto 4);
    variable ap, bp, cp, dp         : sfixed_matrix (9 downto 7, 6 downto 4);
    variable avr, bvr, cvr, dvr     : real_vector (0 to 2);
    variable av, bv, cv, dv         : sfixed_vector (0 to 2);
    variable avpr, bvpr, cvpr, dvpr : real_vector (12 downto 10);
    variable avp, bvp, cvp, dvp     : sfixed_vector (12 downto 10);
    variable av4, bv4               : sfixed_vector (0 to 3);
    variable av4r, bv4r             : real_vector (0 to 3);
    variable a3x4               : sfixed_matrix (0 to 2, 0 to 3);
    variable m, n                   : sfixed (sfh downto sfl);
    variable mm, nn             : sfixed_vector (0 to 0);
    variable i, j                   : INTEGER;
    variable bool                   : BOOLEAN;
  begin
    wait until testersf_start;
    -- Basic test  Make sure the compare functions work.
    -- Test ones and Zeros functions
    a    := ones (3, 3);
    bool := (mones = a);
    if not bool then
      report "mones = ones(a)" severity error;
    end if;
    bool := (mones /= a);
    if bool then
      report "mones /= ones(a)" severity error;
    end if;
    a    := zeros (3, 3);
    bool := (mones = a);
    if bool then
      report "mones = zeros(a)" severity error;
    end if;
    bool := (mones /= a);
    if not bool then
      report "mones /= zeros(a)" severity error;
    end if;
    -- Test identity (eye) function
    a := eye (3, 3);
    b := ((one, zero, zero), (zero, one, zero), (zero, zero, one));
    if a /= b then
      report "eye not working" severity error;
      print_matrix (a);
    end if;
    bool := (a = mones);
    if bool then
      report "identity = ones returned true" severity error;
    end if;
    ar := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a  := to_sfixed (ar);
    ap := a;
    -- missed up matrix index
    if ap /= a then
      report "Index test, should be equal" severity error;
      print_matrix (ap, true);
    end if;
    bpr := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    bp  := to_sfixed (bpr);
    if reorder(bp) /= a then
      report "Index test2, should be equal" severity error;
      print_matrix (bp, true);
    end if;
    -- Create a matrix that is identical to another, but with the last
    -- row missing.
    ar := ((73.0, 31.0, 78.0),
           (54.0, 13.0, 43.0),
           (106.0, 32.0, 94.0));
    a    := to_sfixed (ar);
    bool := (a = to_sfixed(ambmans));  -- Note this line give a compile warning.
    if bool then
      report "Compare - extra row not detected" severity error;
    end if;
    -- Test multiply
    ambm := to_sfixed (am) * to_sfixed(bm);
    if ambm /= to_sfixed(ambmans) then
      report "matrix multiply problem" severity error;
      print_matrix (ambm);
    end if;
    -- vector * matrix
    amvbmv := to_sfixed (amv) * to_sfixed (bmv);
    if amvbmv /= to_sfixed (amvbmvans) then
      report "vector * matrix problem" severity error;
      print_vector (amvbmv);
      print_vector (amvbmvans);
    end if;
    -- Matrix * vector
    bvmm   := transpose (to_sfixed (bvm));
    avmbvm := to_sfixed (avm) * bvmm;
    if avmbvm /= to_sfixed (reshape (avmbvmans, 3, 1)) then
      report "matrix * vector problem" severity error;
      print_matrix (avmbvm);
      print_vector (avmbvmans);
    end if;
    -- vector * vector (assuming left is a column not a row)
--    avvbvv := to_sfixed(avv) * to_sfixed(bvv);
--    if avvbvv /= to_sfixed(avvbvvans) then
--      report "vector * vector problem" severity error;
--      print_matrix (avvbvv, true);
--    end if;
    -- vector * vector (assuming left is row, right is column)
    bvmm  := transpose (to_sfixed (bvv));
    mm := to_sfixed (bvm) * bvmm;
    nn (0) := to_sfixed (37.0, sfh, sfl);
    if mm /= nn then
      report "sf vector * vector = real problem, result 37"
        severity error;
      print_vector(mm);
    end if;

    ar := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a  := to_sfixed (ar);
    br := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b  := to_sfixed (br);
    c  := a * b;
    dr := ((30.0, 36.0, 42.0), (66.0, 81.0, 96.0), (102.0, 126.0, 150.0));
    d  := to_sfixed (dr);
    if d /= c then
      report "matrix * matrix 3x3" severity error;
      print_matrix (c, true);
      print_matrix (d, true);
    end if;
    -- Does not work because "to_sfixed" tries to fix the order of the matrix.
--    ar  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
--    ap := to_sfixed (ar);
--    bpr := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
--    bp := to_sfixed (bpr);
--    cp := ap * bp;
--    dpr := ((30.0, 36.0, 42.0), (66.0, 81.0, 96.0), (102.0, 126.0, 150.0));
--    dp := to_sfixed (dpr);
--    if dp /= cp then
--      report "matrix * matrix odd range problem" severity error;
--      print_matrix (cp, true);
--      print_matrix (dp, true);
--    end if;

    ar  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a   := to_sfixed (ar);
    bvr := (2.0, 3.0, 4.0);
    bv  := to_sfixed (bvr);
    bvmm  := transpose (bv);
    avmm  := a * bvmm;
    dvr := (20.0, 47.0, 74.0);
    dv  := to_sfixed(dvr);
    bvmm  := transpose (dv);
    if avmm /= bvmm then
      report "matrix * vector problem" severity error;
      print_matrix (avmm);
    end if;
    -- %%%%
    apr  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    ap   := to_sfixed (apr);
    bvpr := (2.0, 3.0, 4.0);
    bvp  := to_sfixed (bvpr);
    bvmm := transpose (bvp);
    avmm := ap * bvmm;
    dvpr := (20.0, 47.0, 74.0);
    dvp  := to_sfixed (dvpr);
    bvmm := transpose (dvp);
    if avmm /= bvmm then
      report "matrix * vector problem odd range" severity error;
      print_matrix (avmm);
      print_matrix (bvmm);
    end if;

    ar  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a   := to_sfixed (ar);
    bvr := (2.0, 3.0, 4.0);
    bv  := to_sfixed (bvr);
    cv  := bv * a;
    dvr := (42.0, 51.0, 60.0);
    dv  := to_sfixed (dvr);
    if cv /= dv then
      report "vector * matrix problem" severity error;
      print_vector (cv);
    end if;
    apr  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    ap   := to_sfixed (apr);
    -- ap  := reorder (ap);                -- flip it to make it work.
    bvpr := (2.0, 3.0, 4.0);
    bvp  := to_sfixed (bvpr);
    cvp  := bvp * ap;
    dvpr := (60.0, 51.0, 42.0);         -- backwards because of "downto"
    dvp  := to_sfixed (dvpr);
    if cvp /= dvp then
      report " vector * matrix problem odd range" severity error;
      print_vector (cvp);
    end if;

    if not QUIET then
      -- Cause some errors
      report "Expect 3 multiply errors here" severity note;
      e1     := to_sfixed(bm) * to_sfixed(am);  -- 2x3 * 4x2
      a3x4 := to_sfixed(bmv) * av4;           -- 3x2 * 4
      amvbmv := av4 * to_sfixed(bmv);           -- 4 * 3x2
    end if;

    iv2 := size (ambmans);
    assert iv2(0) = 4 report "Size returned the wrong Y dimension "
      & INTEGER'image(iv2(0)) severity error;
    assert iv2(1) = 3 report "Size returned the wrong X dimension "
      & INTEGER'image(iv2(1)) severity error;

    avr := (1.0, 2.0, 3.0);
    av  := to_sfixed (avr);
    avmm := transpose (av);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_sfixed (bvr);
    c   := avmm * bv;
    dr  := ((4.0, 5.0, 6.0), (8.0, 10.0, 12.0), (12.0, 15.0, 18.0));
    d   := to_sfixed (dr);
    if c /= d then
      report " vector * vector 3x3 problem" severity error;
      print_matrix (c);
    end if;
    avpr := (1.0, 2.0, 3.0);
    avp  := to_sfixed (avpr);
    avmm := transpose (avp);
    bvpr := (4.0, 5.0, 6.0);
    bvp  := to_sfixed (bvpr);
    c    := avmm * bvp;
    if c /= d then
      report "sf vector * vector problem odd range" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    avr := (1.0, 2.0, 3.0);
    av  := to_sfixed (avr);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_sfixed (bvr);
    cv  := av + bv;
    dvr := (5.0, 7.0, 9.0);
    dv  := to_sfixed (dvr);
    if cv /= dv then
      report " vector + vector problem" severity error;
      print_vector (cv);
    end if;

    avpr := (1.0, 2.0, 3.0);
    avp  := to_sfixed (avpr);
    bvpr := (4.0, 5.0, 6.0);
    bvp  := to_sfixed (bvpr);
    cvp  := avp + bvp;
    dvpr := (9.0, 7.0, 5.0);
    dvp  := to_sfixed (dvpr);
    if cvp /= dvp then
      report " vector + vector problem odd range" severity error;
      print_vector (cvp);
    end if;

    if not QUIET then
      report "Expect 3 addition errors here" severity note;
      a      := mones + to_sfixed (bm);      -- 3x3 + 3x2
      a      := mones + to_sfixed (dtestx);  -- 3x3 + 4x4
      av := to_sfixed (avmbvmans) + to_sfixed(avv);
    end if;

    avr := (1.0, 2.0, 3.0);
    av  := to_sfixed (avr);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_sfixed (bvr);
    cv  := av - bv;
    dvr := (-3.0, -3.0, -3.0);
    dv  := to_sfixed (dvr);
    if cv /= dv then
      report " vector - vector problem" severity error;
      print_vector (cv);
    end if;
    avr := (1.0, 2.0, 3.0);
    av  := to_sfixed (avr);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_sfixed (bvr);
    av  := times (av, bv);
    bvr := (4.0, 10.0, 18.0);
    bv  := to_sfixed (bvr);
    if av /= bv then
      report " vector .* vector (times) problem" severity error;
      print_vector (av);
    end if;

    avpr := (1.0, 2.0, 3.0);
    avp  := to_sfixed (avpr);
    bvpr := (4.0, 5.0, 6.0);
    bvp  := to_sfixed (bvpr);
    avp  := times (avp, bvp);
    bvpr := (18.0, 10.0, 4.0);          -- reversed because of "downto"
    bvp  := to_sfixed (bvpr);
    if avp /= bvp then
      report " vector .* vector (times) problem odd range" severity error;
      print_vector (avp);
    end if;

    avr := (1.0, 2.0, 3.0);
    av  := to_sfixed (avr);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_sfixed (bvr);
    av  := rdivide (bv, av);
    bvr := (4.0, 2.5, 2.0);
    bv  := to_sfixed (bvr);
    if av /= bv then
      report " vector ./ vector (rdivide) problem" severity error;
      print_vector (av);
    end if;

    avpr := (1.0, 2.0, 3.0);
    avp  := to_sfixed (avpr);
    bvpr := (4.0, 5.0, 6.0);
    bvp  := to_sfixed (bvpr);
    avp  := rdivide (bvp, avp);
    bvpr := (2.0, 2.5, 4.0);            -- reversed because of "downto"
    bvp  := to_sfixed (bvpr);
    if avp /= bvp then
      report " vector ./ vector (rdivide) problem odd range" severity error;
      print_vector (avp);
    end if;

    -- Addition and subtraction
    ar := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a  := to_sfixed (ar);
    b  := transpose(a);
    c  := a + b;
    dr := ((2.0, 6.0, 10.0), (6.0, 10.0, 14.0), (10.0, 14.0, 18.0));
    d  := to_sfixed (dr);
    if d /= c then
      report "matrix + matrix problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    ap := a;
    bp := b;
    cp := ap + bp;
    dr := ((2.0, 6.0, 10.0), (6.0, 10.0, 14.0), (10.0, 14.0, 18.0));
    d  := to_sfixed (dr);
    if d /= reorder(cp) then
      report "matrix + matrix odd range problem" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    c  := a - b;
    dr := ((0.0, -2.0, -4.0), (2.0, 0.0, -2.0), (4.0, 2.0, 0.0));
    d  := to_sfixed (dr);
    if d /= c then
      report "matrix - matrix problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    ap := a;
    bp := b;
    cp := ap - bp;
    dr := ((0.0, -2.0, -4.0), (2.0, 0.0, -2.0), (4.0, 2.0, 0.0));
    d  := to_sfixed (dr);
    if d /= reorder(cp) then
      report "matrix - matrix odd range problem" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    if not QUIET then
      report "Expect 3 subtraction errors here" severity note;
      a      := mones - to_sfixed (bm);             -- 3x3 + 3x2
      a      := mones - to_sfixed (dtestx);         -- 3x3 + 4x4
      av := to_sfixed (avmbvmans) - to_sfixed (avv);
    end if;
    -- element by element multiply
    ar := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a  := to_sfixed (ar);
    b  := transpose(a);
    c  := times(a, b);
    dr := ((1.0, 8.0, 21.0), (8.0, 25.0, 48.0), (21.0, 48.0, 81.0));
    d  := to_sfixed (dr);
    if d /= c then
      report "times(matrix, matrix) problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    cp := times (ap, bp);
    dr := ((1.0, 8.0, 21.0), (8.0, 25.0, 48.0), (21.0, 48.0, 81.0));
    d  := to_sfixed (dr);
    if d /= reorder(cp) then
      report "times(matrix, matrix) problem odd range" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    if not QUIET then
      report "Expect 3 times errors here" severity note;
      a      := times(mones, to_sfixed (bm));       -- 3x3 + 3x2
      a      := times(mones, to_sfixed (dtestx));   -- 3x3 + 4x4
      av := times(to_sfixed (avmbvmans), to_sfixed(avv));
    end if;
    -- element by element divide
    ar := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a  := to_sfixed (ar);
    b  := transpose(a);
    cr := ((1.0, 4.0, 7.0), (2.0, 5.0, 8.0), (3.0, 6.0, 9.0));
    c  := to_sfixed (cr);
    if b /= c then
      report "Transpose problem" severity error;
      print_matrix (b);
      print_matrix (c);
    end if;
    c  := rdivide (a, b);
    dr := ((1.0, 0.5, 3.0/7.0), (2.0, 1.0, 6.0/8.0), (7.0/3.0, 8.0/6.0, 1.0));
    d  := to_sfixed (dr);
    if d /= c then
      report "rdivide(matrix, matrix) problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    cp := rdivide (ap, bp);
    dr := ((1.0, 0.5, 3.0/7.0), (2.0, 1.0, 6.0/8.0), (7.0/3.0, 8.0/6.0, 1.0));
    d  := to_sfixed (dr);
    if d /= reorder(cp) then
      report "rdivide(matrix, matrix) problem odd range" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    if not QUIET then
      report "Expect 3 times errors here" severity note;
      a      := rdivide(mones, to_sfixed(bm));      -- 3x3 + 3x2
      a      := rdivide(mones, to_sfixed(dtestx));  -- 3x3 + 4x4
      av := rdivide(to_sfixed(avmbvmans), to_sfixed(avv));
    end if;
    avvbvvt := transpose (to_sfixed (avvbvvans));
    avvbvvx := ((1.0, 2.0), (-1.0, -2.0), (-5.0, -10.0));
    if avvbvvt /= to_sfixed (avvbvvx) then
      report "2x3 transpose problem" severity error;
      print_matrix (avvbvvt);
    end if;

    -- SubMatrix test
    ar        := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a         := to_sfixed (ar);
    submatx   := exclude (a, 1, 1);
    submatr   := ((1.0, 3.0), (7.0, 9.0));
    submatans := to_sfixed (submatr);
    if submatx /= submatans then
      report "SubMatrix(1,1) problem" severity error;
      print_matrix (submatx);
    end if;
    submatx   := exclude (a, 2, 0);
    submatr   := ((2.0, 3.0), (5.0, 6.0));
    submatans := to_sfixed (submatr);
    if submatx /= submatans then
      report "SubMatrix(2,0) problem" severity error;
      print_matrix (submatx);
    end if;
    submatx   := exclude (a, 0, 2);
    submatr   := ((4.0, 5.0), (7.0, 8.0));
    submatans := to_sfixed (submatr);
    if submatx /= submatans then
      report "SubMatrix(0,2) problem" severity error;
      print_matrix (submatx);
    end if;
    apr       := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    ap        := to_sfixed (apr);
    submatx   := exclude (ap, 7, 4);
    submatr   := ((5.0, 6.0), (8.0, 9.0));
    submatans := to_sfixed (submatr);
    if submatx /= submatans then
      report "SubMatrix(7,4) odd range problem" severity error;
      print_matrix (submatx);
    end if;

    -- Determinant test
    submatr := ((1.0, 2.0), (4.0, 3.0));
    submatx := to_sfixed (submatr);
    m       := det (submatx);
    if m /= -5.0 then
      report "Determinant -5 /= "& to_string(m) severity error;
      print_matrix(submatx);
    end if;
    submatr := ((3.0, 2.0), (5.0, 2.0));
    submatx := to_sfixed (submatr);
    m       := det (submatx);
    if m /= -4.0 then
      report "Determinant -4 /= "& to_string(m) severity error;
      print_matrix(submatx);
    end if;
    ar := ((1.0, 3.0, 2.0), (4.0, 1.0, 3.0), (2.0, 5.0, 2.0));
    a  := to_sfixed (ar);
    m  := det (a);
    if m /= 17.0 then
      report "Determinant 17 /= "& to_string(m) severity error;
      print_matrix(a);
    end if;
    apr := ((1.0, 3.0, 2.0), (4.0, 1.0, 3.0), (2.0, 5.0, 2.0));
    ap  := to_sfixed (apr);
    m   := det (ap);
    if m /= 17.0 then
      report "Determinant odd range 17 /= "& to_string(m) severity error;
      print_matrix(ap);
    end if;
    -- Try a larger matrix
    m := det (to_sfixed (dtestx));           -- 4x4 matrix
    if m /= 24.0 then
      report "Determinant 24 /= "& to_string(m) severity error;
      print_matrix(dtestx);
    end if;
    -- from http://answers.yahoo.com/question/index?qid=20070123154335AAIVKZd
    mx5x5r := ((5.0, 2.0, 0.0, 0.0, -2.0),
               (0.0, 1.0, 4.0, 3.0, 2.0),
               (0.0, 0.0, 2.0, 6.0, 3.0),
               (0.0, 0.0, 3.0, 4.0, 1.0),
               (0.0, 0.0, 0.0, 0.0, 2.0));
    mx5x5 := to_sfixed (mx5x5r);
    m     := det (mx5x5);
    if m /= -100.0 then
      report "Determinant 5x5 problem = "& to_string(m) severity error;
    end if;
    if not quiet then
      report "Expect 2 DET/inv error here" severity note;
      m      := det (to_sfixed(avvbvvans));  -- Not square
      avvbvvt := inv (to_sfixed(avvbvvans));
    end if;

    -- Invert a matrix
    ar := ((1.0, 3.0, 2.0), (4.0, 1.0, 3.0), (2.0, 5.0, 2.0));
    a  := to_sfixed (ar);
    c  := inv(a);
    -- Doesn't come out even.
    dr := ((-13.0/17.0, 4.0/17.0, 7.0/17.0),
           (-2.0/17.0, -2.0/17.0, 5.0/17.0),
           (18.0/17.0, 1.0/17.0, -11.0/17.0));
    d := to_sfixed (dr);
    -- Round the results, good to 10 binary points (or 16)
    d := precision (d, 10);
    c := precision (c, 10);
    if c /= d then
      report "Invert problem " severity error;
      print_matrix(c, true);
      print_matrix(d, true);
    end if;

    submatr   := ((1.0, 2.0), (3.0, 4.0));
    submatx   := to_sfixed (submatr);
    submatx   := inv (submatx);
    submatr   := ((-2.0, 1.0), (1.5, -0.5));
    submatans := to_sfixed (submatr);
    if submatx /= submatans then
      report "inv(2x2) problem" severity error;
      print_matrix (submatx);
    end if;

    -- dot product
    m := dot (to_sfixed(amv), to_sfixed(bvm));
    assert m = 65.0
      report "Dot product problem, expected 65, and got " & to_string(m)
      severity error;
    m := dot (to_sfixed(amv), to_sfixed(bvv));
    assert m = 33.0
      report "Dot product problem, expected 33, and got " & to_string(m)
      severity error;
    if not quiet then
      report "Expect 1 dot error here" severity note;
      m := dot (to_sfixed(amv), av4);   -- Not the same length
    end if;

    -- Test sum and trace
    m := sum (to_sfixed(amv));
    if m /= 11.0 then
      report "sum (vector) problem, result was " & to_string(m)
        severity error;
    end if;

    m := trace (to_sfixed(ambmans));
    if m /= 180.0 then
      report "trace problem, result was " & to_string(m)
        severity error;
    end if;

    m := trace (to_sfixed(am));
    if m /= 12.0 then
      report "trace (2) problem, result was " & to_string (m)
        severity error;
    end if;

    av  := sum (to_sfixed(ambmans), 1);  -- Sum along Y
    bvr := (296.0, 112.0, 296.0);
    bv  := to_sfixed (bvr);
    if av /= bv then
      report "Sum (x,2) problem" severity error;
      print_vector (av);
    end if;

    av4  := sum (to_sfixed(ambmans), 2);  -- Sum along X
    bv4r := (182.0, 110.0, 232.0, 180.0);
    bv4  := to_sfixed (bv4r);
    if av4 /= bv4 then
      report "Sum (x,1) problem" severity error;
      print_vector (av4);
    end if;

    avr := (8.0, 1.0, 6.0);
    av  := to_sfixed (avr);
    m   := prod (av);
    if m /= 48.0 then
      report "prod (vector) problem "& to_string(m) severity error;
    end if;

    ar := ((8.0, 1.0, 6.0),
           (3.0, 5.0, 7.0),
           (4.0, 9.0, 2.0));
    a   := to_sfixed(ar);
    av  := prod(a);
    bvr := (96.0, 45.0, 84.0);
    bv  := to_sfixed (bvr);
    if av /= bv then
      report "prod(1) problem" severity error;
      print_vector (av);
    end if;
    av  := prod(a, 2);
    bvr := (48.0, 105.0, 72.0);
    bv  := to_sfixed (bvr);
    if av /= bv then
      report "prod(2) problem" severity error;
      print_vector (av);
    end if;

    if not quiet then
      report "Expect 3 sum/prod dim errors here" severity note;
      av := sum (a, 3);
      av := prod (a, 3);
      b  := flipdim (a, 3);
    end if;

    -- Flip a few Matrices...
    b := fliplr (to_sfixed(avm));
    cr := ((3.0, 2.0, 1.0),
           (6.0, 5.0, 4.0),
           (9.0, 8.0, 7.0));
    c := to_sfixed(cr);
    if b /= c then
      report "Fliplr problem " severity error;
      print_matrix (b);
    end if;

    b := flipdim (to_sfixed(avm), 2);
    cr := ((3.0, 2.0, 1.0),
           (6.0, 5.0, 4.0),
           (9.0, 8.0, 7.0));
    c := to_sfixed(cr);
    if b /= c then
      report "Flipdim 2 problem " severity error;
      print_matrix (b);
    end if;


    b := flipup (to_sfixed(avm));
    cr := ((7.0, 8.0, 9.0),
           (4.0, 5.0, 6.0),
           (1.0, 2.0, 3.0));
    c := to_sfixed(cr);
    if b /= c then
      report "Flipup problem " severity error;
      print_matrix (b);
    end if;

    b := flipdim (to_sfixed(avm), 1);
    cr := ((7.0, 8.0, 9.0),
           (4.0, 5.0, 6.0),
           (1.0, 2.0, 3.0));
    c := to_sfixed(cr);
    if b /= c then
      report "Flipdim 1 problem " severity error;
      print_matrix (b);
    end if;


    b := rot90 (to_sfixed(avm));
    cr := ((3.0, 6.0, 9.0),
           (2.0, 5.0, 8.0),
           (1.0, 4.0, 7.0));
    c := to_sfixed(cr);
    if b /= c then
      report "rot90 problem " severity error;
      print_matrix (b);
    end if;

    b := rot90 (to_sfixed(avm), 2);
    cr := ((9.0, 8.0, 7.0),
           (6.0, 5.0, 4.0),
           (3.0, 2.0, 1.0));
    c := to_sfixed(cr);
    if b /= c then
      report "rot90 2 problem " severity error;
      print_matrix (b);
    end if;

    b := rot90 (to_sfixed(avm), 3);
    cr := ((7.0, 4.0, 1.0),
           (8.0, 5.0, 2.0),
           (9.0, 6.0, 3.0));
    c := to_sfixed(cr);
    if b /= c then
      report "rot90 3 problem " severity error;
      print_matrix (b);
    end if;

    a := tril(to_sfixed(avm));
    cr := ((0.0, 0.0, 0.0),
           (4.0, 0.0, 0.0),
           (7.0, 8.0, 0.0));
    c := to_sfixed(cr);
    if a /= c then
      report "tril problem" severity error;
      print_matrix (a);
    end if;

    av  := diag (to_sfixed(avm));
    bvr := (1.0, 5.0, 9.0);
    bv  := to_sfixed(bvr);
    if av /= bv then
      report "diag problem" severity error;
      print_vector (av);
    end if;

    avr := (5.0, 6.0, 7.0);
    a   := diag (to_sfixed(avr));
    br := ((5.0, 0.0, 0.0),
           (0.0, 6.0, 0.0),
           (0.0, 0.0, 7.0));
    b := to_sfixed(br);
    if a /= b then
      report "diag(vector) problem" severity error;
      print_matrix (a);
    end if;

    a := blkdiag (to_sfixed(bvv));
    br := ((-1.0, 0.0, 0.0),
           (0.0, 1.0, 0.0),
           (0.0, 0.0, 5.0));
    b := to_sfixed(br);
    if a /= b then
      report "blkdiag problem" severity error;
      print_matrix (a);
    end if;

    a := triu (to_sfixed(avm));
    cr := ((0.0, 2.0, 3.0),
           (0.0, 0.0, 6.0),
           (0.0, 0.0, 0.0));
    c := to_sfixed(cr);
    if a /= c then
      report "triu problem" severity error;
      print_matrix (a);
    end if;
    avr := (1.0, 2.0, 3.0);
    av  := to_sfixed (avr);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_sfixed (bvr);
    cv  := cross (av, bv);
    dvr := (-3.0, 6.0, -3.0);
    dv  := to_sfixed (dvr);
    if cv /= dv then
      report "Cross product problem" severity error;
      print_vector (cv);
    end if;
    a := to_sfixed(avm);
    b := rot90(to_sfixed(avm), 2);
    c := cross (a, b);
    dr := ((-30.0, -30.0, -30.0),
           (60.0, 60.0, 60.0),
           (-30.0, -30.0, -30.0));
    d := to_sfixed(dr);
    if c /= d then
      report "Cross product (matrix) problem" severity error;
      print_matrix (c);
    end if;

    ar := ((1.0, 1.0, -1.0),
           (2.0, -1.0, 1.0),
           (-1.0, 2.0, 2.0));
    a                   := to_sfixed (ar);
    avr                 := (-2.0, 5.0, 1.0);
    av                  := to_sfixed (avr);
    bv                  := linsolve (a, av);
    cvr                 := (1.0, -1.0, 2.0);
    cv                  := to_sfixed (cvr);
    -- Fix the rounding problem
--    bv (0)(bv(0)'low+1) := '0';
--    bv (1)(bv(1)'low+1) := '0';
--    bv (2)(bv(2)'low+2) := '0';
    bv := precision (bv, 13);
    if bv /= cv then
      report "Linsolve problem" severity error;
      print_vector (bv);
      print_vector (cv);
    end if;

    ar := ((3.0, 2.0, -1.0),
           (2.0, -2.0, 4.0),
           (-1.0, 0.5, -1.0));
    a      := to_sfixed (ar);
    avr    := (1.0, -2.0, 0.0);
    av     := to_sfixed (avr);
    bv     := linsolve (a, av);
    -- Because of the "3", this answer needs rounding
--    bv (0) := to_sfixed (to_integer(bv(0)), sfh, sfl);
--    bv (1) := to_sfixed (to_integer(bv(1)), sfh, sfl);
--    bv (2) := to_sfixed (to_integer(bv(2)), sfh, sfl);
    cvr    := (1.0, -2.0, -2.0);
    cv     := to_sfixed (cvr);
    bv := precision (bv, 11);
    if bv /= cv then
      report "Linsolve problem 2" severity error;
      print_vector (bv);
      print_vector (cv);
    end if;

    ar := ((2.0, 2.0, -1.0),
           (2.0, -2.0, -4.0),
           (-1.0, 0.5, -1.0));
    a := to_sfixed (ar);
    b := normalize (a);
    cr := ((0.5, 0.5, -0.25),
           (0.5, -0.5, -1.0),
           (-0.25, 0.125, -0.25));
    c := to_sfixed (cr);
    if b /= c then
      report "Normalization error" severity error;
      print_matrix (b);
    end if;

    avr := (1.0, 2.0, -4.0);
    av  := to_sfixed (avr);
    bv  := normalize (av);
    cvr := (0.25, 0.5, -1.0);
    cv  := to_sfixed (cvr);
    if bv /= cv then
      report "Normalization vector error" severity error;
      print_vector (bv);
    end if;

    avr := (1.0, 2.0, 3.0);             -- 3*x^2 + 2*x + 1
    av  := to_sfixed (avr);
    bvr := (5.0, 7.0, 9.0);
    bv  := to_sfixed (bvr);
    cv  := polyval (av, bv);
    dvr := (86.0, 162.0, 262.0);
    dv  := to_sfixed (dvr);
    if cv /= dv then
      report "Polyval problem" severity error;
      print_vector (cv);
    end if;

    -- Matrix raised to a power.
    b := to_sfixed(avm)**2;
    cr := ((30.0, 36.0, 42.0),
           (66.0, 81.0, 96.0),
           (102.0, 126.0, 150.0));
    c := to_sfixed (cr);
    if b /= c then
      report "matrix ** 2 problem" severity error;
      print_matrix (b);
    end if;

    b := to_sfixed(avm)**1;
    if b /= to_sfixed(avm) then
      report "matrix ** 1 problem" severity error;
      print_matrix (b);
    end if;

    b := to_sfixed(avm)**3;
    cr := ((468.0, 576.0, 684.0),
           (1062.0, 1305.0, 1548.0),
           (1656.0, 2034.0, 2412.0));
    c := to_sfixed(cr);
    if b /= c then
      report "matrix ** 3 problem" severity error;
      print_matrix (b);
    end if;

    -- overflow on last number
--    b := to_sfixed(avm)**4;
--    cr := ((7560.0, 9288.0, 11016.0),
--          (17118.0, 21033.0, 24948.0),
--          (26676.0, 32778.0, 38880.0));
--    c := to_sfixed(cr);
--    if b /= c then
--      report "matrix ** 4 problem" severity error;
--      print_matrix (b);
--    end if;

    -- Overflow
--    b := to_sfixed(avm)**5;
--    cr := ((121824.0, 149688.0, 177552.0),
--          (275886.0, 338985.0, 402084.0),
--          (429948.0, 528282.0, 626616.0));
--    c := to_sfixed(cr);
--    if b /= c then
--      report "matrix ** 5 problem" severity error;
--      print_matrix (b);
--    end if;

    b := to_sfixed(avm)**0;
    c := ones(3, 3);
    if b /= c then
      report "matrix ** 0 problem" severity error;
      print_matrix (b);
    end if;

    -- The "1,2,3" matrix does not scale well.
    ar := ((1.0, 3.0, 2.0), (4.0, 1.0, 3.0), (2.0, 5.0, 2.0));
    a  := to_sfixed (ar);
    b  := a**(-1);
    c  := inv(a);
    if b /= c then
      report "matrix ** -1 problem" severity error;
      print_matrix (b);
    end if;

    testersf_done <= true;
    wait;
  end process tester;


  -- purpose: apply stims
  testeruf : process is
    constant one  : ufixed (ufh downto ufl) := (0      => '1', others => '0');  --
    constant zero : ufixed (ufh downto ufl) := (others => '0');        --
    constant mones : ufixed_matrix := ((one, one, one),
                                       (one, one, one),
                                       (one, one, one));        --matrix
    constant am : real_matrix := ((7.0, 3.0), (2.0, 5.0),
                                  (6.0, 8.0), (9.0, 0.0));
    constant bm : real_matrix := ((7.0, 4.0, 9.0), (8.0, 1.0, 5.0));
    variable e1 : ufixed_matrix (0 to 1, 0 to 1);               -- bm * am
    constant ambmans : real_matrix := ((73.0, 31.0, 78.0),
                                       (54.0, 13.0, 43.0),
                                       (106.0, 32.0, 94.0),
                                       (63.0, 36.0, 81.0));     -- am * bm
    variable ambm      : ufixed_matrix (0 to 3, 0 to 2);        -- am * bm
    constant amv       : real_vector := (1.0, 4.0, 6.0);        -- real_vector
    constant bmv       : real_matrix := ((2.0, 3.0), (5.0, 8.0), (7.0, 9.0));
    constant amvbmvans : real_vector := (64.0, 89.0);
    variable amvbmv    : ufixed_vector (0 to 1);  -- amv * bmv
    constant avm : real_matrix := ((1.0, 2.0, 3.0),
                                   (4.0, 5.0, 6.0),
                                   (7.0, 8.0, 9.0));
    constant bvm       : real_vector := (3.0, 5.0, 7.0);
    variable avmm, bvmm : ufixed_matrix (0 to 2, 0 to 0);
    variable avmbvm    : ufixed_matrix (0 to 2, 0 to 0);  -- matrix * vector
    constant avmbvmans : real_vector := (34.0, 79.0, 124.0);
    constant avv       : real_vector := (1.0, 2.0);
    constant bvv       : real_vector := (1.0, 1.0, 5.0);
    variable avvbvv    : ufixed_matrix (0 to 1, 0 to 2);        -- matrix
    variable avvbvvt   : ufixed_matrix (0 to 2, 0 to 1);        -- matrix
    variable avvbvvx   : real_matrix (0 to 2, 0 to 1);          -- matrix
    -- vector * vector (assuming left is a column not a row)
    constant avvbvvans : real_matrix := ((1.0, 1.0, 5.0),
                                         (2.0, 2.0, 10.0));
    constant dtestx : real_matrix := ((3.0, 2.0, 0.0, 1.0),
                                      (4.0, 0.0, 1.0, 2.0),
                                      (3.0, 0.0, 2.0, 1.0),
                                      (9.0, 2.0, 3.0, 1.0));
    variable mx5x5r                 : real_matrix (0 to 4, 0 to 4);    -- 4x4
    variable mx5x5                  : ufixed_matrix (0 to 4, 0 to 4);  -- 4x4
    variable submatx, submatans     : ufixed_matrix (0 to 1, 0 to 1);
    variable submatr                : real_matrix (0 to 1, 0 to 1);
    variable iv2                    : integer_vector (0 to 1);  -- integer vector
    variable ar, br, cr, dr         : real_matrix (0 to 2, 0 to 2);
    variable a, b, c, d             : ufixed_matrix (0 to 2, 0 to 2);
    variable apr, bpr, cpr, dpr     : real_matrix (9 downto 7, 6 downto 4);
    variable ap, bp, cp, dp         : ufixed_matrix (9 downto 7, 6 downto 4);
    variable avr, bvr, cvr, dvr     : real_vector (0 to 2);
    variable av, bv, cv, dv         : ufixed_vector (0 to 2);
    variable avpr, bvpr, cvpr, dvpr : real_vector (12 downto 10);
    variable avp, bvp, cvp, dvp     : ufixed_vector (12 downto 10);
    variable av4, bv4               : ufixed_vector (0 to 3);
    variable a3x4               : ufixed_matrix (0 to 2, 0 to 3);
    variable av4r, bv4r             : real_vector (0 to 3);
    variable m, n                   : ufixed (ufh downto ufl);
    variable mm, nn             : ufixed_vector (0 to 0);
    variable i, j                   : INTEGER;
    variable bool                   : BOOLEAN;
  begin
    wait until testeruf_start;
    -- Basic test  Make sure the compare functions work.
    -- Test ones and Zeros functions
    a    := ones (3, 3);
    bool := (mones = a);
    if not bool then
      report "mones = ones(a)" severity error;
    end if;
    bool := (mones /= a);
    if bool then
      report "mones /= ones(a)" severity error;
    end if;
    a    := zeros (3, 3);
    bool := (mones = a);
    if bool then
      report "mones = zeros(a)" severity error;
    end if;
    bool := (mones /= a);
    if not bool then
      report "mones /= zeros(a)" severity error;
    end if;
    -- Test identity (eye) function
    a := eye (3, 3);
    b := ((one, zero, zero), (zero, one, zero), (zero, zero, one));
    if a /= b then
      report "eye not working" severity error;
      print_matrix (a);
    end if;
    bool := (a = mones);
    if bool then
      report "identity = ones returned true" severity error;
    end if;
    ar := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a  := to_ufixed (ar);
    ap := a;
    -- missed up matrix index
    if ap /= a then
      report "Index test, should be equal" severity error;
      print_matrix (ap, true);
    end if;
    bpr := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    bp  := to_ufixed (bpr);
    if reorder(bp) /= a then
      report "Index test2, should be equal" severity error;
      print_matrix (bp, true);
    end if;
    -- Create a matrix that is identical to another, but with the last
    -- row missing.
    ar := ((73.0, 31.0, 78.0),
           (54.0, 13.0, 43.0),
           (106.0, 32.0, 94.0));
    a    := to_ufixed (ar);
    bool := (a = to_ufixed(ambmans));  -- Note this line give a compile warning.
    if bool then
      report "Compare - extra row not detected" severity error;
    end if;
    -- Test multiply
    ambm := to_ufixed (am) * to_ufixed(bm);
    if ambm /= to_ufixed(ambmans) then
      report "matrix multiply problem" severity error;
      print_matrix (ambm);
    end if;
    -- vector * matrix
    amvbmv := to_ufixed (amv) * to_ufixed (bmv);
    if amvbmv /= to_ufixed (amvbmvans) then
      report "vector * matrix problem" severity error;
      print_vector (amvbmv);
      print_vector (amvbmvans);
    end if;
    -- Matrix * vector
    bvmm   := transpose (to_ufixed (bvm));
    avmbvm := to_ufixed (avm) * bvmm;
    if avmbvm /= to_ufixed (reshape (avmbvmans, 3, 1)) then
      report "matrix * vector problem" severity error;
      print_matrix (avmbvm);
      print_vector (avmbvmans);
    end if;
    -- vector * vector (assuming left is a column not a row)
--    avvbvv := to_ufixed(avv) * to_ufixed(bvv);
--    if avvbvv /= to_ufixed(avvbvvans) then
--      report "vector * vector problem" severity error;
--      print_matrix (avvbvv, true);
--    end if;
    -- vector * vector (assuming left is row, right is column)
    bvmm  := transpose (to_ufixed (bvv));
    mm := to_ufixed (bvm) * bvmm;
    nn (0) := to_ufixed (43.0, sfh, sfl);
    if mm /= nn then
      report "uf vector * vector = real problem, result 43 "
        severity error;
      print_vector(mm);
    end if;

    ar := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a  := to_ufixed (ar);
    br := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b  := to_ufixed (br);
    c  := a * b;
    dr := ((30.0, 36.0, 42.0), (66.0, 81.0, 96.0), (102.0, 126.0, 150.0));
    d  := to_ufixed (dr);
    if d /= c then
      report "matrix * matrix 3x3" severity error;
      print_matrix (c, true);
      print_matrix (d, true);
    end if;
    -- Does not work because "to_ufixed" tries to fix the order of the matrix.
--    ar  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
--    ap := to_ufixed (ar);
--    bpr := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
--    bp := to_ufixed (bpr);
--    cp := ap * bp;
--    dpr := ((30.0, 36.0, 42.0), (66.0, 81.0, 96.0), (102.0, 126.0, 150.0));
--    dp := to_ufixed (dpr);
--    if dp /= cp then
--      report "matrix * matrix odd range problem" severity error;
--      print_matrix (cp, true);
--      print_matrix (dp, true);
--    end if;

    ar  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a   := to_ufixed (ar);
    bvr := (2.0, 3.0, 4.0);
    bv  := to_ufixed (bvr);
    bvmm  := transpose (bv);
    avmm  := a * bvmm;
    dvr := (20.0, 47.0, 74.0);
    dv  := to_ufixed(dvr);
    bvmm := reshape (dv, 3, 1);
    if avmm /= bvmm then
      report "uf matrix * vector problem" severity error;
      print_matrix (avmm);
    end if;
    -- %%%%
    apr  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    ap   := to_ufixed (apr);
    bvpr := (2.0, 3.0, 4.0);
    bvp  := to_ufixed (bvpr);
    bvmm := transpose (bvp);
    avmm := ap * bvmm;
    dvpr := (20.0, 47.0, 74.0);
    dvp  := to_ufixed (dvpr);
    bvmm := reshape (dvp, 3, 1);
    if avmm /= bvmm then
      report "uf matrix * vector problem odd range" severity error;
      print_matrix (avmm);
      print_matrix (bvmm);
    end if;

    ar  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a   := to_ufixed (ar);
    bvr := (2.0, 3.0, 4.0);
    bv  := to_ufixed (bvr);
    cv  := bv * a;
    dvr := (42.0, 51.0, 60.0);
    dv  := to_ufixed (dvr);
    if cv /= dv then
      report "vector * matrix problem" severity error;
      print_vector (cv);
    end if;
    apr  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    ap   := to_ufixed (apr);
    -- ap  := reorder (ap);                -- flip it to make it work.
    bvpr := (2.0, 3.0, 4.0);
    bvp  := to_ufixed (bvpr);
    cvp  := bvp * ap;
    dvpr := (60.0, 51.0, 42.0);         -- backwards because of "downto"
    dvp  := to_ufixed (dvpr);
    if cvp /= dvp then
      report " vector * matrix problem odd range" severity error;
      print_vector (cvp);
    end if;

    if not QUIET then
      -- Cause some errors
      report "Expect 3 multiply errors here" severity note;
      e1     := to_ufixed(bm) * to_ufixed(am);  -- 2x3 * 4x2
      a3x4 := to_ufixed(bmv) * av4;           -- 3x2 * 4
      amvbmv := av4 * to_ufixed(bmv);           -- 4 * 3x2
    end if;

    iv2 := size (ambmans);
    assert iv2(0) = 4 report "Size returned the wrong Y dimension "
      & INTEGER'image(iv2(0)) severity error;
    assert iv2(1) = 3 report "Size returned the wrong X dimension "
      & INTEGER'image(iv2(1)) severity error;

    avr := (1.0, 2.0, 3.0);
    av  := to_ufixed (avr);
    avmm := transpose (av);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_ufixed (bvr);
    c   := avmm * bv;
    dr  := ((4.0, 5.0, 6.0), (8.0, 10.0, 12.0), (12.0, 15.0, 18.0));
    d   := to_ufixed (dr);
    if c /= d then
      report " vector * vector 3x3 problem" severity error;
      print_matrix (c);
    end if;
    avpr := (1.0, 2.0, 3.0);
    avp  := to_ufixed (avpr);
    avmm := transpose (avp);
    bvpr := (4.0, 5.0, 6.0);
    bvp  := to_ufixed (bvpr);
    c    := avmm * bvp;
    a    := to_ufixed (dr);
    if c /= a then
      report "uf vector * vector problem odd range" severity error;
      print_matrix (c);
      print_matrix (a);
    end if;
    avr := (1.0, 2.0, 3.0);
    av  := to_ufixed (avr);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_ufixed (bvr);
    cv  := av + bv;
    dvr := (5.0, 7.0, 9.0);
    dv  := to_ufixed (dvr);
    if cv /= dv then
      report " vector + vector problem" severity error;
      print_vector (cv);
    end if;

    avpr := (1.0, 2.0, 3.0);
    avp  := to_ufixed (avpr);
    bvpr := (4.0, 5.0, 6.0);
    bvp  := to_ufixed (bvpr);
    cvp  := avp + bvp;
    dvpr := (9.0, 7.0, 5.0);
    dvp  := to_ufixed (dvpr);
    if cvp /= dvp then
      report " vector + vector problem odd range" severity error;
      print_vector (cvp);
    end if;

    if not QUIET then
      report "Expect 3 addition errors here" severity note;
      a      := mones + to_ufixed (bm);      -- 3x3 + 3x2
      a      := mones + to_ufixed (dtestx);  -- 3x3 + 4x4
      av := to_ufixed (avmbvmans) + to_ufixed(avv);
    end if;

    avr := (1.0, 2.0, 3.0);
    av  := to_ufixed (avr);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_ufixed (bvr);
    cv  := bv - av;
    dvr := (3.0, 3.0, 3.0);
    dv  := to_ufixed (dvr);
    if cv /= dv then
      report " vector - vector problem" severity error;
      print_vector (cv);
    end if;
    avr := (1.0, 2.0, 3.0);
    av  := to_ufixed (avr);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_ufixed (bvr);
    av  := times (av, bv);
    bvr := (4.0, 10.0, 18.0);
    bv  := to_ufixed (bvr);
    if av /= bv then
      report " vector .* vector (times) problem" severity error;
      print_vector (av);
    end if;

    avpr := (1.0, 2.0, 3.0);
    avp  := to_ufixed (avpr);
    bvpr := (4.0, 5.0, 6.0);
    bvp  := to_ufixed (bvpr);
    avp  := times (avp, bvp);
    bvpr := (18.0, 10.0, 4.0);          -- reversed because of "downto"
    bvp  := to_ufixed (bvpr);
    if avp /= bvp then
      report " vector .* vector (times) problem odd range" severity error;
      print_vector (avp);
    end if;

    avr := (1.0, 2.0, 3.0);
    av  := to_ufixed (avr);
    bvr := (4.0, 5.0, 6.0);
    bv  := to_ufixed (bvr);
    av  := rdivide (bv, av);
    bvr := (4.0, 2.5, 2.0);
    bv  := to_ufixed (bvr);
    if av /= bv then
      report " vector ./ vector (rdivide) problem" severity error;
      print_vector (av);
    end if;

    avpr := (1.0, 2.0, 3.0);
    avp  := to_ufixed (avpr);
    bvpr := (4.0, 5.0, 6.0);
    bvp  := to_ufixed (bvpr);
    avp  := rdivide (bvp, avp);
    bvpr := (2.0, 2.5, 4.0);            -- reversed because of "downto"
    bvp  := to_ufixed (bvpr);
    if avp /= bvp then
      report " vector ./ vector (rdivide) problem odd range" severity error;
      print_vector (avp);
    end if;

    -- Addition and subtraction
    ar := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a  := to_ufixed (ar);
    b  := transpose(a);
    c  := a + b;
    dr := ((2.0, 6.0, 10.0), (6.0, 10.0, 14.0), (10.0, 14.0, 18.0));
    d  := to_ufixed (dr);
    if d /= c then
      report "matrix + matrix problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    ap := a;
    bp := b;
    cp := ap + bp;
    dr := ((2.0, 6.0, 10.0), (6.0, 10.0, 14.0), (10.0, 14.0, 18.0));
    d  := to_ufixed (dr);
    if d /= reorder(cp) then
      report "matrix + matrix odd range problem" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    c  := d - a;
    dr := ((1.0, 4.0, 7.0), (2.0, 5.0, 8.0), (3.0, 6.0, 9.0));
    d  := to_ufixed (dr);
    if d /= c then
      report "matrix - matrix problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
--    ap := a;
--    bp := b;
--    cp := ap - bp;
--    dr  := ((0.0, -2.0, -4.0), (2.0, 0.0, -2.0), (4.0, 2.0, 0.0));
--    d := to_ufixed (dr);
--    if d /= reorder(cp) then
--      report "matrix - matrix odd range problem" severity error;
--      print_matrix (cp);
--      print_matrix (d);
--    end if;
    if not QUIET then
      report "Expect 3 subtraction errors here" severity note;
      a      := mones - to_ufixed (bm);             -- 3x3 + 3x2
      a      := mones - to_ufixed (dtestx);         -- 3x3 + 4x4
      av := to_ufixed (avmbvmans) - to_ufixed (avv);
    end if;
    -- element by element multiply
    ar := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a  := to_ufixed (ar);
    b  := transpose(a);
    c  := times(a, b);
    dr := ((1.0, 8.0, 21.0), (8.0, 25.0, 48.0), (21.0, 48.0, 81.0));
    d  := to_ufixed (dr);
    if d /= c then
      report "times(matrix, matrix) problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    cp := times (ap, bp);
    dr := ((1.0, 8.0, 21.0), (8.0, 25.0, 48.0), (21.0, 48.0, 81.0));
    d  := to_ufixed (dr);
    if d /= reorder(cp) then
      report "times(matrix, matrix) problem odd range" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    if not QUIET then
      report "Expect 3 times errors here" severity note;
      a      := times(mones, to_ufixed (bm));       -- 3x3 + 3x2
      a      := times(mones, to_ufixed (dtestx));   -- 3x3 + 4x4
      av := times(to_ufixed (avmbvmans), to_ufixed(avv));
    end if;
    -- element by element divide
    ar := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a  := to_ufixed (ar);
    b  := transpose(a);
    cr := ((1.0, 4.0, 7.0), (2.0, 5.0, 8.0), (3.0, 6.0, 9.0));
    c  := to_ufixed (cr);
    if b /= c then
      report "Transpose problem" severity error;
      print_matrix (b);
      print_matrix (c);
    end if;
    c  := rdivide (a, b);
    dr := ((1.0, 0.5, 3.0/7.0), (2.0, 1.0, 6.0/8.0), (7.0/3.0, 8.0/6.0, 1.0));
    d  := to_ufixed (dr);
    if d /= c then
      report "rdivide(matrix, matrix) problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    cp := rdivide (ap, bp);
    dr := ((1.0, 0.5, 3.0/7.0), (2.0, 1.0, 6.0/8.0), (7.0/3.0, 8.0/6.0, 1.0));
    d  := to_ufixed (dr);
    if d /= reorder(cp) then
      report "rdivide(matrix, matrix) problem odd range" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    if not QUIET then
      report "Expect 3 times errors here" severity note;
      a      := rdivide(mones, to_ufixed(bm));      -- 3x3 + 3x2
      a      := rdivide(mones, to_ufixed(dtestx));  -- 3x3 + 4x4
      av := rdivide(to_ufixed(avmbvmans), to_ufixed(avv));
    end if;
    avvbvvt := transpose (to_ufixed (avvbvvans));
    avvbvvx := ((1.0, 2.0), (1.0, 2.0), (5.0, 10.0));
    if avvbvvt /= to_ufixed (avvbvvx) then
      report "2x3 transpose problem" severity error;
      print_matrix (avvbvvt);
    end if;

    -- SubMatrix test
    ar        := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    a         := to_ufixed (ar);
    submatx   := exclude (a, 1, 1);
    submatr   := ((1.0, 3.0), (7.0, 9.0));
    submatans := to_ufixed (submatr);
    if submatx /= submatans then
      report "SubMatrix(1,1) problem" severity error;
      print_matrix (submatx);
    end if;
    submatx   := exclude (a, 2, 0);
    submatr   := ((2.0, 3.0), (5.0, 6.0));
    submatans := to_ufixed (submatr);
    if submatx /= submatans then
      report "SubMatrix(2,0) problem" severity error;
      print_matrix (submatx);
    end if;
    submatx   := exclude (a, 0, 2);
    submatr   := ((4.0, 5.0), (7.0, 8.0));
    submatans := to_ufixed (submatr);
    if submatx /= submatans then
      report "SubMatrix(0,2) problem" severity error;
      print_matrix (submatx);
    end if;
    apr       := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    ap        := to_ufixed (apr);
    submatx   := exclude (ap, 7, 4);
    submatr   := ((5.0, 6.0), (8.0, 9.0));
    submatans := to_ufixed (submatr);
    if submatx /= submatans then
      report "SubMatrix(7,4) odd range problem" severity error;
      print_matrix (submatx);
    end if;

    -- dot product
    m := dot (to_ufixed(amv), to_ufixed(bvm));
    assert m = 65.0
      report "Dot product problem, expected 65, and got " & to_string(m)
      severity error;
    m := dot (to_ufixed(amv), to_ufixed(bvv));
    assert m = 35.0
      report "Dot product problem, expected 33, and got " & to_string(m) &
      " = " & REAL'image(to_real(m))
      severity error;
    if not quiet then
      report "Expect 1 dot error here" severity note;
      m := dot (to_ufixed(amv), av4);   -- Not the same length
    end if;

    -- Test sum and trace
    m := sum (to_ufixed(amv));
    if m /= 11.0 then
      report "sum (vector) problem, result was " & to_string(m)
        severity error;
    end if;

    m := trace (to_ufixed(ambmans));
    if m /= 180.0 then
      report "trace problem, result was " & to_string(m)
        severity error;
    end if;

    m := trace (to_ufixed(am));
    if m /= 12.0 then
      report "trace (2) problem, result was " & to_string (m)
        severity error;
    end if;

    av  := sum (to_ufixed(ambmans), 1);  -- Sum along Y
    bvr := (296.0, 112.0, 296.0);
    bv  := to_ufixed (bvr);
    if av /= bv then
      report "Sum (x,2) problem" severity error;
      print_vector (av);
    end if;

    av4  := sum (to_ufixed(ambmans), 2);  -- Sum along X
    bv4r := (182.0, 110.0, 232.0, 180.0);
    bv4  := to_ufixed (bv4r);
    if av4 /= bv4 then
      report "Sum (x,1) problem" severity error;
      print_vector (av4);
    end if;

    avr := (8.0, 1.0, 6.0);
    av  := to_ufixed (avr);
    m   := prod (av);
    if m /= 48.0 then
      report "prod (vector) problem "& to_string(m) severity error;
    end if;

    ar := ((8.0, 1.0, 6.0),
           (3.0, 5.0, 7.0),
           (4.0, 9.0, 2.0));
    a   := to_ufixed(ar);
    av  := prod(a);
    bvr := (96.0, 45.0, 84.0);
    bv  := to_ufixed (bvr);
    if av /= bv then
      report "prod(1) problem" severity error;
      print_vector (av);
    end if;
    av  := prod(a, 2);
    bvr := (48.0, 105.0, 72.0);
    bv  := to_ufixed (bvr);
    if av /= bv then
      report "prod(2) problem" severity error;
      print_vector (av);
    end if;

    if not quiet then
      report "Expect 3 sum/prod dim errors here" severity note;
      av := sum (a, 3);
      av := prod (a, 3);
      b  := flipdim (a, 3);
    end if;

    -- Flip a few Matrices...
    b := fliplr (to_ufixed(avm));
    cr := ((3.0, 2.0, 1.0),
           (6.0, 5.0, 4.0),
           (9.0, 8.0, 7.0));
    c := to_ufixed(cr);
    if b /= c then
      report "Fliplr problem " severity error;
      print_matrix (b);
    end if;

    b := flipdim (to_ufixed(avm), 2);
    cr := ((3.0, 2.0, 1.0),
           (6.0, 5.0, 4.0),
           (9.0, 8.0, 7.0));
    c := to_ufixed(cr);
    if b /= c then
      report "Flipdim 2 problem " severity error;
      print_matrix (b);
    end if;


    b := flipup (to_ufixed(avm));
    cr := ((7.0, 8.0, 9.0),
           (4.0, 5.0, 6.0),
           (1.0, 2.0, 3.0));
    c := to_ufixed(cr);
    if b /= c then
      report "Flipup problem " severity error;
      print_matrix (b);
    end if;

    b := flipdim (to_ufixed(avm), 1);
    cr := ((7.0, 8.0, 9.0),
           (4.0, 5.0, 6.0),
           (1.0, 2.0, 3.0));
    c := to_ufixed(cr);
    if b /= c then
      report "Flipdim 1 problem " severity error;
      print_matrix (b);
    end if;


    b := rot90 (to_ufixed(avm));
    cr := ((3.0, 6.0, 9.0),
           (2.0, 5.0, 8.0),
           (1.0, 4.0, 7.0));
    c := to_ufixed(cr);
    if b /= c then
      report "rot90 problem " severity error;
      print_matrix (b);
    end if;

    b := rot90 (to_ufixed(avm), 2);
    cr := ((9.0, 8.0, 7.0),
           (6.0, 5.0, 4.0),
           (3.0, 2.0, 1.0));
    c := to_ufixed(cr);
    if b /= c then
      report "rot90 2 problem " severity error;
      print_matrix (b);
    end if;

    b := rot90 (to_ufixed(avm), 3);
    cr := ((7.0, 4.0, 1.0),
           (8.0, 5.0, 2.0),
           (9.0, 6.0, 3.0));
    c := to_ufixed(cr);
    if b /= c then
      report "rot90 3 problem " severity error;
      print_matrix (b);
    end if;

    a := tril(to_ufixed(avm));
    cr := ((0.0, 0.0, 0.0),
           (4.0, 0.0, 0.0),
           (7.0, 8.0, 0.0));
    c := to_ufixed(cr);
    if a /= c then
      report "tril problem" severity error;
      print_matrix (a);
    end if;

    av  := diag (to_ufixed(avm));
    bvr := (1.0, 5.0, 9.0);
    bv  := to_ufixed(bvr);
    if av /= bv then
      report "diag problem" severity error;
      print_vector (av);
    end if;

    avr := (5.0, 6.0, 7.0);
    a   := diag (to_ufixed(avr));
    br := ((5.0, 0.0, 0.0),
           (0.0, 6.0, 0.0),
           (0.0, 0.0, 7.0));
    b := to_ufixed(br);
    if a /= b then
      report "diag(vector) problem" severity error;
      print_matrix (a);
    end if;

    a := blkdiag (to_ufixed(bvv));
    br := ((1.0, 0.0, 0.0),
           (0.0, 1.0, 0.0),
           (0.0, 0.0, 5.0));
    b := to_ufixed(br);
    if a /= b then
      report "blkdiag problem" severity error;
      print_matrix (a);
    end if;

    a := triu (to_ufixed(avm));
    cr := ((0.0, 2.0, 3.0),
           (0.0, 0.0, 6.0),
           (0.0, 0.0, 0.0));
    c := to_ufixed(cr);
    if a /= c then
      report "triu problem" severity error;
      print_matrix (a);
    end if;

    ar := ((2.0, 2.0, 1.0),
           (2.0, 2.0, 4.0),
           (1.0, 0.5, 1.0));
    a := to_ufixed (ar);
    b := normalize (a);
    cr := ((0.5, 0.5, 0.25),
           (0.5, 0.5, 1.0),
           (0.25, 0.125, 0.25));
    c := to_ufixed (cr);
    if b /= c then
      report "Normalization error" severity error;
      print_matrix (b);
    end if;

    avr := (1.0, 2.0, 4.0);
    av  := to_ufixed (avr);
    bv  := normalize (av);
    cvr := (0.25, 0.5, 1.0);
    cv  := to_ufixed (cvr);
    if bv /= cv then
      report "Normalization vector error" severity error;
      print_vector (bv);
    end if;

    -- Matrix raised to a power.
    b := to_ufixed(avm)**2;
    cr := ((30.0, 36.0, 42.0),
           (66.0, 81.0, 96.0),
           (102.0, 126.0, 150.0));
    c := to_ufixed (cr);
    if b /= c then
      report "matrix ** 2 problem" severity error;
      print_matrix (b);
    end if;

    b := to_ufixed(avm)**1;
    if b /= to_ufixed(avm) then
      report "matrix ** 1 problem" severity error;
      print_matrix (b);
    end if;

    b := to_ufixed(avm)**3;
    cr := ((468.0, 576.0, 684.0),
           (1062.0, 1305.0, 1548.0),
           (1656.0, 2034.0, 2412.0));
    c := to_ufixed(cr);
    if b /= c then
      report "matrix ** 3 problem" severity error;
      print_matrix (b);
    end if;

    b := to_ufixed(avm)**0;
    c := ones(3, 3);
    if b /= c then
      report "matrix ** 0 problem" severity error;
      print_matrix (b);
    end if;

    testeruf_done <= true;
    wait;
  end process testeruf;

  -- purpose: apply stims
  tester_signed : process is
    constant one  : SIGNED (sh downto 0) := (0      => '1', others => '0');  --
    constant zero : SIGNED (sh downto 0) := (others => '0');    --
    constant mones : signed_matrix := ((one, one, one),
                                       (one, one, one),
                                       (one, one, one));        --matrix
    constant am : integer_matrix := ((7, 3), (2, 5),
                                     (6, 8), (9, 0));
    constant bm : integer_matrix := ((7, 4, 9), (8, 1, 5));
    variable e1 : signed_matrix (0 to 1, 0 to 1);      -- bm * am
    constant ambmans : integer_matrix := ((73, 31, 78),
                                          (54, 13, 43),
                                          (106, 32, 94),
                                          (63, 36, 81));        -- am * bm
    variable ambm      : signed_matrix (0 to 3, 0 to 2);        -- am * bm
    constant amv       : integer_vector := (1, 4, 6);  -- integer_vector
    constant bmv       : integer_matrix := ((2, 3), (5, 8), (7, 9));
    constant amvbmvans : integer_vector := (64, 89);
    variable amvbmv    : signed_vector (0 to 1);       -- amv * bmv
    constant avm : integer_matrix := ((1, 2, 3),
                                      (4, 5, 6),
                                      (7, 8, 9));
    constant bvm       : integer_vector := (3, 5, 7);
    variable avmm, bvmm : signed_matrix (0 to 2, 0 to 0);
    variable avmbvm    : signed_matrix (0 to 2, 0 to 0);       -- matrix * vector
    constant avmbvmans : integer_vector := (34, 79, 124);
    constant avv       : integer_vector := (-1, -2);
    constant bvv       : integer_vector := (-1, 1, 5);
    variable avvbvv    : signed_matrix (0 to 1, 0 to 2);        -- matrix
    variable avvbvvt   : signed_matrix (0 to 2, 0 to 1);        -- matrix
    variable avvbvvx   : integer_matrix (0 to 2, 0 to 1);       -- matrix
    -- vector * vector (assuming left is a column not a row)
    constant avvbvvans : integer_matrix := ((1, -1, -5),
                                            (2, -2, -10));
    constant dtestx : integer_matrix := ((3, 2, 0, 1),
                                         (4, 0, 1, 2),
                                         (3, 0, 2, 1),
                                         (9, 2, 3, 1));
    variable mx5x5r                 : integer_matrix (0 to 4, 0 to 4);  -- 4x4
    variable mx5x5                  : signed_matrix (0 to 4, 0 to 4);   -- 4x4
    variable submatx, submatans     : signed_matrix (0 to 1, 0 to 1);
    variable submatr                : integer_matrix (0 to 1, 0 to 1);
    variable iv2                    : integer_vector (0 to 1);  -- integer vector
    variable ar, br, cr, dr         : integer_matrix (0 to 2, 0 to 2);
    variable a, b, c, d             : signed_matrix (0 to 2, 0 to 2);
    variable apr, bpr, cpr, dpr     : integer_matrix (9 downto 7, 6 downto 4);
    variable ap, bp, cp, dp         : signed_matrix (9 downto 7, 6 downto 4);
    variable avr, bvr, cvr, dvr     : integer_vector (0 to 2);
    variable av, bv, cv, dv         : signed_vector (0 to 2);
    variable avpr, bvpr, cvpr, dvpr : integer_vector (12 downto 10);
    variable avp, bvp, cvp, dvp     : signed_vector (12 downto 10);
    variable av4, bv4               : signed_vector (0 to 3);
    variable a3x4               : signed_matrix (0 to 2, 0 to 3);
    variable av4r, bv4r             : integer_vector (0 to 3);
    variable m, n                   : SIGNED (sh downto 0);
    variable mm, nn             : signed_vector (0 to 0);
    variable i, j                   : INTEGER;
    variable bool                   : BOOLEAN;
  begin
    wait until tester_signed_start;
    -- Basic test  Make sure the compare functions work.
    -- Test ones and Zeros functions
    a    := ones (3, 3);
    bool := (mones = a);
    if not bool then
      report "mones = ones(a)" severity error;
    end if;
    bool := (mones /= a);
    if bool then
      report "mones /= ones(a)" severity error;
    end if;
    a    := zeros (3, 3);
    bool := (mones = a);
    if bool then
      report "mones = zeros(a)" severity error;
    end if;
    bool := (mones /= a);
    if not bool then
      report "mones /= zeros(a)" severity error;
    end if;
    -- Test identity (eye) function
    a := eye (3, 3);
    b := ((one, zero, zero), (zero, one, zero), (zero, zero, one));
    if a /= b then
      report "eye not working" severity error;
      print_matrix (a);
    end if;
    bool := (a = mones);
    if bool then
      report "identity = ones returned true" severity error;
    end if;
    ar := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a  := to_signed (ar);
    ap := a;
    -- missed up matrix index
    if ap /= a then
      report "Index test, should be equal" severity error;
      print_matrix (ap, true);
    end if;
    bpr := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    bp  := to_signed (bpr);
    if reorder(bp) /= a then
      report "Index test2, should be equal" severity error;
      print_matrix (bp, true);
    end if;
    -- Create a matrix that is identical to another, but with the last
    -- row missing.
    ar := ((73, 31, 78),
           (54, 13, 43),
           (106, 32, 94));
    a    := to_signed (ar);
    bool := (a = to_signed(ambmans));  -- Note this line give a compile warning.
    if bool then
      report "Compare - extra row not detected" severity error;
    end if;
    -- Test multiply
    ambm := to_signed (am) * to_signed(bm);
    if ambm /= to_signed(ambmans) then
      report "matrix multiply problem" severity error;
      print_matrix (ambm);
    end if;
    -- vector * matrix
    amvbmv := to_signed (amv) * to_signed (bmv);
    if amvbmv /= to_signed (amvbmvans) then
      report "vector * matrix problem" severity error;
      print_vector (amvbmv);
      print_vector (amvbmvans);
    end if;
    -- Matrix * vector
    bvmm   := transpose (to_signed (bvm));
    avmbvm := to_signed (avm) * bvmm;
    if avmbvm /= to_signed (reshape (avmbvmans, 3, 1)) then
      report "matrix * vector problem" severity error;
      print_matrix (avmbvm);
      print_vector (avmbvmans);
    end if;
    -- vector * vector (assuming left is a column not a row)
--    avvbvv := to_signed(avv) * to_signed(bvv);
--    if avvbvv /= to_signed(avvbvvans) then
--      report "vector * vector problem" severity error;
--      print_matrix (avvbvv, true);
--    end if;
    -- vector * vector (assuming left is row, right is column)
    bvmm  := transpose (to_signed (bvv));
    mm := to_signed (bvm) * bvmm;
    nn (0) := to_signed (37, nn(0)'length);
    if mm /= nn then
      report "s vector * vector = real problem, result 37 "
        severity error;
      print_vector(mm);
    end if;


    ar := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a  := to_signed (ar);
    br := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    b  := to_signed (br);
    c  := a * b;
    dr := ((30, 36, 42), (66, 81, 96), (102, 126, 150));
    d  := to_signed (dr);
    if d /= c then
      report "matrix * matrix 3x3" severity error;
      print_matrix (c, true);
      print_matrix (d, true);
    end if;
    -- Does not work because "to_signed" tries to fix the order of the matrix.
--    ar  := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
--    ap := to_signed (ar);
--    bpr := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
--    bp := to_signed (bpr);
--    cp := ap * bp;
--    dpr := ((30, 36, 42), (66, 81, 96), (102, 126, 150));
--    dp := to_signed (dpr);
--    if dp /= cp then
--      report "matrix * matrix odd range problem" severity error;
--      print_matrix (cp, true);
--      print_matrix (dp, true);
--    end if;

    ar  := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a   := to_signed (ar);
    bvr := (2, 3, 4);
    bv  := to_signed (bvr);
    bvmm  := transpose (bv);
    avmm  := a * bvmm;
    dvr := (20, 47, 74);
    dv  := to_signed(dvr);
    bvmm  := transpose (dv);
    if avmm /= bvmm then
      report "s matrix * vector problem" severity error;
      print_matrix (avmm);
    end if;

    apr  := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    ap   := to_signed (apr);
    bvpr := (2, 3, 4);
    bvp  := to_signed (bvpr);
    bvmm := transpose (bvp);
    avmm := ap * bvmm;
    dvpr := (20, 47, 74);
    dvp  := to_signed (dvpr);
    bvmm := reshape (dvp, 3, 1);
    if avmm /= bvmm then
      report "s matrix * vector problem odd range" severity error;
      print_matrix (avmm);
    end if;

    ar  := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a   := to_signed (ar);
    bvr := (2, 3, 4);
    bv  := to_signed (bvr);
    cv  := bv * a;
    dvr := (42, 51, 60);
    dv  := to_signed (dvr);
    if cv /= dv then
      report "vector * matrix problem" severity error;
      print_vector (cv);
    end if;
    apr  := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    ap   := to_signed (apr);
    -- ap  := reorder (ap);                -- flip it to make it work.
    bvpr := (2, 3, 4);
    bvp  := to_signed (bvpr);
    cvp  := bvp * ap;
    dvpr := (60, 51, 42);               -- backwards because of "downto"
    dvp  := to_signed (dvpr);
    if cvp /= dvp then
      report " vector * matrix problem odd range" severity error;
      print_vector (cvp);
    end if;

    if not QUIET then
      -- Cause some errors
      report "Expect 3 multiply errors here" severity note;
      e1     := to_signed(bm) * to_signed(am);  -- 2x3 * 4x2
      a3x4 := to_signed(bmv) * av4;           -- 3x2 * 4
      amvbmv := av4 * to_signed(bmv);           -- 4 * 3x2
    end if;

    iv2 := size (ambmans);
    assert iv2(0) = 4 report "Size returned the wrong Y dimension "
      & INTEGER'image(iv2(0)) severity error;
    assert iv2(1) = 3 report "Size returned the wrong X dimension "
      & INTEGER'image(iv2(1)) severity error;

    avr := (1, 2, 3);
    av  := to_signed (avr);
    avmm := transpose (av);
    bvr := (4, 5, 6);
    bv  := to_signed (bvr);
    c   := avmm * bv;
    dr  := ((4, 5, 6), (8, 10, 12), (12, 15, 18));
    d   := to_signed (dr);
    if c /= d then
      report " vector * vector 3x3 problem" severity error;
      print_matrix (c);
    end if;
    avpr := (1, 2, 3);
    avp  := to_signed (avpr);
    avmm := transpose (avp);
    bvpr := (4, 5, 6);
    bvp  := to_signed (bvpr);
    c    := avmm * bvp;
    a    := rot90 (d, 2);               -- mirror because of "downto"
    if c /= d then
      report " vector * vector problem odd range" severity error;
      print_matrix (c);
    end if;
    avr := (1, 2, 3);
    av  := to_signed (avr);
    bvr := (4, 5, 6);
    bv  := to_signed (bvr);
    cv  := av + bv;
    dvr := (5, 7, 9);
    dv  := to_signed (dvr);
    if cv /= dv then
      report " vector + vector problem" severity error;
      print_vector (cv);
    end if;

    avpr := (1, 2, 3);
    avp  := to_signed (avpr);
    bvpr := (4, 5, 6);
    bvp  := to_signed (bvpr);
    cvp  := avp + bvp;
    dvpr := (9, 7, 5);
    dvp  := to_signed (dvpr);
    if cvp /= dvp then
      report " vector + vector problem odd range" severity error;
      print_vector (cvp);
    end if;

    if not QUIET then
      report "Expect 3 addition errors here" severity note;
      a      := mones + to_signed (bm);      -- 3x3 + 3x2
      a      := mones + to_signed (dtestx);  -- 3x3 + 4x4
      av := to_signed (avmbvmans) + to_signed(avv);
    end if;

    avr := (1, 2, 3);
    av  := to_signed (avr);
    bvr := (4, 5, 6);
    bv  := to_signed (bvr);
    cv  := av - bv;
    dvr := (-3, -3, -3);
    dv  := to_signed (dvr);
    if cv /= dv then
      report " vector - vector problem" severity error;
      print_vector (cv);
    end if;
    avr := (1, 2, 3);
    av  := to_signed (avr);
    bvr := (4, 5, 6);
    bv  := to_signed (bvr);
    av  := times (av, bv);
    bvr := (4, 10, 18);
    bv  := to_signed (bvr);
    if av /= bv then
      report " vector .* vector (times) problem" severity error;
      print_vector (av);
    end if;

    avpr := (1, 2, 3);
    avp  := to_signed (avpr);
    bvpr := (4, 5, 6);
    bvp  := to_signed (bvpr);
    avp  := times (avp, bvp);
    bvpr := (18, 10, 4);                -- reversed because of "downto"
    bvp  := to_signed (bvpr);
    if avp /= bvp then
      report " vector .* vector (times) problem odd range" severity error;
      print_vector (avp);
    end if;

    -- Addition and subtraction
    ar := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a  := to_signed (ar);
    b  := transpose(a);
    c  := a + b;
    dr := ((2, 6, 10), (6, 10, 14), (10, 14, 18));
    d  := to_signed (dr);
    if d /= c then
      report "matrix + matrix problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    ap := a;
    bp := b;
    cp := ap + bp;
    dr := ((2, 6, 10), (6, 10, 14), (10, 14, 18));
    d  := to_signed (dr);
    if d /= reorder(cp) then
      report "matrix + matrix odd range problem" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    c  := a - b;
    dr := ((0, -2, -4), (2, 0, -2), (4, 2, 0));
    d  := to_signed (dr);
    if d /= c then
      report "matrix - matrix problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    ap := a;
    bp := b;
    cp := ap - bp;
    dr := ((0, -2, -4), (2, 0, -2), (4, 2, 0));
    d  := to_signed (dr);
    if d /= reorder(cp) then
      report "matrix - matrix odd range problem" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    if not QUIET then
      report "Expect 3 subtraction errors here" severity note;
      a      := mones - to_signed (bm);            -- 3x3 + 3x2
      a      := mones - to_signed (dtestx);        -- 3x3 + 4x4
      av := to_signed (avmbvmans) - to_signed (avv);
    end if;
    -- element by element multiply
    ar := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a  := to_signed (ar);
    b  := transpose(a);
    c  := times(a, b);
    dr := ((1, 8, 21), (8, 25, 48), (21, 48, 81));
    d  := to_signed (dr);
    if d /= c then
      report "times(matrix, matrix) problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    cp := times (ap, bp);
    dr := ((1, 8, 21), (8, 25, 48), (21, 48, 81));
    d  := to_signed (dr);
    if d /= reorder(cp) then
      report "times(matrix, matrix) problem odd range" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    if not QUIET then
      report "Expect 3 times errors here" severity note;
      a      := times(mones, to_signed (bm));      -- 3x3 + 3x2
      a      := times(mones, to_signed (dtestx));  -- 3x3 + 4x4
      av := times(to_signed (avmbvmans), to_signed(avv));
    end if;
    -- element by element divide
    ar := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a  := to_signed (ar);
    b  := transpose(a);
    cr := ((1, 4, 7), (2, 5, 8), (3, 6, 9));
    c  := to_signed (cr);
    if b /= c then
      report "Transpose problem" severity error;
      print_matrix (b);
      print_matrix (c);
    end if;

    avvbvvt := transpose (to_signed (avvbvvans));
    avvbvvx := ((1, 2), (-1, -2), (-5, -10));
    if avvbvvt /= to_signed (avvbvvx) then
      report "2x3 transpose problem" severity error;
      print_matrix (avvbvvt);
    end if;

    -- SubMatrix test
    ar        := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a         := to_signed (ar);
    submatx   := exclude (a, 1, 1);
    submatr   := ((1, 3), (7, 9));
    submatans := to_signed (submatr);
    if submatx /= submatans then
      report "SubMatrix(1,1) problem" severity error;
      print_matrix (submatx);
    end if;
    submatx   := exclude (a, 2, 0);
    submatr   := ((2, 3), (5, 6));
    submatans := to_signed (submatr);
    if submatx /= submatans then
      report "SubMatrix(2,0) problem" severity error;
      print_matrix (submatx);
    end if;
    submatx   := exclude (a, 0, 2);
    submatr   := ((4, 5), (7, 8));
    submatans := to_signed (submatr);
    if submatx /= submatans then
      report "SubMatrix(0,2) problem" severity error;
      print_matrix (submatx);
    end if;
    apr       := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    ap        := to_signed (apr);
    submatx   := exclude (ap, 7, 4);
    submatr   := ((5, 6), (8, 9));
    submatans := to_signed (submatr);
    if submatx /= submatans then
      report "SubMatrix(7,4) odd range problem" severity error;
      print_matrix (submatx);
    end if;

    -- Determinant test
    submatr := ((1, 2), (4, 3));
    submatx := to_signed (submatr);
    m       := det (submatx);
    if m /= -5 then
      report "Determinant -5 /= "& to_string(m) severity error;
      print_matrix(submatx);
    end if;
    submatr := ((3, 2), (5, 2));
    submatx := to_signed (submatr);
    m       := det (submatx);
    if m /= -4 then
      report "Determinant -4 /= "& to_string(m) severity error;
      print_matrix(submatx);
    end if;
    ar := ((1, 3, 2), (4, 1, 3), (2, 5, 2));
    a  := to_signed (ar);
    m  := det (a);
    if m /= 17 then
      report "Determinant 17 /= "& to_string(m) severity error;
      print_matrix(a);
    end if;
    apr := ((1, 3, 2), (4, 1, 3), (2, 5, 2));
    ap  := to_signed (apr);
    m   := det (ap);
    if m /= 17 then
      report "Determinant odd range 17 /= "& to_string(m) severity error;
      print_matrix(ap);
    end if;
    -- Try a larger matrix
    m := det (to_signed (dtestx));      -- 4x4 matrix
    if m /= 24 then
      report "Determinant 24 /= "& to_string(m) severity error;
      print_matrix(dtestx);
    end if;
    -- from http://answers.yahoo.com/question/index?qid=20070123154335AAIVKZd
    mx5x5r := ((5, 2, 0, 0, -2),
               (0, 1, 4, 3, 2),
               (0, 0, 2, 6, 3),
               (0, 0, 3, 4, 1),
               (0, 0, 0, 0, 2));
    mx5x5 := to_signed (mx5x5r);
    m     := det (mx5x5);
    if m /= -100 then
      report "Determinant 5x5 problem = "& to_string(m) severity error;
    end if;
    if not quiet then
      report "Expect 2 DET/inv error here" severity note;
      m := det (to_signed(avvbvvans));  -- Not square
    end if;


    -- dot product
    m := dot (to_signed(amv), to_signed(bvm));
    assert m = 65
      report "Dot product problem, expected 65, and got " & to_string(m)
      severity error;
    m := dot (to_signed(amv), to_signed(bvv));
    assert m = 33
      report "Dot product problem, expected 33, and got " & to_string(m)
      severity error;
    if not quiet then
      report "Expect 1 dot error here" severity note;
      m := dot (to_signed(amv), av4);   -- Not the same length
    end if;

    -- Test sum and trace
    m := sum (to_signed(amv));
    if m /= 11 then
      report "sum (vector) problem, result was " & to_string(m)
        severity error;
    end if;

    m := trace (to_signed(ambmans));
    if m /= 180 then
      report "trace problem, result was " & to_string(m)
        severity error;
    end if;

    m := trace (to_signed(am));
    if m /= 12 then
      report "trace (2) problem, result was " & to_string (m)
        severity error;
    end if;

    av  := sum (to_signed(ambmans), 1);  -- Sum along Y
    bvr := (296, 112, 296);
    bv  := to_signed (bvr);
    if av /= bv then
      report "Sum (x,2) problem" severity error;
      print_vector (av);
    end if;

    av4  := sum (to_signed(ambmans), 2);  -- Sum along X
    bv4r := (182, 110, 232, 180);
    bv4  := to_signed (bv4r);
    if av4 /= bv4 then
      report "Sum (x,1) problem" severity error;
      print_vector (av4);
    end if;

    avr := (8, 1, 6);
    av  := to_signed (avr);
    m   := prod (av);
    if m /= 48 then
      report "prod (vector) problem "& to_string(m) severity error;
    end if;

    ar := ((8, 1, 6),
           (3, 5, 7),
           (4, 9, 2));
    a   := to_signed(ar);
    av  := prod(a);
    bvr := (96, 45, 84);
    bv  := to_signed (bvr);
    if av /= bv then
      report "prod(1) problem" severity error;
      print_vector (av);
    end if;
    av  := prod(a, 2);
    bvr := (48, 105, 72);
    bv  := to_signed (bvr);
    if av /= bv then
      report "prod(2) problem" severity error;
      print_vector (av);
    end if;

    if not quiet then
      report "Expect 3 sum/prod dim errors here" severity note;
      av := sum (a, 3);
      av := prod (a, 3);
      b  := flipdim (a, 3);
    end if;

    -- Flip a few Matrices...
    b := fliplr (to_signed(avm));
    cr := ((3, 2, 1),
           (6, 5, 4),
           (9, 8, 7));
    c := to_signed(cr);
    if b /= c then
      report "Fliplr problem " severity error;
      print_matrix (b);
    end if;

    b := flipdim (to_signed(avm), 2);
    cr := ((3, 2, 1),
           (6, 5, 4),
           (9, 8, 7));
    c := to_signed(cr);
    if b /= c then
      report "Flipdim 2 problem " severity error;
      print_matrix (b);
    end if;


    b := flipup (to_signed(avm));
    cr := ((7, 8, 9),
           (4, 5, 6),
           (1, 2, 3));
    c := to_signed(cr);
    if b /= c then
      report "Flipup problem " severity error;
      print_matrix (b);
    end if;

    b := flipdim (to_signed(avm), 1);
    cr := ((7, 8, 9),
           (4, 5, 6),
           (1, 2, 3));
    c := to_signed(cr);
    if b /= c then
      report "Flipdim 1 problem " severity error;
      print_matrix (b);
    end if;


    b := rot90 (to_signed(avm));
    cr := ((3, 6, 9),
           (2, 5, 8),
           (1, 4, 7));
    c := to_signed(cr);
    if b /= c then
      report "rot90 problem " severity error;
      print_matrix (b);
    end if;

    b := rot90 (to_signed(avm), 2);
    cr := ((9, 8, 7),
           (6, 5, 4),
           (3, 2, 1));
    c := to_signed(cr);
    if b /= c then
      report "rot90 2 problem " severity error;
      print_matrix (b);
    end if;

    b := rot90 (to_signed(avm), 3);
    cr := ((7, 4, 1),
           (8, 5, 2),
           (9, 6, 3));
    c := to_signed(cr);
    if b /= c then
      report "rot90 3 problem " severity error;
      print_matrix (b);
    end if;

    a := tril(to_signed(avm));
    cr := ((0, 0, 0),
           (4, 0, 0),
           (7, 8, 0));
    c := to_signed(cr);
    if a /= c then
      report "tril problem" severity error;
      print_matrix (a);
    end if;

    av  := diag (to_signed(avm));
    bvr := (1, 5, 9);
    bv  := to_signed(bvr);
    if av /= bv then
      report "diag problem" severity error;
      print_vector (av);
    end if;

    avr := (5, 6, 7);
    a   := diag (to_signed(avr));
    br := ((5, 0, 0),
           (0, 6, 0),
           (0, 0, 7));
    b := to_signed(br);
    if a /= b then
      report "diag(vector) problem" severity error;
      print_matrix (a);
    end if;

    a := blkdiag (to_signed(bvv));
    br := ((-1, 0, 0),
           (0, 1, 0),
           (0, 0, 5));
    b := to_signed(br);
    if a /= b then
      report "blkdiag problem" severity error;
      print_matrix (a);
    end if;

    a := triu (to_signed(avm));
    cr := ((0, 2, 3),
           (0, 0, 6),
           (0, 0, 0));
    c := to_signed(cr);
    if a /= c then
      report "triu problem" severity error;
      print_matrix (a);
    end if;
    avr := (1, 2, 3);
    av  := to_signed (avr);
    bvr := (4, 5, 6);
    bv  := to_signed (bvr);
    cv  := cross (av, bv);
    dvr := (-3, 6, -3);
    dv  := to_signed (dvr);
    if cv /= dv then
      report "Cross product problem" severity error;
      print_vector (cv);
    end if;
    a := to_signed(avm);
    b := rot90(to_signed(avm), 2);
    c := cross (a, b);
    dr := ((-30, -30, -30),
           (60, 60, 60),
           (-30, -30, -30));
    d := to_signed(dr);
    if c /= d then
      report "Cross product (matrix) problem" severity error;
      print_matrix (c);
    end if;

    -- Matrix raised to a power.
    b := to_signed(avm)**2;
    cr := ((30, 36, 42),
           (66, 81, 96),
           (102, 126, 150));
    c := to_signed (cr);
    if b /= c then
      report "matrix ** 2 problem" severity error;
      print_matrix (b);
    end if;

    b := to_signed(avm)**1;
    if b /= to_signed(avm) then
      report "matrix ** 1 problem" severity error;
      print_matrix (b);
    end if;

    b := to_signed(avm)**3;
    cr := ((468, 576, 684),
           (1062, 1305, 1548),
           (1656, 2034, 2412));
    c := to_signed(cr);
    if b /= c then
      report "matrix ** 3 problem" severity error;
      print_matrix (b);
    end if;

    b := to_signed(avm)**0;
    c := ones(3, 3);
    if b /= c then
      report "matrix ** 0 problem" severity error;
      print_matrix (b);
    end if;

    tester_signed_done <= true;
    wait;
  end process tester_signed;



  -- purpose: apply stims
  tester_unsigned : process is
    constant one  : UNSIGNED (uh downto 0) := (0      => '1', others => '0');  --
    constant zero : UNSIGNED (uh downto 0) := (others => '0');  --
    constant mones : unsigned_matrix := ((one, one, one),
                                         (one, one, one),
                                         (one, one, one));      --matrix
    constant am : integer_matrix := ((7, 3), (2, 5),
                                     (6, 8), (9, 0));
    constant bm : integer_matrix := ((7, 4, 9), (8, 1, 5));
    variable e1 : unsigned_matrix (0 to 1, 0 to 1);    -- bm * am
    constant ambmans : integer_matrix := ((73, 31, 78),
                                          (54, 13, 43),
                                          (106, 32, 94),
                                          (63, 36, 81));        -- am * bm
    variable ambm      : unsigned_matrix (0 to 3, 0 to 2);      -- am * bm
    constant amv       : integer_vector := (1, 4, 6);  -- integer_vector
    constant bmv       : integer_matrix := ((2, 3), (5, 8), (7, 9));
    constant amvbmvans : integer_vector := (64, 89);
    variable amvbmv    : unsigned_vector (0 to 1);     -- amv * bmv
    constant avm : integer_matrix := ((1, 2, 3),
                                      (4, 5, 6),
                                      (7, 8, 9));
    constant bvm       : integer_vector := (3, 5, 7);
    variable avmm, bvmm : unsigned_matrix (0 to 2, 0 to 0);
    variable avmbvm    : unsigned_matrix (0 to 2, 0 to 0);       -- matrix * vector
    constant avmbvmans : integer_vector := (34, 79, 124);
    constant avv       : integer_vector := (1, 2);
    constant bvv       : integer_vector := (1, 1, 5);
    variable avvbvv    : unsigned_matrix (0 to 1, 0 to 2);      -- matrix
    variable avvbvvt   : unsigned_matrix (0 to 2, 0 to 1);      -- matrix
    variable avvbvvx   : integer_matrix (0 to 2, 0 to 1);       -- matrix
    -- vector * vector (assuming left is a column not a row)
    constant avvbvvans : integer_matrix := ((1, 1, 5),
                                            (2, 2, 10));
    constant dtestx : integer_matrix := ((3, 2, 0, 1),
                                         (4, 0, 1, 2),
                                         (3, 0, 2, 1),
                                         (9, 2, 3, 1));
    variable mx5x5r                 : integer_matrix (0 to 4, 0 to 4);   -- 4x4
    variable mx5x5                  : unsigned_matrix (0 to 4, 0 to 4);  -- 4x4
    variable submatx, submatans     : unsigned_matrix (0 to 1, 0 to 1);
    variable submatr                : integer_matrix (0 to 1, 0 to 1);
    variable iv2                    : integer_vector (0 to 1);  -- integer vector
    variable ar, br, cr, dr         : integer_matrix (0 to 2, 0 to 2);
    variable a, b, c, d             : unsigned_matrix (0 to 2, 0 to 2);
    variable apr, bpr, cpr, dpr     : integer_matrix (9 downto 7, 6 downto 4);
    variable ap, bp, cp, dp         : unsigned_matrix (9 downto 7, 6 downto 4);
    variable avr, bvr, cvr, dvr     : integer_vector (0 to 2);
    variable av, bv, cv, dv         : unsigned_vector (0 to 2);
    variable avpr, bvpr, cvpr, dvpr : integer_vector (12 downto 10);
    variable avp, bvp, cvp, dvp     : unsigned_vector (12 downto 10);
    variable av4, bv4               : unsigned_vector (0 to 3);
    variable a3x4               : unsigned_matrix (0 to 2, 0 to 3);
    variable av4r, bv4r             : integer_vector (0 to 3);
    variable m, n                   : UNSIGNED (uh downto 0);
    variable mm, nn             : unsigned_vector (0 to 0);
    variable i, j                   : INTEGER;
    variable bool                   : BOOLEAN;
  begin
    wait until tester_unsigned_start;
    -- Basic test  Make sure the compare functions work.
    -- Test ones and Zeros functions
    a    := ones (3, 3);
    bool := (mones = a);
    if not bool then
      report "mones = ones(a)" severity error;
    end if;
    bool := (mones /= a);
    if bool then
      report "mones /= ones(a)" severity error;
    end if;
    a    := zeros (3, 3);
    bool := (mones = a);
    if bool then
      report "mones = zeros(a)" severity error;
    end if;
    bool := (mones /= a);
    if not bool then
      report "mones /= zeros(a)" severity error;
    end if;
    -- Test identity (eye) function
    a := eye (3, 3);
    b := ((one, zero, zero), (zero, one, zero), (zero, zero, one));
    if a /= b then
      report "eye not working" severity error;
      print_matrix (a);
    end if;
    bool := (a = mones);
    if bool then
      report "identity = ones returned true" severity error;
    end if;
    ar := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a  := to_unsigned (ar);
    ap := a;
    -- missed up matrix index
    if ap /= a then
      report "Index test, should be equal" severity error;
      print_matrix (ap, true);
    end if;
    bpr := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    bp  := to_unsigned (bpr);
    if reorder(bp) /= a then
      report "Index test2, should be equal" severity error;
      print_matrix (bp, true);
    end if;
    -- Create a matrix that is identical to another, but with the last
    -- row missing.
    ar := ((73, 31, 78),
           (54, 13, 43),
           (106, 32, 94));
    a    := to_unsigned (ar);
    bool := (a = to_unsigned(ambmans));  -- Note this line give a compile warning.
    if bool then
      report "Compare - extra row not detected" severity error;
    end if;
    -- Test multiply
    ambm := to_unsigned (am) * to_unsigned(bm);
    if ambm /= to_unsigned(ambmans) then
      report "matrix multiply problem" severity error;
      print_matrix (ambm);
    end if;
    -- vector * matrix
    amvbmv := to_unsigned (amv) * to_unsigned (bmv);
    if amvbmv /= to_unsigned (amvbmvans) then
      report "vector * matrix problem" severity error;
      print_vector (amvbmv);
      print_vector (amvbmvans);
    end if;
    -- Matrix * vector
    bvmm   := transpose (to_unsigned (bvm));
    avmbvm := to_unsigned (avm) * bvmm;
    if avmbvm /= to_unsigned (reshape (avmbvmans, 3, 1)) then
      report "matrix * vector problem" severity error;
      print_matrix (avmbvm);
      print_vector (avmbvmans);
    end if;
    -- vector * vector (assuming left is a column not a row)
--    avvbvv := to_unsigned(avv) * to_unsigned(bvv);
--    if avvbvv /= to_unsigned(avvbvvans) then
--      report "vector * vector problem" severity error;
--      print_matrix (avvbvv, true);
--    end if;
    -- vector * vector (assuming left is row, right is column)
    bvmm  := transpose (to_unsigned (bvv));
    mm := to_unsigned (bvm) * bvmm;
    nn (0) := to_unsigned (43, nn(0)'length);
    if mm /= nn then
      report "vector * vector = real problem, result should be 43 "
        severity error;
      print_vector(mm);
    end if;

    ar := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a  := to_unsigned (ar);
    br := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    b  := to_unsigned (br);
    c  := a * b;
    dr := ((30, 36, 42), (66, 81, 96), (102, 126, 150));
    d  := to_unsigned (dr);
    if d /= c then
      report "matrix * matrix 3x3" severity error;
      print_matrix (c, true);
      print_matrix (d, true);
    end if;
    -- Does not work because "to_unsigned" tries to fix the order of the matrix.
--    ar  := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
--    ap := to_unsigned (ar);
--    bpr := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
--    bp := to_unsigned (bpr);
--    cp := ap * bp;
--    dpr := ((30, 36, 42), (66, 81, 96), (102, 126, 150));
--    dp := to_unsigned (dpr);
--    if dp /= cp then
--      report "matrix * matrix odd range problem" severity error;
--      print_matrix (cp, true);
--      print_matrix (dp, true);
--    end if;

    ar  := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a   := to_unsigned (ar);
    bvr := (2, 3, 4);
    bv  := to_unsigned (bvr);
    bvmm  := transpose (bv);
    avmm  := a * bvmm;
    dvr := (20, 47, 74);
    dv  := to_unsigned(dvr);
    bvmm  := reshape (dv, 3, 1);
    if avmm /= bvmm then
      report "us matrix * vector problem" severity error;
      print_matrix (avmm);
    end if;
    -- %%%%
    apr  := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    ap   := to_unsigned (apr);
    bvpr := (2, 3, 4);
    bvp  := to_unsigned (bvpr);
    bvmm := transpose (bvp);
    avmm := ap * bvmm;
    dvpr := (20, 47, 74);
    dvp  := to_unsigned (dvpr);
    bvmm := reshape (dvp, 3, 1);
    if avmm /= bvmm then
      report "us matrix * vector problem odd range" severity error;
      print_matrix (avmm);
    end if;

    ar  := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a   := to_unsigned (ar);
    bvr := (2, 3, 4);
    bv  := to_unsigned (bvr);
    cv  := bv * a;
    dvr := (42, 51, 60);
    dv  := to_unsigned (dvr);
    if cv /= dv then
      report "vector * matrix problem" severity error;
      print_vector (cv);
    end if;
    apr  := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    ap   := to_unsigned (apr);
    -- ap  := reorder (ap);                -- flip it to make it work.
    bvpr := (2, 3, 4);
    bvp  := to_unsigned (bvpr);
    cvp  := bvp * ap;
    dvpr := (60, 51, 42);               -- backwards because of "downto"
    dvp  := to_unsigned (dvpr);
    if cvp /= dvp then
      report " vector * matrix problem odd range" severity error;
      print_vector (cvp);
    end if;

    if not QUIET then
      -- Cause some errors
      report "Expect 3 multiply errors here" severity note;
      e1     := to_unsigned(bm) * to_unsigned(am);  -- 2x3 * 4x2
      a3x4 := to_unsigned(bmv) * av4;             -- 3x2 * 4
      amvbmv := av4 * to_unsigned(bmv);             -- 4 * 3x2
    end if;

    iv2 := size (ambmans);
    assert iv2(0) = 4 report "Size returned the wrong Y dimension "
      & INTEGER'image(iv2(0)) severity error;
    assert iv2(1) = 3 report "Size returned the wrong X dimension "
      & INTEGER'image(iv2(1)) severity error;

    avr := (1, 2, 3);
    av  := to_unsigned (avr);
    avmm := transpose (av);
    bvr := (4, 5, 6);
    bv  := to_unsigned (bvr);
    c   := avmm * bv;
    dr  := ((4, 5, 6), (8, 10, 12), (12, 15, 18));
    d   := to_unsigned (dr);
    if c /= d then
      report " vector * vector 3x3 problem" severity error;
      print_matrix (c);
    end if;
    avpr := (1, 2, 3);
    avp  := to_unsigned (avpr);
    avmm := transpose (avp);
    bvpr := (4, 5, 6);
    bvp  := to_unsigned (bvpr);
    c    := avmm * bvp;
    if c /= d then
      report " vector * vector problem odd range" severity error;
      print_matrix (c);
    end if;
    avr := (1, 2, 3);
    av  := to_unsigned (avr);
    bvr := (4, 5, 6);
    bv  := to_unsigned (bvr);
    cv  := av + bv;
    dvr := (5, 7, 9);
    dv  := to_unsigned (dvr);
    if cv /= dv then
      report " vector + vector problem" severity error;
      print_vector (cv);
    end if;

    avpr := (1, 2, 3);
    avp  := to_unsigned (avpr);
    bvpr := (4, 5, 6);
    bvp  := to_unsigned (bvpr);
    cvp  := avp + bvp;
    dvpr := (9, 7, 5);
    dvp  := to_unsigned (dvpr);
    if cvp /= dvp then
      report " vector + vector problem odd range" severity error;
      print_vector (cvp);
    end if;

    if not QUIET then
      report "Expect 3 addition errors here" severity note;
      a      := mones + to_unsigned (bm);      -- 3x3 + 3x2
      a      := mones + to_unsigned (dtestx);  -- 3x3 + 4x4
      av := to_unsigned (avmbvmans) + to_unsigned(avv);
    end if;

    avr := (1, 2, 3);
    av  := to_unsigned (avr);
    bvr := (4, 5, 6);
    bv  := to_unsigned (bvr);
    cv  := bv - av;
    dvr := (3, 3, 3);
    dv  := to_unsigned (dvr);
    if cv /= dv then
      report " vector - vector problem" severity error;
      print_vector (cv);
    end if;
    avr := (1, 2, 3);
    av  := to_unsigned (avr);
    bvr := (4, 5, 6);
    bv  := to_unsigned (bvr);
    av  := times (av, bv);
    bvr := (4, 10, 18);
    bv  := to_unsigned (bvr);
    if av /= bv then
      report " vector .* vector (times) problem" severity error;
      print_vector (av);
    end if;

    avpr := (1, 2, 3);
    avp  := to_unsigned (avpr);
    bvpr := (4, 5, 6);
    bvp  := to_unsigned (bvpr);
    avp  := times (avp, bvp);
    bvpr := (18, 10, 4);                -- reversed because of "downto"
    bvp  := to_unsigned (bvpr);
    if avp /= bvp then
      report " vector .* vector (times) problem odd range" severity error;
      print_vector (avp);
    end if;


    -- Addition and subtraction
    ar := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a  := to_unsigned (ar);
    b  := transpose(a);
    c  := a + b;
    dr := ((2, 6, 10), (6, 10, 14), (10, 14, 18));
    d  := to_unsigned (dr);
    if d /= c then
      report "matrix + matrix problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    ap := a;
    bp := b;
    cp := ap + bp;
    dr := ((2, 6, 10), (6, 10, 14), (10, 14, 18));
    d  := to_unsigned (dr);
    if d /= reorder(cp) then
      report "matrix + matrix odd range problem" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    c  := d - a;
    dr := ((1, 4, 7), (2, 5, 8), (3, 6, 9));
    d  := to_unsigned (dr);
    if d /= c then
      report "matrix - matrix problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
--    ap := a;
--    bp := b;
--    cp := ap - bp;
--    dr  := ((0, -2, -4), (2, 0, -2), (4, 2, 0));
--    d := to_unsigned (dr);
--    if d /= reorder(cp) then
--      report "matrix - matrix odd range problem" severity error;
--      print_matrix (cp);
--      print_matrix (d);
--    end if;
    if not QUIET then
      report "Expect 3 subtraction errors here" severity note;
      a      := mones - to_unsigned (bm);            -- 3x3 + 3x2
      a      := mones - to_unsigned (dtestx);        -- 3x3 + 4x4
      av := to_unsigned (avmbvmans) - to_unsigned (avv);
    end if;
    -- element by element multiply
    ar := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a  := to_unsigned (ar);
    b  := transpose(a);
    c  := times(a, b);
    dr := ((1, 8, 21), (8, 25, 48), (21, 48, 81));
    d  := to_unsigned (dr);
    if d /= c then
      report "times(matrix, matrix) problem" severity error;
      print_matrix (c);
      print_matrix (d);
    end if;
    cp := times (ap, bp);
    dr := ((1, 8, 21), (8, 25, 48), (21, 48, 81));
    d  := to_unsigned (dr);
    if d /= reorder(cp) then
      report "times(matrix, matrix) problem odd range" severity error;
      print_matrix (cp);
      print_matrix (d);
    end if;
    if not QUIET then
      report "Expect 3 times errors here" severity note;
      a      := times(mones, to_unsigned (bm));      -- 3x3 + 3x2
      a      := times(mones, to_unsigned (dtestx));  -- 3x3 + 4x4
      av := times(to_unsigned (avmbvmans), to_unsigned(avv));
    end if;
    -- element by element divide
    ar := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a  := to_unsigned (ar);
    b  := transpose(a);
    cr := ((1, 4, 7), (2, 5, 8), (3, 6, 9));
    c  := to_unsigned (cr);
    if b /= c then
      report "Transpose problem" severity error;
      print_matrix (b);
      print_matrix (c);
    end if;

    avvbvvt := transpose (to_unsigned (avvbvvans));
    avvbvvx := ((1, 2), (1, 2), (5, 10));
    if avvbvvt /= to_unsigned (avvbvvx) then
      report "2x3 transpose problem" severity error;
      print_matrix (avvbvvt);
    end if;

    -- SubMatrix test
    ar        := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    a         := to_unsigned (ar);
    submatx   := exclude (a, 1, 1);
    submatr   := ((1, 3), (7, 9));
    submatans := to_unsigned (submatr);
    if submatx /= submatans then
      report "SubMatrix(1,1) problem" severity error;
      print_matrix (submatx);
    end if;
    submatx   := exclude (a, 2, 0);
    submatr   := ((2, 3), (5, 6));
    submatans := to_unsigned (submatr);
    if submatx /= submatans then
      report "SubMatrix(2,0) problem" severity error;
      print_matrix (submatx);
    end if;
    submatx   := exclude (a, 0, 2);
    submatr   := ((4, 5), (7, 8));
    submatans := to_unsigned (submatr);
    if submatx /= submatans then
      report "SubMatrix(0,2) problem" severity error;
      print_matrix (submatx);
    end if;
    apr       := ((1, 2, 3), (4, 5, 6), (7, 8, 9));
    ap        := to_unsigned (apr);
    submatx   := exclude (ap, 7, 4);
    submatr   := ((5, 6), (8, 9));
    submatans := to_unsigned (submatr);
    if submatx /= submatans then
      report "SubMatrix(7,4) odd range problem" severity error;
      print_matrix (submatx);
    end if;

    -- dot product
    m := dot (to_unsigned(amv), to_unsigned(bvm));
    assert m = 65
      report "Dot product problem, expected 65, and got " & to_string(m)
      severity error;
    m := dot (to_unsigned(amv), to_unsigned(bvv));
    assert m = 35
      report "Dot product problem, expected 33, and got " & to_string(m) &
      " = " & integer'image(to_integer(m))
      severity error;
    if not quiet then
      report "Expect 1 dot error here" severity note;
      m := dot (to_unsigned(amv), av4);  -- Not the same length
    end if;

    -- Test sum and trace
    m := sum (to_unsigned(amv));
    if m /= 11 then
      report "sum (vector) problem, result was " & to_string(m)
        severity error;
    end if;

    m := trace (to_unsigned(ambmans));
    if m /= 180 then
      report "trace problem, result was " & to_string(m)
        severity error;
    end if;

    m := trace (to_unsigned(am));
    if m /= 12 then
      report "trace (2) problem, result was " & to_string (m)
        severity error;
    end if;

    av  := sum (to_unsigned(ambmans), 1);  -- Sum along Y
    bvr := (296, 112, 296);
    bv  := to_unsigned (bvr);
    if av /= bv then
      report "Sum (x,2) problem" severity error;
      print_vector (av);
    end if;

    av4  := sum (to_unsigned(ambmans), 2);  -- Sum along X
    bv4r := (182, 110, 232, 180);
    bv4  := to_unsigned (bv4r);
    if av4 /= bv4 then
      report "Sum (x,1) problem" severity error;
      print_vector (av4);
    end if;

    avr := (8, 1, 6);
    av  := to_unsigned (avr);
    m   := prod (av);
    if m /= 48 then
      report "prod (vector) problem "& to_string(m) severity error;
    end if;

    ar := ((8, 1, 6),
           (3, 5, 7),
           (4, 9, 2));
    a   := to_unsigned(ar);
    av  := prod(a);
    bvr := (96, 45, 84);
    bv  := to_unsigned (bvr);
    if av /= bv then
      report "prod(1) problem" severity error;
      print_vector (av);
    end if;
    av  := prod(a, 2);
    bvr := (48, 105, 72);
    bv  := to_unsigned (bvr);
    if av /= bv then
      report "prod(2) problem" severity error;
      print_vector (av);
    end if;

    if not quiet then
      report "Expect 3 sum/prod dim errors here" severity note;
      av := sum (a, 3);
      av := prod (a, 3);
      b  := flipdim (a, 3);
    end if;

    -- Flip a few Matrices...
    b := fliplr (to_unsigned(avm));
    cr := ((3, 2, 1),
           (6, 5, 4),
           (9, 8, 7));
    c := to_unsigned(cr);
    if b /= c then
      report "Fliplr problem " severity error;
      print_matrix (b);
    end if;

    b := flipdim (to_unsigned(avm), 2);
    cr := ((3, 2, 1),
           (6, 5, 4),
           (9, 8, 7));
    c := to_unsigned(cr);
    if b /= c then
      report "Flipdim 2 problem " severity error;
      print_matrix (b);
    end if;


    b := flipup (to_unsigned(avm));
    cr := ((7, 8, 9),
           (4, 5, 6),
           (1, 2, 3));
    c := to_unsigned(cr);
    if b /= c then
      report "Flipup problem " severity error;
      print_matrix (b);
    end if;

    b := flipdim (to_unsigned(avm), 1);
    cr := ((7, 8, 9),
           (4, 5, 6),
           (1, 2, 3));
    c := to_unsigned(cr);
    if b /= c then
      report "Flipdim 1 problem " severity error;
      print_matrix (b);
    end if;


    b := rot90 (to_unsigned(avm));
    cr := ((3, 6, 9),
           (2, 5, 8),
           (1, 4, 7));
    c := to_unsigned(cr);
    if b /= c then
      report "rot90 problem " severity error;
      print_matrix (b);
    end if;

    b := rot90 (to_unsigned(avm), 2);
    cr := ((9, 8, 7),
           (6, 5, 4),
           (3, 2, 1));
    c := to_unsigned(cr);
    if b /= c then
      report "rot90 2 problem " severity error;
      print_matrix (b);
    end if;

    b := rot90 (to_unsigned(avm), 3);
    cr := ((7, 4, 1),
           (8, 5, 2),
           (9, 6, 3));
    c := to_unsigned(cr);
    if b /= c then
      report "rot90 3 problem " severity error;
      print_matrix (b);
    end if;

    a := tril(to_unsigned(avm));
    cr := ((0, 0, 0),
           (4, 0, 0),
           (7, 8, 0));
    c := to_unsigned(cr);
    if a /= c then
      report "tril problem" severity error;
      print_matrix (a);
    end if;

    av  := diag (to_unsigned(avm));
    bvr := (1, 5, 9);
    bv  := to_unsigned(bvr);
    if av /= bv then
      report "diag problem" severity error;
      print_vector (av);
    end if;

    avr := (5, 6, 7);
    a   := diag (to_unsigned(avr));
    br := ((5, 0, 0),
           (0, 6, 0),
           (0, 0, 7));
    b := to_unsigned(br);
    if a /= b then
      report "diag(vector) problem" severity error;
      print_matrix (a);
    end if;

    a := blkdiag (to_unsigned(bvv));
    br := ((1, 0, 0),
           (0, 1, 0),
           (0, 0, 5));
    b := to_unsigned(br);
    if a /= b then
      report "blkdiag problem" severity error;
      print_matrix (a);
    end if;

    a := triu (to_unsigned(avm));
    cr := ((0, 2, 3),
           (0, 0, 6),
           (0, 0, 0));
    c := to_unsigned(cr);
    if a /= c then
      report "triu problem" severity error;
      print_matrix (a);
    end if;

    -- Matrix raised to a power.
    b := to_unsigned(avm)**2;
    cr := ((30, 36, 42),
           (66, 81, 96),
           (102, 126, 150));
    c := to_unsigned (cr);
    if b /= c then
      report "matrix ** 2 problem" severity error;
      print_matrix (b);
    end if;

    b := to_unsigned(avm)**1;
    if b /= to_unsigned(avm) then
      report "matrix ** 1 problem" severity error;
      print_matrix (b);
    end if;

    b := to_unsigned(avm)**3;
    cr := ((468, 576, 684),
           (1062, 1305, 1548),
           (1656, 2034, 2412));
    c := to_unsigned(cr);
    if b /= c then
      report "matrix ** 3 problem" severity error;
      print_matrix (b);
    end if;

    b := to_unsigned(avm)**0;
    c := ones(3, 3);
    if b /= c then
      report "matrix ** 0 problem" severity error;
      print_matrix (b);
    end if;

    tester_unsigned_done <= true;
    wait;
  end process tester_unsigned;

end architecture testbench;
