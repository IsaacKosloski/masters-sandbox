-------------------------------------------------------------------------------
-- Title      : testbench for Matrix Math package for type REAL
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_real_matrix.vhdl
-- Author     : David Bishop  <dbishop@vhdl.org>
-- Company    : 
-- Created    : 2010-04-15
-- Last update: 2011-01-20
-- Platform   : 
-- Standard   : VHDL'2008
-------------------------------------------------------------------------------
-- Description: Matrix math package testbench for type REAL
-------------------------------------------------------------------------------
-- Copyright (c) 2010 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2010-04-15  1.0      dbishop@vhdl.org Created
-------------------------------------------------------------------------------

--

entity test_complex_matrix is

end entity test_complex_matrix;

use std.textio.all;
library ieee;
use ieee.math_real.all;
use ieee.math_complex.all;
library ieee_proposed;
use ieee_proposed.real_matrix_pkg.all;
use ieee_proposed.complex_matrix_pkg.all;

architecture testbench of test_complex_matrix is

  signal submat_test : BOOLEAN := false;  -- start the test
  signal submat_done : BOOLEAN := false;  -- test done
  signal start_tstring  : BOOLEAN := false;  -- start string test
  signal tstring_done   : BOOLEAN := false;  -- test done
  signal start_ptstring : BOOLEAN := false;  -- start string test
  signal ptstring_done  : BOOLEAN := false;  -- test done

  subtype m3x3 is real_matrix (0 to 2, 0 to 2);  -- 3x3 matrix
  subtype a3 is real_vector (0 to 2);
begin

  -- purpose: apply stims
  tester : process is
    constant mones : real_matrix := ((1.0, 1.0, 1.0),
                                     (1.0, 1.0, 1.0),
                                     (1.0, 1.0, 1.0));       --matrix
    constant am : real_matrix := ((7.0, 3.0), (2.0, 5.0),
                                  (6.0, 8.0), (9.0, 0.0));
    constant bm : real_matrix := ((7.0, 4.0, 9.0), (8.0, 1.0, 5.0));
    constant ambmans : real_matrix := ((73.0, 31.0, 78.0),
                                       (54.0, 13.0, 43.0),
                                       (106.0, 32.0, 94.0),
                                       (63.0, 36.0, 81.0));  -- am * bm
    variable ambm      : complex_matrix (0 to 3, 0 to 2);    -- am * bm
    constant amv       : real_vector := (1.0, 4.0, 6.0);     -- real_vector
    constant bmv       : real_matrix := ((2.0, 3.0), (5.0, 8.0), (7.0, 9.0));
    constant amvbmvans : real_vector := (64.0, 89.0);
    variable amvbmv    : complex_vector (0 to 1);            -- amv * bmv
    constant avm : real_matrix := ((1.0, 2.0, 3.0),
                                   (4.0, 5.0, 6.0),
                                   (7.0, 8.0, 9.0));
    constant bvm        : real_vector := (3.0, 5.0, 7.0);
    variable avmm, bvmm : complex_matrix (0 to 2, 0 to 0);
    variable avmbvm     : complex_matrix (0 to 2, 0 to 0);   -- matrix * vector
    constant avmbvmans  : real_vector := (34.0, 79.0, 124.0);
    constant avv        : real_vector := (-1.0, -2.0);
    constant bvv        : real_vector := (-1.0, 1.0, 5.0);
    variable avvbvv     : complex_matrix (0 to 1, 0 to 2);   -- matrix
    -- vector * vector (assuming left is a column not a row)
    constant avvbvvans : real_matrix := ((1.0, -1.0, -5.0),
                                         (2.0, -2.0, -10.0));
    constant dtestx : real_matrix := ((3.0, 2.0, 0.0, 1.0),
                                      (4.0, 0.0, 1.0, 2.0),
                                      (3.0, 0.0, 2.0, 1.0),
                                      (9.0, 2.0, 3.0, 1.0));
    variable submatansm : real_matrix (0 to 1, 0 to 1);
    variable submatx, submatans : complex_matrix (0 to 1, 0 to 1);
    variable a2, b2, c2         : complex_matrix (0 to 1, 0 to 1);
    variable iv2                : integer_vector (0 to 1);   -- integer vector
    variable a, b, c, d         : m3x3;
    variable ac, bc, cc, dc     : complex_matrix (0 to 2, 0 to 2);
    variable av, bv, cv, dv     : a3;
    variable avc, bvc, cvc, dvc : complex_vector (0 to 2);
    variable av4, bv4           : complex_vector (0 to 3);
    variable m, n               : complex;
    variable i, j               : INTEGER;
    variable bool               : BOOLEAN;
  begin
    -- Basic test  Make sure the compare functions work.
    -- Test ones and Zeros functions
    a    := ones (3, 3);
    ac   := CMPLX(a);
    bool := (CMPLX(mones) = ac);
    if not bool then
      report "mones = ones(a)" severity error;
    end if;
    bool := (CMPLX(mones) /= ac);
    if bool then
      report "mones /= ones(a)" severity error;
    end if;
    b    := zeros (3, 3);
    ac   := CMPLX(b);
    bool := (CMPLX(mones) = ac);
    if bool then
      report "mones = zeros(a)" severity error;
    end if;
    bool := (CMPLX(mones) /= ac);
    if not bool then
      report "mones /= zeros(a)" severity error;
    end if;
    ac := CMPLX(a, b);
    if CMPLX(a) /= ac then
      report "CMPLX(X,Y) problem" severity error;
      print_matrix(ac);
    end if;
    -- Test multiply
    ambm := CMPLX(am) * CMPLX(bm);
    if ambm /= CMPLX(ambmans) then
      report "matrix multiply problem" severity error;
      print_matrix (ambm);
    end if;
    -- vector * matrix
    amvbmv := CMPLX(amv) * CMPLX(bmv);
    if amvbmv /= CMPLX(amvbmvans) then
      report "vector * matrix problem" severity error;
      print_vector (amvbmv);
      print_vector (amvbmvans);
    end if;
    -- Matrix * vector
    bvmm   := transpose (CMPLX(bvm));
    avmbvm := CMPLX(avm) * bvmm;
    if avmbvm /= reshape (CMPLX(avmbvmans), 3, 1) then
      report "matrix * vector problem" severity error;
      print_matrix (avmbvm);
      print_vector (avmbvmans);
    end if;
    -- vector * vector (assuming left is a column not a row)
--    avvbvv           := CMPLX(avv) * CMPLX(bvv);
--    -- This gives us a "-0" issue, so:
--    avvbvv (0, 0).IM := 0.0;
--    avvbvv (1, 0).IM := 0.0;
--    if avvbvv /= CMPLX(avvbvvans) then
--      report "vector * vector problem" severity error;
--      print_matrix (avvbvv, true);
--    end if;

    a  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    cc := CMPLX(a) * CMPLX(b);
    d  := ((30.0, 36.0, 42.0), (66.0, 81.0, 96.0), (102.0, 126.0, 150.0));
    if CMPLX(d) /= cc then
      report "matrix * matrix 3x3" severity error;
      print_matrix (cc, true);
      print_matrix (d, true);
    end if;

    a    := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    bv   := (2.0, 3.0, 4.0);
    bvmm := transpose (CMPLX(bv));
    avmm := CMPLX(a) * bvmm;
    dv   := (20.0, 47.0, 74.0);
    bvmm := reshape (CMPLX(dv), 3, 1);
    if avmm /= bvmm then
      report "matrix * vector problem" severity error;
      print_vector (cvc);
    end if;

    a   := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    bv  := (2.0, 3.0, 4.0);
    cvc := CMPLX(bv) * CMPLX(a);
    dv  := (42.0, 51.0, 60.0);
    if cvc /= CMPLX(dv) then
      report "vector * matrix problem" severity error;
      print_vector (cvc);
    end if;


--    av := (1.0, 2.0, 3.0);
--    bv := (4.0, 5.0, 6.0);
--    cc := CMPLX(av) * CMPLX(bv);
--    d  := ((4.0, 5.0, 6.0), (8.0, 10.0, 12.0), (12.0, 15.0, 18.0));
--    if cc /= CMPLX(d) then
--      report " vector * vector 3x3 problem" severity error;
--      print_matrix (cc);
--    end if;

    av  := (1.0, 2.0, 3.0);
    bv  := (4.0, 5.0, 6.0);
    cvc := CMPLX(av) + CMPLX(bv);
    dv  := (5.0, 7.0, 9.0);
    if cvc /= CMPLX(dv) then
      report " vector + vector problem" severity error;
      print_vector (cvc);
    end if;

    av  := (1.0, 2.0, 3.0);
    bv  := (4.0, 5.0, 6.0);
    cvc := CMPLX(av) - CMPLX(bv);
    dv  := (-3.0, -3.0, -3.0);
    if cvc /= CMPLX(dv) then
      report " vector - vector problem" severity error;
      print_vector (cvc);
    end if;
--    av := (1.0, 2.0, 3.0);
--    bv := (4.0, 5.0, 6.0);
--    av := times (av, bv);
--    bv := (4.0, 10.0, 18.0);
--    if av /= bv then
--      report " vector .* vector (times) problem" severity error;
--      print_vector (av);
--    end if;

--    avp := (1.0, 2.0, 3.0);
--    bvp := (4.0, 5.0, 6.0);
--    avp := times (avp, bvp);
--    bvp := (18.0, 10.0, 4.0);           -- reversed because of "downto"
--    if avp /= bvp then
--      report " vector .* vector (times) problem odd range" severity error;
--      print_vector (avp);
--    end if;

--    av := (1.0, 2.0, 3.0);
--    bv := (4.0, 5.0, 6.0);
--    av := rdivide (bv, av);
--    bv := (4.0, 2.5, 2.0);
--    if av /= bv then
--      report " vector ./ vector (rdivide) problem" severity error;
--      print_vector (av);
--    end if;

--        avp := (1.0, 2.0, 3.0);
--    bvp := (4.0, 5.0, 6.0);
--    avp := rdivide (bvp, avp);
--    bvp := (2.0, 2.5, 4.0);         -- reversed because of "downto"
--    if avp /= bvp then
--      report " vector ./ vector (rdivide) problem odd range" severity error;
--      print_vector (avp);
--    end if;

    -- Addition and subtraction
    a  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b  := transpose(a);
    cc := CMPLX(a) + CMPLX(b);
    d  := ((2.0, 6.0, 10.0), (6.0, 10.0, 14.0), (10.0, 14.0, 18.0));
    if CMPLX(d) /= cc then
      report "matrix + matrix problem" severity error;
      print_matrix (cc);
      print_matrix (d);
    end if;

    cc := CMPLX(a) - CMPLX(b);
    d  := ((0.0, -2.0, -4.0), (2.0, 0.0, -2.0), (4.0, 2.0, 0.0));
    if CMPLX(d) /= cc then
      report "matrix - matrix problem" severity error;
      print_matrix (cc);
      print_matrix (d);
    end if;

    -- element by element multiply
    a  := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    ac := CMPLX(a);
    bc  := transpose(ac);
    cc := times(ac, bc);
    d := ((1.0, 8.0, 21.0), (8.0, 25.0, 48.0), (21.0, 48.0, 81.0));
    dc := CMPLX(d);
    if dc /= cc then
      report "times(matrix, matrix) problem" severity error;
      print_matrix (cc);
      print_matrix (dc);
    end if;
--    cp := times (ap, bp);
--    d  := ((1.0, 8.0, 21.0), (8.0, 25.0, 48.0), (21.0, 48.0, 81.0));
--    if d /= reorder(cp) then
--      report "times(matrix, matrix) problem odd range" severity error;
--      print_matrix (cp);
--      print_matrix (d);
--    end if;
    -- element by element divide
    cc := rdivide (ac, bc);
    d := ((1.0, 0.5, 3.0/7.0), (2.0, 1.0, 6.0/8.0), (7.0/3.0, 8.0/6.0, 1.0));
    dc := CMPLX(d);
    if dc /= cc then
      report "rdivide(matrix, matrix) problem" severity error;
      print_matrix (cc);
      print_matrix (dc);
    end if;
--    cp := rdivide (ap, bp);
--    d  := ((1.0, 0.5, 3.0/7.0), (2.0, 1.0, 6.0/8.0), (7.0/3.0, 8.0/6.0, 1.0));
--    if d /= reorder(cp) then
--      report "rdivide(matrix, matrix) problem odd range" severity error;
--      print_matrix (cp);
--      print_matrix (d);
--    end if;

    -- SubMatrix test
    a         := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    ac := CMPLX(a);
    submatx   := exclude(ac, 1, 1);
    submatansm := ((1.0, 3.0), (7.0, 9.0));
    submatans := CMPLX(submatansm);
    if submatx /= submatans then
      report "exclude(1,1) problem" severity error;
      print_matrix (submatx);
    end if;
    submatx   := exclude (ac, 2, 0);
    submatansm := ((2.0, 3.0), (5.0, 6.0));
    submatans := CMPLX(submatansm);
    if submatx /= submatans then
      report "exclude(2,0) problem" severity error;
      print_matrix (submatx);
    end if;
    submatx   := exclude (ac, 0, 2);
    submatansm := ((4.0, 5.0), (7.0, 8.0));
    submatans := CMPLX(submatansm);
    if submatx /= submatans then
      report "exclude(0,2) problem" severity error;
      print_matrix (submatx);
    end if;
--    ap        := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
--    submatx   := submat (ap, 7, 4);
--    submatans := ((5.0, 4.0), (2.0, 1.0));
--    if submatx /= submatans then
--      report "SubMatrix(7,4) odd range problem" severity error;
--      print_matrix (submatx);
--    end if;

    -- Determinant test
    submatansm := ((1.0, 2.0), (4.0, 3.0));
    submatx := CMPLX (submatansm);
    m       := det (submatx);
    if m /= CMPLX(-5.0) then
      report "Determinant -5 /= "& to_string(m) severity error;
      print_matrix(submatx);
    end if;
    submatansm := ((3.0, 2.0), (5.0, 2.0));
    submatx := CMPLX (submatansm);
    m       := det (submatx);
    if m /= CMPLX(-4.0) then
      report "Determinant -4 /= "& to_string(m) severity error;
      print_matrix(submatx);
    end if;
    a := ((1.0, 3.0, 2.0), (4.0, 1.0, 3.0), (2.0, 5.0, 2.0));
    ac := CMPLX(a);
    m := det (ac);
    if m /= CMPLX(17.0) then
      report "Determinant 17 /= "& to_string(m) severity error;
      print_matrix(a);
    end if;
--    ap := ((1.0, 3.0, 2.0), (4.0, 1.0, 3.0), (2.0, 5.0, 2.0));
--    m  := det (ap);
--    if m /= 17.0 then
--      report "Determinant odd range 17 /= "& REAL'image(m) severity error;
--      print_matrix(ap);
--    end if;
    -- Try a larger matrix
    m := det (CMPLX(dtestx));                  -- 4x4 matrix
    if m /= CMPLX(24.0) then
      report "Determinant 24 /= "& to_string(m) severity error;
      print_matrix(dtestx);
    end if;

    -- Invert a matrix
    a := ((1.0, 3.0, 2.0), (4.0, 1.0, 3.0), (2.0, 5.0, 2.0));
    ac := CMPLX(a);
    cc := inv(ac);
    d := ((-13.0/17.0, 4.0/17.0, 7.0/17.0),
          (-2.0/17.0, -2.0/17.0, 5.0/17.0),
          (18.0/17.0, 1.0/17.0, -11.0/17.0));
    dc := CMPLX(d);
    if cc /= dc then
      report "Invert problem " severity error;
      print_matrix(cc, true);
      print_matrix(dc, true);
    end if;

    -- dot product
    m := dot (CMPLX(amv), CMPLX(bvm));
    assert m = CMPLX(65.0)
      report "Dot product problem, expected 65, and got " & to_string(m)
      severity error;
    m := dot (CMPLX(amv), CMPLX(bvv));
    assert m = CMPLX(33.0)
      report "Dot product problem, expected 33, and got " & to_string(m)
      severity error;

    -- Test sum and trace
    m := sum (CMPLX(amv));
    if m /= CMPLX(11.0) then
      report "sum (vector) problem, result was " & to_string(m)
        severity error;
    end if;

    m := trace (CMPLX(ambmans));
    if m /= CMPLX(180.0) then
            report "trace problem, result was " & to_string(m)
        severity error;
    end if;

        m := trace (CMPLX(am));
    if m /= CMPLX(12.0) then
            report "trace (2) problem, result was " & to_string(m)
        severity error;
    end if;

    avc := sum (CMPLX(ambmans), 1);              -- Sum along Y
    bv := (296.0, 112.0, 296.0);
    bvc := CMPLX(bv);
    if avc /= bvc then
      report "Sum (x,2) problem" severity error;
      print_vector (avc);
    end if;

        av4 := sum (CMPLX(ambmans), 2);              -- Sum along X
    bv4 := CMPLX((182.0, 110.0, 232.0, 180.0));
    if av4 /= bv4 then
      report "Sum (x,1) problem" severity error;
      print_vector (av4);
    end if;

    av := (8.0, 1.0, 6.0);
    avc := CMPLX(av);
    m := prod (avc);
    if m /= CMPLX(48.0) then
      report "prod (vector) problem "& to_string(m) severity error;
    end if;

    a := ((8.0, 1.0, 6.0),
          (3.0, 5.0, 7.0),
          (4.0, 9.0, 2.0));
    ac := CMPLX(a);
    avc := prod(ac);
    bv := (96.0, 45.0, 84.0);
    bvc := CMPLX(bv);
    if avc /= bvc then
      report "prod(1) problem" severity error;
      print_vector (avc);
    end if;
        avc := prod(ac,2);
    bv := (48.0,105.0, 72.0);
    bvc := CMPLX(bv);
    if avc /= bvc then
      report "prod(2) problem" severity error;
      print_vector (avc);
    end if;


    -- Flip a few Matrices...
    bc := fliplr (CMPLX(avm));
    c := ((3.0, 2.0, 1.0),
          (6.0, 5.0, 4.0),
          (9.0, 8.0, 7.0));
    cc := CMPLX(c);
    if bc /= cc then
      report "Fliplr problem " severity error;
      print_matrix (bc);
    end if;

    bc := flipdim (CMPLX(avm), 2);
    c := ((3.0, 2.0, 1.0),
          (6.0, 5.0, 4.0),
          (9.0, 8.0, 7.0));
    cc := CMPLX(c);
    if bc /= cc then
      report "Flipdim 2 problem " severity error;
      print_matrix (bc);
    end if;


    bc := flipup (CMPLX(avm));
    c := ((7.0, 8.0, 9.0),
          (4.0, 5.0, 6.0),
          (1.0, 2.0, 3.0));
    cc := CMPLX(c);
    if bc /= cc then
      report "Flipup problem " severity error;
      print_matrix (bc);
    end if;

    bc := flipdim (CMPLX(avm), 1);
    c := ((7.0, 8.0, 9.0),
          (4.0, 5.0, 6.0),
          (1.0, 2.0, 3.0));
    cc := CMPLX(c);
    if bc /= cc then
      report "Flipdim 1 problem " severity error;
      print_matrix (bc);
    end if;


    bc := rot90 (CMPLX(avm));
    c := ((3.0, 6.0, 9.0),
          (2.0, 5.0, 8.0),
          (1.0, 4.0, 7.0));
    cc := CMPLX(c);
    if bc /= cc then
      report "rot90 problem " severity error;
      print_matrix (bc);
    end if;

    bc := rot90 (CMPLX(avm), 2);
    c := ((9.0, 8.0, 7.0),
          (6.0, 5.0, 4.0),
          (3.0, 2.0, 1.0));
    cc := CMPLX(c);
    if bc /= cc then
      report "rot90 2 problem " severity error;
      print_matrix (bc);
    end if;

    bc := rot90 (CMPLX(avm), 3);
    c := ((7.0, 4.0, 1.0),
          (8.0, 5.0, 2.0),
          (9.0, 6.0, 3.0));
    cc := CMPLX(c);
    if bc /= cc then
      report "rot90 3 problem " severity error;
      print_matrix (bc);
    end if;

    ac := tril(CMPLX(avm));
    c := ((0.0, 0.0, 0.0),
          (4.0, 0.0, 0.0),
          (7.0, 8.0, 0.0));
    cc := CMPLX(c);
    if ac /= cc then
      report "tril problem" severity error;
      print_matrix (ac);
    end if;

    avc := diag (CMPLX(avm));
    bv := (1.0, 5.0, 9.0);
    bvc := CMPLX(bv);
    if avc /= bvc then
      report "diag problem" severity error;
      print_vector (avc);
    end if;

    av := (5.0, 6.0, 7.0);
    ac  := diag (CMPLX(av));
    b := ((5.0, 0.0, 0.0),
          (0.0, 6.0, 0.0),
          (0.0, 0.0, 7.0));
    bc := CMPLX(b);
    if ac /= bc then
      report "diag(vector) problem" severity error;
      print_matrix (ac);
    end if;

    ac := blkdiag (CMPLX(bvv));
    b := ((-1.0, 0.0, 0.0),
          (0.0, 1.0, 0.0),
          (0.0, 0.0, 5.0));
    bc := CMPLX(b);
    if ac /= bc then
      report "blkdiag problem" severity error;
      print_matrix (ac);
    end if;

    ac := triu (CMPLX(avm));
    c := ((0.0, 2.0, 3.0),
          (0.0, 0.0, 6.0),
          (0.0, 0.0, 0.0));
    cc := CMPLX(c);
    if ac /= cc then
      report "triu problem" severity error;
      print_matrix (ac);
    end if;
    av := (1.0, 2.0, 3.0);
    bv := (4.0, 5.0, 6.0);
    cvc := cross (CMPLX(av), CMPLX(bv));
    dv := (-3.0, 6.0, -3.0);
    dvc := CMPLX(dv);
    if cvc /= dvc then
      report "Cross product problem" severity error;
      print_vector (cvc);
    end if;
    ac := CMPLX(avm);
    bc := rot90(CMPLX(avm), 2);
    cc := cross (ac, bc);
    d := ((-30.0, -30.0, -30.0),
          (60.0, 60.0, 60.0),
          (-30.0, -30.0, -30.0));
    dc := CMPLX(d);
    if cc /= dc then
      report "Cross product (matrix) problem" severity error;
      print_matrix (cc);
    end if;

    a := ((1.0, 1.0, -1.0),
          (2.0, -1.0, 1.0),
          (-1.0, 2.0, 2.0));
    av := (-2.0, 5.0, 1.0);
    bvc := linsolve (CMPLX(a), CMPLX(av));
    cv := (1.0, -1.0, 2.0);
    cvc := CMPLX(cv);
    if bvc /= cvc then
      report "Linsolve problem" severity error;
      print_vector (bvc);
    end if;

    a := ((3.0, 2.0, -1.0),
          (2.0, -2.0, 4.0),
          (-1.0, 0.5, -1.0));
    av := (1.0, -2.0, 0.0);
    bvc := linsolve (CMPLX(a), CMPLX(av));
    -- Because of the "3", this answer needs rounding
    for i in bvc'range loop
      bvc(i).RE := round(bvc(i).RE);
    end loop;
    cv := (1.0, -2.0, -2.0);
    cvc := CMPLX(cv);
    if bvc /= cvc then
      report "Linsolve problem 2" severity error;
      print_vector (bvc);
    end if;

    a := ((2.0, 2.0, -1.0),
          (2.0, -2.0, -4.0),
          (-1.0, 0.5, -1.0));
    bc := normalize (CMPLX(a));
    c := ((0.5, 0.5, -0.25),
          (0.5, -0.5, -1.0),
          (-0.25, 0.125, -0.25));
    cc := CMPLX(c);
    if bc /= cc then
      report "Normalization error" severity error;
      print_matrix (bc);
    end if;

    av := (1.0, 2.0, -4.0);
    bvc := normalize (CMPLX(av));
    cv := (0.25, 0.5, -1.0);
    cvc := CMPLX(cv);
    if bvc /= cvc then
      report "Normalization vector error" severity error;
      print_vector (bvc);
    end if;

--    av := (1.0, 2.0, 3.0);              -- 3*x^2 + 2*x + 1
--    bv := (5.0, 7.0, 9.0);
--    cv := polyval (av, bv);
--    dv := (86.0, 162.0, 262.0);
--    if cv /= dv then
--      report "Polyval problem" severity error;
--      print_vector (cv);
--    end if;

    -- Matrix raised to a power.
    bc := CMPLX(avm)**2;
    c := ((30.0, 36.0, 42.0),
          (66.0, 81.0, 96.0),
          (102.0, 126.0, 150.0));
    if bc /= CMPLX(c) then
      report "matrix ** 2 problem" severity error;
      print_matrix (bc);
    end if;

    bc := CMPLX(avm)**1;
    if bc /= CMPLX(avm) then
      report "matrix ** 1 problem" severity error;
      print_matrix (bc);
    end if;

    bc := CMPLX(avm)**3;
    c := ((468.0, 576.0, 684.0),
          (1062.0, 1305.0, 1548.0),
          (1656.0, 2034.0, 2412.0));
    if bc /= CMPLX(c) then
      report "matrix ** 3 problem" severity error;
      print_matrix (bc);
    end if;

    bc := CMPLX(avm)**4;
    c := ((7560.0, 9288.0, 11016.0),
          (17118.0, 21033.0, 24948.0),
          (26676.0, 32778.0, 38880.0));
    if bc /= CMPLX(c) then
      report "matrix ** 4 problem" severity error;
      print_matrix (bc);
    end if;

    bc := CMPLX(avm)**5;
    c := ((121824.0, 149688.0, 177552.0),
          (275886.0, 338985.0, 402084.0),
          (429948.0, 528282.0, 626616.0));
    if bc /= CMPLX(c) then
      report "matrix ** 5 problem" severity error;
      print_matrix (bc);
    end if;

    bc := CMPLX(avm)**0;
    c  := ones(3, 3);
    if bc /= CMPLX(c) then
      report "matrix ** 0 problem" severity error;
      print_matrix (bc);
    end if;

    -- The "1,2,3" matrix does not scale well.
    a := ((1.0, 3.0, 2.0), (4.0, 1.0, 3.0), (2.0, 5.0, 2.0));
    ac := CMPLX(a);
    bc := ac**(-1);
    cc := inv(ac);
    if bc /= cc then
      report "matrix ** -1 problem" severity error;
      print_matrix (bc);
      print_matrix (cc);
    end if;

    av  := (4.0, 25.0, 81.0);
    bvc := sqrt (CMPLX(av));
    cv  := (2.0, 5.0, 9.0);
    if bvc /= CMPLX(cv) then
      report "sqrt(vector) problem" severity error;
      print_vector (bvc);
    end if;

    a := ((81.0, 64.0, 49.0),
          (36.0, 25.0, 16.0),
          (9.0, 4.0, 1.0));
    bc := sqrt(CMPLX(a));
    c := ((9.0, 8.0, 7.0),
          (6.0, 5.0, 4.0),
          (3.0, 2.0, 1.0));
    if bc /= CMPLX(c) then
      report "sqrt (matrix) problem" severity error;
      print_matrix (bc);
    end if;

    -- Complex Conjunction Transpose of a matrix
    a2 := (((3.0, 1.0), (5.0, 0.0)), ((2.0, -2.0), (0.0, 1.0)));
    b2 := ctranspose (a2);
    c2 := (((3.0, -1.0), (2.0, 2.0)), ((5.0, -0.0), (0.0, -1.0)));
    if b2 /= c2 then
      report "ctranspose problem " severity error;
      print_matrix (b2);
    end if;

--    -- Random matrix
--    a      := rand (3, 3);
--    --    print_matrix(a);
--    b      := rand (3, 3);
--    --    print_matrix(b);
--    avvbvv := rand (2, 3);
--    --    print_matrix(avvbvv);

    submat_test <= true;
    wait until submat_done;
    -- String test
    start_tstring  <= true;
    wait until tstring_done;
    start_ptstring <= true;
    wait until ptstring_done;

    report "test_complex_matrix completed" severity note;
    wait;
  end process tester;

  submattst : process is
    constant avm : real_matrix := ((1.0, 2.0, 3.0),
                                   (4.0, 5.0, 6.0),
                                   (7.0, 8.0, 9.0));
    variable a, b, c       : real_matrix (0 to 8, 0 to 8);
    variable ac, bc, cc    : complex_matrix (0 to 8, 0 to 8);
    variable a3, b3        : real_matrix (0 to 2, 0 to 2);
    variable a3c, b3c      : complex_matrix (0 to 2, 0 to 2);
    variable a4, b4, c4    : real_matrix (0 to 3, 0 to 3);
    variable a4c, b4c, c4c : complex_matrix (0 to 3, 0 to 3);
    variable a2, b2        : real_matrix (0 to 1, 0 to 1);
    variable a2c, b2c      : complex_matrix (0 to 1, 0 to 1);
    variable av, bv        : real_vector (0 to 2);
    variable avmm, bvmm    : complex_matrix (0 to 2, 0 to 0);
    variable avc, bvc      : complex_vector (0 to 2);
    variable av4, bv4      : real_vector (0 to 3);
    variable av4c, bv4c    : complex_vector (0 to 3);
    variable a13           : complex_matrix (0 to 2, 5 to 5);  -- 1D matrix
    variable a31           : complex_matrix (5 to 5, 0 to 2);  -- 1D matrix
  begin
    wait until submat_test;
    ac := repmat (CMPLX(avm), 3, 3);
    b := ((1.0, 2.0, 3.0, 1.0, 2.0, 3.0, 1.0, 2.0, 3.0),
          (4.0, 5.0, 6.0, 4.0, 5.0, 6.0, 4.0, 5.0, 6.0),
          (7.0, 8.0, 9.0, 7.0, 8.0, 9.0, 7.0, 8.0, 9.0),
          (1.0, 2.0, 3.0, 1.0, 2.0, 3.0, 1.0, 2.0, 3.0),
          (4.0, 5.0, 6.0, 4.0, 5.0, 6.0, 4.0, 5.0, 6.0),
          (7.0, 8.0, 9.0, 7.0, 8.0, 9.0, 7.0, 8.0, 9.0),
          (1.0, 2.0, 3.0, 1.0, 2.0, 3.0, 1.0, 2.0, 3.0),
          (4.0, 5.0, 6.0, 4.0, 5.0, 6.0, 4.0, 5.0, 6.0),
          (7.0, 8.0, 9.0, 7.0, 8.0, 9.0, 7.0, 8.0, 9.0));
    bc := CMPLX(b);
    if ac /= bc then
      report "repmat problem" severity error;
      print_matrix (ac);
    end if;
    ac := blockdiag (CMPLX(avm), 3);
    b := ((1.0, 2.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
          (4.0, 5.0, 6.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
          (7.0, 8.0, 9.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
          (0.0, 0.0, 0.0, 1.0, 2.0, 3.0, 0.0, 0.0, 0.0),
          (0.0, 0.0, 0.0, 4.0, 5.0, 6.0, 0.0, 0.0, 0.0),
          (0.0, 0.0, 0.0, 7.0, 8.0, 9.0, 0.0, 0.0, 0.0),
          (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 2.0, 3.0),
          (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 5.0, 6.0),
          (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 7.0, 8.0, 9.0));
    bc := CMPLX(b);
    if ac /= bc then
      report "blockdiag problem" severity error;
      print_matrix (ac);
    end if;
    a3c := SubMatrix (CMPLX(b), 2, 2, 3, 3);  -- return a 3x3 matrix from x=2, y=2
    b3 := ((9.0, 0.0, 0.0),
           (0.0, 1.0, 2.0),
           (0.0, 4.0, 5.0));
    if a3c /= CMPLX(b3) then
      report "SubMatrix problem" severity error;
      print_matrix (a3c);
    end if;
    bc := CMPLX(b);
    BuildMatrix (CMPLX(avm), bc, 6, 2);       -- Put matrix avm at x=6, y=2
    a := ((1.0, 2.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
          (4.0, 5.0, 6.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
          (7.0, 8.0, 9.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
          (0.0, 0.0, 0.0, 1.0, 2.0, 3.0, 0.0, 0.0, 0.0),
          (0.0, 0.0, 0.0, 4.0, 5.0, 6.0, 0.0, 0.0, 0.0),
          (0.0, 0.0, 0.0, 7.0, 8.0, 9.0, 0.0, 0.0, 0.0),
          (0.0, 0.0, 1.0, 2.0, 3.0, 0.0, 1.0, 2.0, 3.0),
          (0.0, 0.0, 4.0, 5.0, 6.0, 0.0, 4.0, 5.0, 6.0),
          (0.0, 0.0, 7.0, 8.0, 9.0, 0.0, 7.0, 8.0, 9.0));
    if CMPLX(a) /= bc then
      report "BuildMatrix problem" severity error;
      print_matrix (bc);
    end if;
    a3c  := CMPLX(avm);
    avmm := SubMatrix (a3c, 0, 1, av'length, 1);  -- return column 1
    bv   := (2.0, 5.0, 8.0);
    bvmm := reshape (CMPLX(bv), 3, 1);
    if avmm /= bvmm then
      report "SubMatrix column 1" severity error;
      print_matrix (avmm);
    end if;
    avc := SubMatrix (a3c, 1, 0, 1, av'length);   -- return row 1
    bv  := (4.0, 5.0, 6.0);
    if avc /= CMPLX(bv) then
      report "SubMatrix row 1" severity error;
      print_vector (avc);
    end if;
    a4 := ((1.0, 2.0, 3.0, 4.0),
           (5.0, 6.0, 7.0, 8.0),
           (9.0, 10.0, 11.0, 12.0),
           (13.0, 14.0, 15.0, 16.0));
    a2c := SubMatrix (CMPLX(a4), 1, 1, 2, 2);
    b2  := ((6.0, 7.0), (10.0, 11.0));
    if a2c /= CMPLX(b2) then
      report "SubMatrix (A, 1,1,2,2) issue " severity error;
      print_matrix (a2c);
    end if;
    avc := SubMatrix (CMPLX(a4), 1, 0, 1, 3);
    bv  := (5.0, 6.0, 7.0);
    if avc /= CMPLX(bv) then
      report "SubMatrix (a4, 1,0, 1, 3) issue" severity error;
      print_vector (avc);
    end if;

    -- Play with SubMatrix a bit
    a2  := ((7.0, 2.0), (3.0, 4.0));
    a4  := ones (a4'length(1), a4'length(2));
    a4c := CMPLX(a4);
    BuildMatrix (CMPLX(a2), a4c, 1, 1);
    b4 := ((1.0, 1.0, 1.0, 1.0),
           (1.0, 7.0, 2.0, 1.0),
           (1.0, 3.0, 4.0, 1.0),
           (1.0, 1.0, 1.0, 1.0));
    if a4c /= CMPLX(b4) then
      report "BuildMatrix problem" severity error;
      print_matrix (a4c);
    end if;

    -- Example for BuildMatrix(vector) and InsertColumn
    a4   := ones (a4'length(1), a4'length(2));
    a4c  := CMPLX(a4);
    av4  := (5.0, 6.0, 7.0, 8.0);
    av4c := CMPLX(av4);
    bv4  := (10.0, 11.0, 12.0, 13.0);
    bv4c := CMPLX(bv4);
    BuildMatrix (av4c, a4c, 2, 0);
    InsertColumn (bv4c, a4c, 0, 2);
    b4 := ((1.0, 1.0, 10.0, 1.0),
           (1.0, 1.0, 11.0, 1.0),
           (5.0, 6.0, 12.0, 8.0),
           (1.0, 1.0, 13.0, 1.0));
    if a4c /= CMPLX(b4) then
      report "BuildMatrix problem" severity error;
      print_matrix (a4c);
    end if;


    -- Do some matrix = vector boolean test
    bv  := (5.0, 6.0, 7.0);
    bvc := CMPLX(bv);
--    a13 (0, 5) := COMPLEX'(5.0, 0.0);
--    a13 (1, 5) := (6.0, 0.0);
--    a13 (2, 5) := (7.0, 0.0);
--    if a13 = bvc then
--      null;
--    else
--      report "matrix = vector problem" severity error;
--    end if;
--    if bvc = a13 then
--      null;
--    else
--      report "vector = matrix problem" severity error;
--    end if;
--    if a13 /= bvc then
--      report "matrix /= vector problem" severity error;
--    end if;
--    if bvc /= a13 then
--      report "vector /= matrix problem" severity error;
--    end if;
--    a13 (2, 5) := (9.0, 0.0);
--    if a13 = bvc then
--      report "matrix = vector (false) problem" severity error;
--    end if;
--    if bvc = a13 then
--      report "vector = matrix (false) problem" severity error;
--    end if;
--    if a13 /= bvc then
--      null;
--    else
--      report "matrix /= vector (false) problem" severity error;
--    end if;
--    if bvc /= a13 then
--      null;
--    else
--      report "vector /= matrix (false) problem" severity error;
--    end if;

    a31 (5, 0) := (5.0, 0.0);
    a31 (5, 1) := (6.0, 0.0);
    a31 (5, 2) := (7.0, 0.0);
    if a31 = bvc then
      null;
    else
      report "matrix(1:3) = vector problem" severity error;
    end if;
    if bvc = a31 then
      null;
    else
      report "vector = matrix(1:3) problem" severity error;
    end if;
    if a31 /= bvc then
      report "matrix(1:3) /= vector problem" severity error;
    end if;
    if bvc /= a31 then
      report "vector /= matrix(1:3) problem" severity error;
    end if;
    a31 (5, 1) := (5.0, 0.0);
    if a31 = bvc then
      report "matrix(1:3) = vector (false) problem" severity error;
    end if;
    if bvc = a31 then
      report "vector = matrix(1:3) (false) problem" severity error;
    end if;
    if a31 /= bvc then
      null;
    else
      report "matrix(1:3) /= vector (false) problem" severity error;
    end if;
    if bvc /= a31 then
      null;
    else
      report "vector /= matrix(1:3) (false) problem" severity error;
    end if;
    if a4c = bvc then
      report "4x4 = 3 compare problem" severity error;
    end if;
    if bvc = a4c then
      report "3 = 4x4 compare problem" severity error;
    end if;
    if a4c /= bvc then
      null;
    else
      report "4x4 /= 3 compare problem" severity error;
    end if;
    if bvc /= a4c then
      null;
    else
      report "3 /= 4x4 compare problem" severity error;
    end if;


    submat_done <= true;
    wait;
  end process;

    -- purpose: test the string functions
  test_strings : process is
    variable a, b, c    : complex_matrix (0 to 2, 0 to 2);  -- complex matrix
    variable am, bm, cm : real_matrix (0 to 2, 0 to 2);  -- real matrix
    variable av, bv, cv : complex_vector (0 to 2);          -- complex vector
    variable avr, bvr, cvr : real_vector (0 to 2);          -- real vector
    variable m, n : complex;
    variable l          : LINE;                          -- line variable
    variable good       : BOOLEAN;                       -- for reads
  begin
    wait until start_tstring;
    l := new string'("1.0, 1.0i");
    read (l, m);
    n := (1.0, 1.0);
    if m /= n then
      report "read (complex) problem " & to_string (m) severity error;
    end if;
    deallocate (L);
    l := new string'("1.0, 1.0i");
    read (l, m, good);
    n := (1.0, 1.0);
    if m /= n or not good then
      report "read (complex, bool) problem " & boolean'image(good) & " " & to_string (m) severity error;
    end if;
    deallocate (L);
    l  := new STRING'("1.0 0.0 2.0 0.0 3.0 0.0");
    read (l, av);
    bvr := (1.0, 2.0, 3.0);
    bv := CMPLX (bvr);
    if av /= bv then
      report "complex vector Read no boolean" severity error;
      print_vector (av);
    end if;
    deallocate (L);
    bv := ((1.0, 0.0), (2.0, 0.0), (3.0, 0.0));
    write (L, to_string(bv));
    read (l, av);
    if av /= bv then
      report "complex vector to_string/Read no BOOLEAN " severity error;
      writeline (output, L);
      print_vector (av);
    end if;
    deallocate (L);
    bv := ((1.0, 0.0), (2.0, 0.0), (3.0, 0.0));
    write (L, bv);
    read (l, av);
    if av /= bv then
      report "complex vector write/Read no BOOLEAN " severity error;
      writeline (output, L);
      print_vector (av);
    end if;
    deallocate (L);
    bv := ((1.0, 0.0), (2.0, 0.0), (3.0, 0.0));
    write (L, bv);
    read (l, av, good);
    if av /= bv or not good then
      report "complex vector write/Read good = " & BOOLEAN'image(good)
        severity error;
      writeline (output, L);
      print_vector (av);
    end if;
    deallocate (L);
    l := new STRING'("1.0 x.0 3.0");
    read (l, av, good);
    if good then
      report "complex vector Read good = " & BOOLEAN'image(good)
        severity error;
      print_vector (av);
    end if;
    deallocate (L);

    -- Complex matrix test
    l := new STRING'("1.0 0.0 2.0 0.0 3.0 0.0 4.0 0.0 5.0 0.0 6.0 0.0 7.0 0.0 8.0 0.0 9.0 0.0 ");
    read (L, a);
    bm := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b := CMPLX(bm);
    if a /= b then
      report "complex matrix Read no BOOLEAN " severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    l := new STRING'("(((1.0, 0.0), (2.0, 0.0), (3.0, 0.0)), ((4.0, 0.0), (5.0, 0.0), (6.0, 0.0)), (7.0, 0.0), (8.0, 0.0), (9.0, 0.0)))");
    read (L, a);
    bm := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b := CMPLX(bm);
    if a /= b then
      report "complex matrix Read no BOOLEAN " severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    bm := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b := CMPLX(bm);
    write (L, to_string(b));
    read (L, a);
    if a /= b then
      report "complex matrix to_string/Read no BOOLEAN " severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    bm := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b := CMPLX(bm);
    write (L, b);
    read (L, a);
    if a /= b then
      report "complex matrix write/Read no BOOLEAN " severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    bm := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b := CMPLX(bm);
    write (L, b);
    read (l, a, good);
    if a /= b or not good then
      report "complex matrix write/Read good = " & BOOLEAN'image(good)
        severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    -- Some bad reads
    l := new STRING'("1.0 0.0 2.0 0.0 3.0 0.0 4.0 x.0 5.0 0.0 6.0 0.0 7.0 0.0 8.0 0.0 9.0 0.0 ");
    read (l, a, good);
    if good then
      report "complex matrix Read good = " & BOOLEAN'image(good)
        severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    l := new STRING'("1.0 x.0 3.0");
    read (l, a, good);
    if good then
      report "complex matrix Read good = " & BOOLEAN'image(good)
        severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);

    tstring_done <= true;
    wait;
  end process test_strings;

     -- purpose: test the string functions
  test_pstrings : process is
    variable a, b, c    : complex_polar_matrix (0 to 2, 0 to 2);  -- complex matrix
    variable am, bm, cm : real_matrix (0 to 2, 0 to 2);  -- real matrix
    variable av, bv, cv : complex_polar_vector (0 to 2);          -- complex vector
    variable avr, bvr, cvr : real_vector (0 to 2);          -- real vector
    variable m, n : complex_polar;
    variable l          : LINE;                          -- line variable
    variable good       : BOOLEAN;                       -- for reads
  begin
    wait until start_ptstring;
    l := new string'("1.0, 1.0j");
    read (l, m);
    n := (1.0, 1.0);
    if m /= n then
      report "read (complex) problem " & to_string (m) severity error;
    end if;
    deallocate (L);
    l := new string'("1.0, 1.0j");
    read (l, m, good);
    n := (1.0, 1.0);
    if m /= n or not good then
      report "read (complex, bool) problem " & boolean'image(good) & " " & to_string (m) severity error;
    end if;
    deallocate (L);
    l  := new STRING'("1.0 0.0 2.0 0.0 3.0 0.0");
    read (l, av);
    bvr := (1.0, 2.0, 3.0);
    bv := COMPLEX_TO_POLAR(CMPLX (bvr));
    if av /= bv then
      report "complex vector Read no boolean" severity error;
      print_vector (av);
    end if;
    deallocate (L);
    bv := ((1.0, 0.0), (2.0, 0.0), (3.0, 0.0));
    write (L, to_string(bv));
    read (l, av);
    if av /= bv then
      report "complex vector to_string/Read no BOOLEAN " severity error;
      writeline (output, L);
      print_vector (av);
    end if;
    deallocate (L);
    bv := ((1.0, 0.0), (2.0, 0.0), (3.0, 0.0));
    write (L, bv);
    read (l, av);
    if av /= bv then
      report "complex vector write/Read no BOOLEAN " severity error;
      writeline (output, L);
      print_vector (av);
    end if;
    deallocate (L);
    bv := ((1.0, 0.0), (2.0, 0.0), (3.0, 0.0));
    write (L, bv);
    read (l, av, good);
    if av /= bv or not good then
      report "complex vector write/Read good = " & BOOLEAN'image(good)
        severity error;
      writeline (output, L);
      print_vector (av);
    end if;
    deallocate (L);
    l := new STRING'("1.0 x.0 3.0");
    read (l, av, good);
    if good then
      report "complex vector Read good = " & BOOLEAN'image(good)
        severity error;
      print_vector (av);
    end if;
    deallocate (L);

    -- Complex matrix test
    l := new STRING'("1.0 0.0 2.0 0.0 3.0 0.0 4.0 0.0 5.0 0.0 6.0 0.0 7.0 0.0 8.0 0.0 9.0 0.0 ");
    read (L, a);
    bm := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b := COMPLEX_TO_POLAR(CMPLX(bm));
    if a /= b then
      report "complex matrix Read no BOOLEAN " severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    l := new STRING'("(((1.0, 0.0), (2.0, 0.0), (3.0, 0.0)), ((4.0, 0.0), (5.0, 0.0), (6.0, 0.0)), (7.0, 0.0), (8.0, 0.0), (9.0, 0.0)))");
    read (L, a);
    bm := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b := COMPLEX_TO_POLAR(CMPLX(bm));
    if a /= b then
      report "complex matrix Read no BOOLEAN " severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    bm := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b := COMPLEX_TO_POLAR(CMPLX(bm));
    write (L, to_string(b));
    read (L, a);
    if a /= b then
      report "complex matrix to_string/Read no BOOLEAN " severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    bm := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b := COMPLEX_TO_POLAR(CMPLX(bm));
    write (L, b);
    read (L, a);
    if a /= b then
      report "complex matrix write/Read no BOOLEAN " severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    bm := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0), (7.0, 8.0, 9.0));
    b := COMPLEX_TO_POLAR(CMPLX(bm));
    write (L, b);
    read (l, a, good);
    if a /= b or not good then
      report "complex matrix write/Read good = " & BOOLEAN'image(good)
        severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    -- Some bad reads
    l := new STRING'("1.0 0.0 2.0 0.0 3.0 0.0 4.0 x.0 5.0 0.0 6.0 0.0 7.0 0.0 8.0 0.0 9.0 0.0 ");
    read (l, a, good);
    if good then
      report "complex matrix Read good = " & BOOLEAN'image(good)
        severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    l := new STRING'("1.0 x.0 3.0");
    read (l, a, good);
    if good then
      report "complex matrix Read good = " & BOOLEAN'image(good)
        severity error;
      writeline (output, L);
      print_matrix (a);
    end if;
    deallocate (L);
    ptstring_done <= true;
    wait;
  end process test_pstrings;

end architecture testbench;
