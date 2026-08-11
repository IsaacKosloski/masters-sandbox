-------------------------------------------------------------------------------
-- Title      : Matrix Math package for type COMPLEX
-- Project    : IEEE 1076.1-201x
-------------------------------------------------------------------------------
-- File       : complex_matrix_pkg.vhdl
-- Author     : David Bishop  <dbishop@vhdl.org>
-- Company    : 
-- Created    : 2010-08-26
-- Last update: 2011-01-20
-- Platform   : 
-- Standard   : VHDL'2008
-------------------------------------------------------------------------------
-- Description: Matrix math package for type COMPLEX
-------------------------------------------------------------------------------
-- Copyright (c) 2011 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2010-08-26  1.0      l435385 Created
-------------------------------------------------------------------------------
--
package body complex_matrix_pkg is

  -- %%% This is a built in function for VHDL-2008
--%VHDL2008%  -- purpose: minimum of l and r
--%VHDL2008%  function minimum (
--%VHDL2008%    l, r : INTEGER)
--%VHDL2008%    return INTEGER is
--%VHDL2008%  begin
--%VHDL2008%    if l < r then
--%VHDL2008%      return l;
--%VHDL2008%    else
--%VHDL2008%      return r;
--%VHDL2008%    end if;
--%VHDL2008%  end function minimum;

  -- %%% This is a built in function for VHDL-2008
  -- purpose: max of l and r
--%VHDL2008%  function maximum (
--%VHDL2008%    l, r : REAL)
--%VHDL2008%    return REAL is
--%VHDL2008%  begin
--%VHDL2008%    if l < r then
--%VHDL2008%      return r;
--%VHDL2008%    else
--%VHDL2008%      return l;
--%VHDL2008%    end if;
--%VHDL2008%  end function maximum;

  -- purpose: Returns "true" if a matrix is null.
  function isempty (
    arg : complex_matrix)
    return BOOLEAN is
  begin
    if arg'length(1) < 1 or arg'length(2) < 1 then
      return true;
    else
      return false;
    end if;
  end function isempty;

  -- purpose: Returns "true" if a vector is null.
  function isempty (
    arg : complex_vector)
    return BOOLEAN is
  begin
    if arg'length < 1 then
      return true;
    else
      return false;
    end if;
  end function isempty;

  -- purpose: Returns "true" if a matrix is null.
  function isempty (
    arg : complex_polar_matrix)
    return BOOLEAN is
  begin
    if arg'length(1) < 1 or arg'length(2) < 1 then
      return true;
    else
      return false;
    end if;
  end function isempty;

  -- purpose: Returns "true" if a vector is null.
  function isempty (
    arg : complex_polar_vector)
    return BOOLEAN is
  begin
    if arg'length < 1 then
      return true;
    else
      return false;
    end if;
  end function isempty;

  -----------------------------------------------------------------------------
  -- Conversion functions
  -----------------------------------------------------------------------------

  -- Converts a real_matrix to a complex_matrix
  function CMPLX (
    arg : real_matrix)
    return complex_matrix is
    variable result : complex_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := CMPLX (arg (i, j));
      end loop;
    end loop;
    return result;
  end function CMPLX;

  -- Convert a real_vector to a complex_vector
  function CMPLX (
    arg : real_vector)
    return complex_vector is
    variable result : complex_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := CMPLX (arg (i));
    end loop;
    return result;
  end function CMPLX;

  -- Convert 2 complex matrices (one real, one imaginary) to complex_matrix
  function CMPLX (
    X, Y : real_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to X'length(1)-1,
                                      0 to X'length(2)-1);
  begin
    if X'length(1) /= Y'length(1) or X'length(2) /= Y'length(2) then
      report complex_matrix_pkg'instance_name & "CMPLX " &
        "Size of X (" & INTEGER'image(X'length(1)) & "," &
        INTEGER'image(X'length(2)) & ") /= Y("
        & INTEGER'image(Y'length(1)) & "," &
        INTEGER'image(Y'length(2)) & ")" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result(i, j) := CMPLX (X (X'low(1)+i, X'low(2)+j),
                                 Y (Y'low(1)+i, Y'low(2)+j));
        end loop;
      end loop;
    end if;
    return result;
  end function CMPLX;

  -- Convert 2 complex vectors (one real, one imaginary) to complex_vector
  function CMPLX (
    X, Y : real_vector)
    return complex_vector is
    variable result : complex_vector (0 to X'length-1);
  begin
    if X'length /= Y'length then
      report complex_matrix_pkg'instance_name & "CMPLX " &
        "Size of X (" & INTEGER'image(X'length) & ") /= Y("
        & INTEGER'image(Y'length) & ")" severity error;
    else
      for i in result'range(1) loop
        result(i) := CMPLX (X (X'low+i), Y (Y'low+i));
      end loop;
    end if;
    return result;
  end function CMPLX;

  -- Converts a complex_matrix to a complex_polar_matrix
  function COMPLEX_TO_POLAR (
    arg : complex_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := COMPLEX_TO_POLAR (arg (i, j));
      end loop;
    end loop;
    return result;
  end function COMPLEX_TO_POLAR;

  -- Converts a complex_vector to a complex_polar_vector
  function COMPLEX_TO_POLAR (
    arg : complex_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := COMPLEX_TO_POLAR (arg (i));
    end loop;
    return result;
  end function COMPLEX_TO_POLAR;

  -- Convert a complex_polar_matrix to a complex_matrix
  function POLAR_TO_COMPLEX (
    arg : complex_polar_matrix)
    return complex_matrix is
    variable result : complex_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := POLAR_TO_COMPLEX (arg (i, j));
      end loop;
    end loop;
    return result;
  end function POLAR_TO_COMPLEX;

  -- Convert a complex_polar_vector to a complex_vector
  function POLAR_TO_COMPLEX (
    arg : complex_polar_vector)
    return complex_vector is
    variable result : complex_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := POLAR_TO_COMPLEX (arg (i));
    end loop;
    return result;
  end function POLAR_TO_COMPLEX;

  -- Converts a complex_matrix to a real_matrix
  function "abs" (
    arg : complex_matrix)
    return real_matrix is
    variable result : real_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := "abs" (arg (i, j));
      end loop;
    end loop;
    return result;
  end function "abs";

  -- Converts a complex_vector to a real_vector
  function "abs" (
    arg : complex_vector)
    return real_vector is
    variable result : real_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := "abs" (arg (i));
    end loop;
    return result;
  end function "abs";

  -- Converts a complex_polar_matrix to a real_matrix
  function "abs" (
    arg : complex_polar_matrix)
    return real_matrix is
    variable result : real_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := "abs" (arg (i, j));
      end loop;
    end loop;
    return result;
  end function "abs";

  -- Converts a complex_polar_vector to a real_vector
  function "abs" (
    arg : complex_polar_vector)
    return real_vector is
    variable result : real_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := "abs" (arg (i));
    end loop;
    return result;
  end function "abs";

  -----------------------------------------------------------------------------
  -- Arithmetic functions
  -----------------------------------------------------------------------------

  -- Returns unary minus of input
  function "-" (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := "-" (arg (i, j));
      end loop;
    end loop;
    return result;
  end function "-";

  function "-" (
    arg : complex_vector)
    return complex_vector is
    variable result : complex_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := "-" (arg (i));
    end loop;
    return result;
  end function "-";

  function "-" (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := "-" (arg (i, j));
      end loop;
    end loop;
    return result;
  end function "-";

  function "-" (
    arg : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := "-" (arg (i));
    end loop;
    return result;
  end function "-";

  -- Returns the complex conjugate of the input
  function CONJ (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := CONJ (arg (i, j));
      end loop;
    end loop;
    return result;
  end function CONJ;

  function CONJ (
    arg : complex_vector)
    return complex_vector is
    variable result : complex_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := CONJ (arg (i));
    end loop;
    return result;
  end function CONJ;

  function CONJ (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := CONJ (arg (i, j));
      end loop;
    end loop;
    return result;
  end function CONJ;

  function CONJ (
    arg : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := CONJ (arg (i));
    end loop;
    return result;
  end function CONJ;

  -- Addition
  function "+" (
    l, r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- addition
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) +
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "+";

  function "+" (
    l, r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
      return result;
    else
      for i in result'range loop
        result(i) := l(l'low+i) + r(r'low+i);
      end loop;
      return result;
    end if;
  end function "+";
  
  function "+" (
    l : complex_matrix;
    r : real_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- addition
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) +
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "+";

  function "+" (
    l : complex_vector;
    r : real_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) + r(r'low+i);
      end loop;
    end if;
    return result;
  end function "+";

  function "+" (
    l : real_matrix;
    r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- addition
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) +
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "+";

  function "+" (
    l : real_vector;
    r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) + r(r'low+i);
      end loop;
    end if;
    return result;
  end function "+";

  function "+" (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- addition
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) +
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "+";

  function "+" (
    l, r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
      return result;
    else
      for i in result'range loop
        result(i) := l(l'low+i) + r(r'low+i);
      end loop;
      return result;
    end if;
  end function "+";

  -----------------------------------------------------------------------------
  -- Why not just convert?
  -- There are built in function in math_complex to add real and complex number
  -- This makes things run faster (and generate less logic).
  -----------------------------------------------------------------------------
  function "+" (
    l : complex_polar_matrix;
    r : real_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- addition
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) +
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "+";

  function "+" (
    l : complex_polar_vector;
    r : real_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) + r(r'low+i);
      end loop;
    end if;
    return result;
  end function "+";

  function "+" (
    l : real_matrix;
    r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- addition
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) +
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "+";

  function "+" (
    l : real_vector;
    r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Addition " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) + r(r'low+i);
      end loop;
    end if;
    return result;
  end function "+";

  -- Subtraction
  function "-" (
    l, r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- subtraction
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) -
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "-";

  function "-" (
    l, r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) - r(r'low+i);
      end loop;
    end if;
    return result;
  end function "-";
  
  function "-" (
    l : complex_matrix;
    r : real_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- subtraction
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) -
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "-";

  function "-" (
    l : complex_vector;
    r : real_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
      return result;
    else
      for i in result'range loop
        result(i) := l(l'low+i) - r(r'low+i);
      end loop;
      return result;
    end if;
  end function "-";

  function "-" (
    l : real_matrix;
    r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- subtraction
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) -
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "-";

  function "-" (
    l : real_vector;
    r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) - r(r'low+i);
      end loop;
    end if;
    return result;
  end function "-";

  function "-" (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- subtraction
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) -
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "-";

  function "-" (
    l, r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) - r(r'low+i);
      end loop;
    end if;
    return result;
  end function "-";

  function "-" (
    l : complex_polar_matrix;
    r : real_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- subtraction
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) -
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "-";

  function "-" (
    l : complex_polar_vector;
    r : real_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) - r(r'low+i);
      end loop;
    end if;
    return result;
  end function "-";

  function "-" (
    l : real_matrix;
    r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- subtraction
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) -
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "-";

  function "-" (
    l : real_vector;
    r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Subtraction " &
        "Vector lengths do not match " & INTEGER'image(l'length) & " /= " &
        INTEGER'image(r'length) severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) - r(r'low+i);
      end loop;
    end if;
    return result;
  end function "-";

  -- Multiply
  function "*" (
    l, r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to r'length(2)-1);
  begin  -- multiply
    if l'length(2) /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length(2)) &
        " and rows or right = " & INTEGER'image (r'length(1))
        & " should be equal" severity error;
    elsif isempty (l) or isempty(r) then
      -- Silently return an empty matrix
      result := zeros(result'length(1), result'length(2));
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(r'low(1), j+r'low(2));
          for k in 1 to l'length(2)-1 loop
            result (i, j) := result (i, j) +
                             (l(i+l'low(1), k+l'low(2)) *
                              r(k+r'low(1), j+r'low(2)));
          end loop;  -- k
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_matrix;
    r : real_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to r'length(2)-1);
  begin  -- multiply
    if l'length(2) /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length(2)) &
        " and rows or right = " & INTEGER'image (r'length(1))
        & " should be equal" severity error;
    elsif isempty (l) or isempty(r) then
      -- Silently return an empty matrix
      result := zeros(result'length(1), result'length(2));
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(r'low(1), j+r'low(2));
          for k in 1 to l'length(2)-1 loop
            result (i, j) := result (i, j) +
                             (l(i+l'low(1), k+l'low(2)) *
                              r(k+r'low(1), j+r'low(2)));
          end loop;  -- k
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : real_matrix;
    r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to r'length(2)-1);
  begin  -- multiply
    if l'length(2) /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length(2)) &
        " and rows or right = " & INTEGER'image (r'length(1))
        & " should be equal" severity error;
    elsif isempty (l) or isempty(r) then
      -- Silently return an empty matrix
      result := zeros(result'length(1), result'length(2));
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(r'low(1), j+r'low(2));
          for k in 1 to l'length(2)-1 loop
            result (i, j) := result (i, j) +
                             (l(i+l'low(1), k+l'low(2)) *
                              r(k+r'low(1), j+r'low(2)));
          end loop;  -- k
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_matrix;
    r : complex_vector)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to r'length-1);
  begin  -- multiply
    if l'length(2) /= 1 then
      report complex_matrix_pkg'instance_name & "Multiply "
        & " Matrix must have only one column to be multiplied by a vector, "
        & " l (" & INTEGER'image(l'length(1)) & ","
        & INTEGER'image(l'length(2)) & ") * r (" & INTEGER'image(r'length) &
        ") invalid" severity error;
    elsif l'length(1) /= r'length then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left matrix = " & INTEGER'image(l'length(2)) &
        " and size of right vector = " & INTEGER'image(r'length)
        & " should be equal" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(j+r'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_matrix;
    r : real_vector)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to r'length-1);
  begin  -- multiply
    if l'length(2) /= 1 then
      report complex_matrix_pkg'instance_name & "Multiply "
        & " Matrix must have only one column to be multiplied by a vector, "
        & " l (" & INTEGER'image(l'length(1)) & ","
        & INTEGER'image(l'length(2)) & ") * r (" & INTEGER'image(r'length) &
        ") invalid" severity error;
    elsif l'length(1) /= r'length then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left matrix = " & INTEGER'image(l'length(2)) &
        " and size of right vector = " & INTEGER'image(r'length)
        & " should be equal" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(j+r'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : real_matrix;
    r : complex_vector)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to r'length-1);
  begin  -- multiply
    if l'length(2) /= 1 then
      report complex_matrix_pkg'instance_name & "Multiply "
        & " Matrix must have only one column to be multiplied by a vector, "
        & " l (" & INTEGER'image(l'length(1)) & ","
        & INTEGER'image(l'length(2)) & ") * r (" & INTEGER'image(r'length) &
        ") invalid" severity error;
    elsif l'length(1) /= r'length then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left matrix = " & INTEGER'image(l'length(2)) &
        " and size of right vector = " & INTEGER'image(r'length)
        & " should be equal" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(j+r'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_vector;
    r : complex_matrix)
    return complex_vector is
    variable result : complex_vector (0 to r'length(2)-1);
  begin  -- multiply
    if l'length /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length) &
        " size of right matrix = (" & INTEGER'image(r'length(1)) & "," &
        INTEGER'image(r'length(2)) & ")"
        & " should be equal" severity error;
    elsif isempty(r) or isempty (l) then
      -- Silently return an empty matrix
      result := zeros (1, result'length);
    else
      for i in result'range loop
        result (i) := l(l'low) * r(r'low(1), i+r'low(2));
        for k in 1 to r'length(1)-1 loop
          result (i) := result (i) + (l(k+l'low) * r(k+r'low(1), i+r'low(2)));
        end loop;  -- k
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : real_vector;
    r : complex_matrix)
    return complex_vector is
    variable result : complex_vector (0 to r'length(2)-1);
  begin  -- multiply
    if l'length /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length) &
        " size of right matrix = (" & INTEGER'image(r'length(1)) & "," &
        INTEGER'image(r'length(2)) & ")"
        & " should be equal" severity error;
    elsif isempty(r) or isempty (l) then
      -- Silently return an empty matrix
      result := zeros (1, result'length);
    else
      for i in result'range loop
        result (i) := l(l'low) * r(r'low(1), i+r'low(2));
        for k in 1 to r'length(1)-1 loop
          result (i) := result (i) + (l(k+l'low) * r(k+r'low(1), i+r'low(2)));
        end loop;  -- k
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_vector;
    r : real_matrix)
    return complex_vector is
    variable result : complex_vector (0 to r'length(2)-1);
  begin  -- multiply
    if l'length /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length) &
        " size of right matrix = (" & INTEGER'image(r'length(1)) & "," &
        INTEGER'image(r'length(2)) & ")"
        & " should be equal" severity error;
    elsif isempty(r) or isempty (l) then
      -- Silently return an empty matrix
      result := zeros (1, result'length);
    else
      for i in result'range loop
        result (i) := l(l'low) * r(r'low(1), i+r'low(2));
        for k in 1 to r'length(1)-1 loop
          result (i) := result (i) + (l(k+l'low) * r(k+r'low(1), i+r'low(2)));
        end loop;  -- k
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_matrix;
    r : COMPLEX)
    return complex_matrix is
  begin  -- multiply
    return r * l;
  end function "*";

  function "*" (
    l : COMPLEX;
    r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to r'length(1)-1,
                                      0 to r'length(2)-1);
  begin  -- multiply
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := l * r (i+r'low(1), j+r'low(2));
      end loop;  -- j
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : complex_vector;
    r : COMPLEX)
    return complex_vector is
  begin
    return r * l;
  end function "*";

  function "*" (
    l : COMPLEX;
    r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to r'length-1);
  begin  -- multiply
    for i in result'range loop
      result (i) := l * r (i+r'low);
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : complex_matrix;
    r : REAL)
    return complex_matrix is
  begin  -- multiply
    return r * l;
  end function "*";

  function "*" (
    l : REAL;
    r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to r'length(1)-1,
                                      0 to r'length(2)-1);
  begin  -- multiply
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := l * r (i+r'low(1), j+r'low(2));
      end loop;  -- j
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : complex_vector;
    r : REAL)
    return complex_vector is
  begin
    return r * l;
  end function "*";

  function "*" (
    l : REAL;
    r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to r'length-1);
  begin  -- multiply
    for i in result'range loop
      result (i) := l * r (i+r'low);
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to r'length(2)-1);
  begin  -- multiply
    if l'length(2) /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length(2)) &
        " and rows or right = " & INTEGER'image (r'length(1))
        & " should be equal" severity error;
    elsif isempty (l) or isempty(r) then
      -- Silently return an empty matrix
      result := zeros(result'length(1), result'length(2));
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(r'low(1), j+r'low(2));
          for k in 1 to l'length(2)-1 loop
            result (i, j) := result (i, j) +
                             (l(i+l'low(1), k+l'low(2)) *
                              r(k+r'low(1), j+r'low(2)));
          end loop;  -- k
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_polar_matrix;
    r : real_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to r'length(2)-1);
  begin  -- multiply
    if l'length(2) /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length(2)) &
        " and rows or right = " & INTEGER'image (r'length(1))
        & " should be equal" severity error;
    elsif isempty (l) or isempty(r) then
      -- Silently return an empty matrix
      result := zeros(result'length(1), result'length(2));
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(r'low(1), j+r'low(2));
          for k in 1 to l'length(2)-1 loop
            result (i, j) := result (i, j) +
                             (l(i+l'low(1), k+l'low(2)) *
                              r(k+r'low(1), j+r'low(2)));
          end loop;  -- k
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : real_matrix;
    r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to r'length(2)-1);
  begin  -- multiply
    if l'length(2) /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length(2)) &
        " and rows or right = " & INTEGER'image (r'length(1))
        & " should be equal" severity error;
    elsif isempty (l) or isempty(r) then
      -- Silently return an empty matrix
      result := zeros(result'length(1), result'length(2));
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(r'low(1), j+r'low(2));
          for k in 1 to l'length(2)-1 loop
            result (i, j) := result (i, j) +
                             (l(i+l'low(1), k+l'low(2)) *
                              r(k+r'low(1), j+r'low(2)));
          end loop;  -- k
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_polar_matrix;
    r : complex_polar_vector)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to r'length-1);
  begin  -- multiply
    if l'length(2) /= 1 then
      report complex_matrix_pkg'instance_name & "Multiply "
        & " Matrix must have only one column to be multiplied by a vector, "
        & " l (" & INTEGER'image(l'length(1)) & ","
        & INTEGER'image(l'length(2)) & ") * r (" & INTEGER'image(r'length) &
        ") invalid" severity error;
    elsif l'length(1) /= r'length then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left matrix = " & INTEGER'image(l'length(2)) &
        " and size of right vector = " & INTEGER'image(r'length)
        & " should be equal" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(j+r'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_polar_matrix;
    r : real_vector)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to r'length-1);
  begin  -- multiply
    if l'length(2) /= 1 then
      report complex_matrix_pkg'instance_name & "Multiply "
        & " Matrix must have only one column to be multiplied by a vector, "
        & " l (" & INTEGER'image(l'length(1)) & ","
        & INTEGER'image(l'length(2)) & ") * r (" & INTEGER'image(r'length) &
        ") invalid" severity error;
    elsif l'length(1) /= r'length then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left matrix = " & INTEGER'image(l'length(2)) &
        " and size of right vector = " & INTEGER'image(r'length)
        & " should be equal" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(j+r'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : real_matrix;
    r : complex_polar_vector)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to r'length-1);
  begin  -- multiply
    if l'length(2) /= 1 then
      report complex_matrix_pkg'instance_name & "Multiply "
        & " Matrix must have only one column to be multiplied by a vector, "
        & " l (" & INTEGER'image(l'length(1)) & ","
        & INTEGER'image(l'length(2)) & ") * r (" & INTEGER'image(r'length) &
        ") invalid" severity error;
    elsif l'length(1) /= r'length then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left matrix = " & INTEGER'image(l'length(2)) &
        " and size of right vector = " & INTEGER'image(r'length)
        & " should be equal" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l(i+l'low(1), l'low(2)) * r(j+r'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_polar_vector;
    r : complex_polar_matrix)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to r'length(2)-1);
  begin  -- multiply
    if l'length /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length) &
        " size of right matrix = (" & INTEGER'image(r'length(1)) & "," &
        INTEGER'image(r'length(2)) & ")"
        & " should be equal" severity error;
    elsif isempty(r) or isempty (l) then
      -- Silently return an empty matrix
      result := zeros (1, result'length);
    else
      for i in result'range loop
        result (i) := l(l'low) * r(r'low(1), i+r'low(2));
        for k in 1 to r'length(1)-1 loop
          result (i) := result (i) + (l(k+l'low) * r(k+r'low(1), i+r'low(2)));
        end loop;  -- k
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : real_vector;
    r : complex_polar_matrix)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to r'length(2)-1);
  begin  -- multiply
    if l'length /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length) &
        " size of right matrix = (" & INTEGER'image(r'length(1)) & "," &
        INTEGER'image(r'length(2)) & ")"
        & " should be equal" severity error;
    elsif isempty(r) or isempty (l) then
      -- Silently return an empty matrix
      result := zeros (1, result'length);
    else
      for i in result'range loop
        result (i) := l(l'low) * r(r'low(1), i+r'low(2));
        for k in 1 to r'length(1)-1 loop
          result (i) := result (i) + (l(k+l'low) * r(k+r'low(1), i+r'low(2)));
        end loop;  -- k
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_polar_vector;
    r : real_matrix)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to r'length(2)-1);
  begin  -- multiply
    if l'length /= r'length(1) then
      report complex_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length) &
        " size of right matrix = (" & INTEGER'image(r'length(1)) & "," &
        INTEGER'image(r'length(2)) & ")"
        & " should be equal" severity error;
    elsif isempty(r) or isempty (l) then
      -- Silently return an empty matrix
      result := zeros (1, result'length);
    else
      for i in result'range loop
        result (i) := l(l'low) * r(r'low(1), i+r'low(2));
        for k in 1 to r'length(1)-1 loop
          result (i) := result (i) + (l(k+l'low) * r(k+r'low(1), i+r'low(2)));
        end loop;  -- k
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : complex_polar_matrix;
    r : COMPLEX_POLAR)
    return complex_polar_matrix is
  begin  -- multiply
    return r * l;
  end function "*";

  function "*" (
    l : COMPLEX_POLAR;
    r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to r'length(1)-1,
                                            0 to r'length(2)-1);
  begin  -- multiply
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := l * r (i+r'low(1), j+r'low(2));
      end loop;  -- j
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : complex_polar_vector;
    r : COMPLEX_POLAR)
    return complex_polar_vector is
  begin
    return r * l;
  end function "*";

  function "*" (
    l : COMPLEX_POLAR;
    r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to r'length-1);
  begin  -- multiply
    for i in result'range loop
      result (i) := l * r (i+r'low);
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : complex_polar_matrix;
    r : REAL)
    return complex_polar_matrix is
  begin  -- multiply
    return r * l;
  end function "*";

  function "*" (
    l : REAL;
    r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to r'length(1)-1,
                                            0 to r'length(2)-1);
  begin  -- multiply
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := l * r (i+r'low(1), j+r'low(2));
      end loop;  -- j
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : complex_polar_vector;
    r : REAL)
    return complex_polar_vector is
  begin
    return r * l;
  end function "*";

  function "*" (
    l : REAL;
    r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to r'length-1);
  begin  -- multiply
    for i in result'range loop
      result (i) := l * r (i+r'low);
    end loop;  -- i
    return result;
  end function "*";

  function "/" (
    l : complex_matrix;
    r : COMPLEX)
    return complex_matrix is
  begin
    return l * (1.0/r);
  end function "/";

  function "/" (
    l : complex_vector;
    r : COMPLEX)
    return complex_vector is
  begin
    return l * (1.0/r);
  end function "/";

  function "/" (
    l : complex_polar_matrix;
    r : COMPLEX_POLAR)
    return complex_polar_matrix is
  begin
    return l * (1.0/r);
  end function "/";

  function "/" (
    l : complex_polar_vector;
    r : COMPLEX_POLAR)
    return complex_polar_vector is
  begin
    return l * (1.0/r);
  end function "/";

  function "/" (l : complex_matrix;
                r : REAL)
    return complex_matrix is
  begin
    return l * (1.0/r);
  end function "/";

  function "/" (
    l : complex_vector;
    r : REAL)
    return complex_vector is
  begin
    return l * (1.0/r);
  end function "/";

  function "/" (
    l : complex_polar_matrix;
    r : REAL)
    return complex_polar_matrix is
  begin
    return l * (1.0/r);
  end function "/";

  function "/" (
    l : complex_polar_vector;
    r : REAL)
    return complex_polar_vector is
  begin
    return l * (1.0/r);
  end function "/";

  -- Matlab .* operator
  function times (
    l, r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- ".*"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "times " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) *
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function times;

  function times (
    l : complex_matrix;
    r : real_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- ".*"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "times " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) *
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function times;

  function times (
    l : real_matrix;
    r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- ".*"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "times " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) *
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function times;

  function times (
    l, r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "times " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
      return result;
    else
      for i in result'range loop
        result(i) := l(l'low+i) * r(r'low+i);
      end loop;
      return result;
    end if;
  end function times;

  function times (
    l : complex_vector;
    r : real_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "times " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
      return result;
    else
      for i in result'range loop
        result(i) := l(l'low+i) * r(r'low+i);
      end loop;
      return result;
    end if;
  end function times;

  function times (
    l : real_vector;
    r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "times " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
      return result;
    else
      for i in result'range loop
        result(i) := l(l'low+i) * r(r'low+i);
      end loop;
      return result;
    end if;
  end function times;

  function times (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- ".*"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "times " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) *
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function times;

  function times (
    l : complex_polar_matrix;
    r : real_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- ".*"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "times " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) *
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function times;

  function times (
    l : real_matrix;
    r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- ".*"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "times " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) *
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function times;

  function times (
    l, r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "times " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) * r(r'low+i);
      end loop;
    end if;
    return result;
  end function times;

  function times (
    l : complex_polar_vector;
    r : real_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "times " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
      return result;
    else
      for i in result'range loop
        result(i) := l(l'low+i) * r(r'low+i);
      end loop;
      return result;
    end if;
  end function times;

  function times (
    l : real_vector;
    r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "times " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
      return result;
    else
      for i in result'range loop
        result(i) := l(l'low+i) * r(r'low+i);
      end loop;
      return result;
    end if;
  end function times;

  -- Matlab ./ operator
  function rdivide (
    l, r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- "./"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) /
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l : complex_matrix;
    r : real_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- "./"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) /
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l : real_matrix;
    r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to l'length(1)-1,
                                      0 to l'length(2)-1);
  begin  -- "./"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) /
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l, r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) / r(r'low+i);
      end loop;
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l : complex_vector;
    r : real_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) / r(r'low+i);
      end loop;
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l : real_vector;
    r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) / r(r'low+i);
      end loop;
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- "./"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) /
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l : complex_polar_matrix;
    r : real_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- "./"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) /
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l : real_matrix;
    r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to l'length(1)-1,
                                            0 to l'length(2)-1);
  begin  -- "./"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := l (i+l'low(1), j+l'low(2)) /
                           r (i+r'low(1), j+r'low(2));
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l, r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) / r(r'low+i);
      end loop;
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l : complex_polar_vector;
    r : real_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) / r(r'low+i);
      end loop;
    end if;
    return result;
  end function rdivide;

  function rdivide (
    l : real_vector;
    r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "rdivide " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) / r(r'low+i);
      end loop;
    end if;
    return result;
  end function rdivide;

  -- Matlab / operator (calls mrdivide)
  function "/" (
    l, r : complex_matrix)
    return complex_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function "/" (
    l : complex_matrix;
    r : real_matrix)
    return complex_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function "/" (
    l : real_matrix;
    r : complex_matrix)
    return complex_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function mrdivide (
    l, r : complex_matrix)
    return complex_matrix is
  begin
    return l * inv(r);
  end function mrdivide;

  function mrdivide (
    l : complex_matrix;
    r : real_matrix)
    return complex_matrix is
  begin
    return l * inv(r);
  end function mrdivide;

  function mrdivide (
    l : real_matrix;
    r : complex_matrix)
    return complex_matrix is
  begin
    return l * inv(r);
  end function mrdivide;

  function "/" (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
  begin
    return mrdivide (l, r);
  end function "/";
  
  function "/" (
    l : complex_polar_matrix;
    r : real_matrix)
    return complex_polar_matrix is
  begin
    return mrdivide (l, r);
  end function "/";
  
  function "/" (
    l : real_matrix;
    r : complex_polar_matrix)
    return complex_polar_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function mrdivide (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
  begin
    return l * inv(r);
  end function mrdivide;

  function mrdivide (
    l : complex_polar_matrix;
    r : real_matrix)
    return complex_polar_matrix is
  begin
    return l * inv(r);
  end function mrdivide;
  
  function mrdivide (
    l : real_matrix;
    r : complex_polar_matrix)
    return complex_polar_matrix is
  begin
    return l * inv(r);
  end function mrdivide;

  -- Matlab \ operator
  function mldivide (
    l, r : complex_matrix)
    return complex_matrix is
  begin
    return inv(l) * r;
  end function mldivide;

  function mldivide (
    l : complex_matrix;
    r : real_matrix)
    return complex_matrix is
  begin
    return inv(l) * r;
  end function mldivide;

  function mldivide (
    l : real_matrix;
    r : complex_matrix)
    return complex_matrix is
  begin
    return inv(l) * r;
  end function mldivide;

  function mldivide (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
  begin
    return inv(l) * r;
  end function mldivide;

  function mldivide (
    l : complex_polar_matrix;
    r : real_matrix)
    return complex_polar_matrix is
  begin
    return inv(l) * r;
  end function mldivide;

  function mldivide (
    l : real_matrix;
    r : complex_polar_matrix)
    return complex_polar_matrix is
  begin
    return inv(l) * r;
  end function mldivide;

  -- Element by element square root
  function sqrt (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(1)-1,
                                      0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := sqrt (arg ((arg'low(1)+i), (arg'low(2)+j)));
      end loop;
    end loop;
    return result;
  end function sqrt;

  function sqrt (
    arg : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := sqrt (arg (arg'low+i));
    end loop;
    return result;
  end function sqrt;

  function "**" (
    arg : complex_matrix;
    pow : INTEGER)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(1)-1,
                                      0 to arg'length(2)-1);
    variable Half : INTEGER;
  begin
    if arg'length(1) /= arg'length(2) then
      report complex_matrix_pkg'instance_name & "** " &
        "Matrix is not square (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ")" severity error;
      return arg;
    elsif pow < 0 then
      -- arg^(-1) = inv(arg)  arg^(-2) = inv(arg)^2
      return inv(arg)**(-pow);
    elsif pow = 0 then
      result := (others => (others => MATH_CBASE_1));
      return result;
    elsif pow = 1 then
      return arg;
    elsif pow = 2 then
      return arg * arg;
    else
      Half   := pow / 2;
      result := (arg**Half) * (arg**(pow-Half));
      return result;
    end if;
  end function "**";

  function exp (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(1)-1,
                                      0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := exp (arg ((arg'low(1)+i), (arg'low(2)+j)));
      end loop;
    end loop;
    return result;
  end function exp;

  function exp (
    arg : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := exp (arg (arg'low+i));
    end loop;
    return result;
  end function exp;

  function log (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(1)-1,
                                      0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := log (arg ((arg'low(1)+i), (arg'low(2)+j)));
      end loop;
    end loop;
    return result;
  end function log;

  function log (
    arg : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := log (arg (arg'low+i));
    end loop;
    return result;
  end function log;

  -- Element by element square root
  function sqrt (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(1)-1,
                                            0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := sqrt (arg ((arg'low(1)+i), (arg'low(2)+j)));
      end loop;
    end loop;
    return result;
  end function sqrt;

  function sqrt (
    arg : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := sqrt (arg (arg'low+i));
    end loop;
    return result;
  end function sqrt;

  function "**" (
    arg : complex_polar_matrix;
    pow : INTEGER)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(1)-1,
                                            0 to arg'length(2)-1);
    variable Half : INTEGER;
    constant one  : complex_polar := complex_polar'(1.0, 0.0);  -- 1.0
  begin
    if arg'length(1) /= arg'length(2) then
      report complex_matrix_pkg'instance_name & "** " &
        "Matrix is not square (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ")" severity error;
      return arg;
    elsif pow < 0 then
      -- arg^(-1) = inv(arg)  arg^(-2) = inv(arg)^2
      return inv(arg)**(-pow);
    elsif pow = 0 then
      result := (others => (others => one));
      return result;
    elsif pow = 1 then
      return arg;
    elsif pow = 2 then
      return arg * arg;
    else
      Half   := pow / 2;
      result := (arg**Half) * (arg**(pow-Half));
      return result;
    end if;
  end function "**";

  function exp (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(1)-1,
                                            0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := exp (arg ((arg'low(1)+i), (arg'low(2)+j)));
      end loop;
    end loop;
    return result;
  end function exp;

  function exp (
    arg : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := exp (arg (arg'low+i));
    end loop;
    return result;
  end function exp;

  function log (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(1)-1,
                                            0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := log (arg ((arg'low(1)+i), (arg'low(2)+j)));
      end loop;
    end loop;
    return result;
  end function log;

  function log (
    arg : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := log (arg (arg'low+i));
    end loop;
    return result;
  end function log;

  -- Compare functions (use the defaults when possible)
  function "=" (
    l : complex_matrix;
    r : complex_vector)
    return BOOLEAN is
    variable lv : complex_vector (0 to r'length-1);
  begin
    if l'length(1) = 1 and l'length(2) = r'length then
      lv := SubMatrix (l, l'low(1), l'low(2), 1, r'length);
      return lv = r;
    else
      return false;
    end if;
  end function "=";

  function "=" (
    l : complex_vector;
    r : complex_matrix)
    return BOOLEAN is
  begin
    return r = l;
  end function "=";

  function "/=" (
    l : complex_matrix;
    r : complex_vector)
    return BOOLEAN is
  begin
    return not (l = r);
  end function "/=";

  function "/=" (
    l : complex_vector;
    r : complex_matrix)
    return BOOLEAN is
  begin
    return not (r = l);
  end function "/=";

  function "=" (
    l : complex_polar_matrix;
    r : complex_polar_vector)
    return BOOLEAN is
    variable lv : complex_polar_vector (0 to r'length-1);
  begin
    if l'length(1) = 1 and l'length(2) = r'length then
      lv := SubMatrix (l, l'low(1), l'low(2), 1, r'length);
      return lv = r;
    else
      return false;
    end if;
  end function "=";

  function "=" (
    l : complex_polar_vector;
    r : complex_polar_matrix)
    return BOOLEAN is
  begin
    return r = l;
  end function "=";

  function "/=" (
    l : complex_polar_matrix;
    r : complex_polar_vector)
    return BOOLEAN is
  begin
    return not (l = r);
  end function "/=";

  function "/=" (
    l : complex_polar_vector;
    r : complex_polar_matrix)
    return BOOLEAN is
  begin
    return not (r = l);
  end function "/=";

  -----------------------------------------------------------------------------
  -- Algorithmic functions
  -----------------------------------------------------------------------------

  -- Sum the diagonal
  function trace (
    arg : complex_matrix)
    return complex is
  begin
    return sum (diag(arg));
  end function trace;

  function trace (
    arg : complex_polar_matrix)
    return complex_polar is
  begin
    return sum (diag(arg));
  end function trace;

  -- Sum a vector
  function sum (
    arg : complex_vector)
    return complex is
    variable result : complex;
  begin
    if isempty (arg) then
      return (0.0, 0.0);
    else
      result := arg (arg'low);
      for i in arg'low+1 to arg'high loop
        result := result + arg(i);
      end loop;
      return result;
    end if;
  end function sum;

  function sum (
    arg : complex_polar_vector)
    return complex_polar is
    variable result : complex_polar;
  begin
    if isempty (arg) then
      return (0.0, 0.0);
    else
      result := arg (arg'low);
      for i in arg'low+1 to arg'high loop
        result := result + arg(i);
      end loop;
      return result;
    end if;
  end function sum;

  -- Sum a matrix and returns a vector
  function sum (
    arg          : complex_matrix;
    constant dim : POSITIVE := 1)                           -- 1 = y, 2 = x
    return complex_vector is
    variable resx : complex_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : complex_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := arg (arg'low(1)+j, arg'low(2)+i);
        end loop;
        resx (i) := sum (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := arg (arg'low(1)+i, arg'low(2)+j);
        end loop;
        resy (i) := sum (resx);
      end loop;
      return resy;
    else
      report complex_matrix_pkg'instance_name & "sum " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function sum;

  -- Sum a matrix and returns a vector
  function sum (
    arg          : complex_polar_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return complex_polar_vector is
    variable resx : complex_polar_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : complex_polar_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := arg (arg'low(1)+j, arg'low(2)+i);
        end loop;
        resx (i) := sum (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := arg (arg'low(1)+i, arg'low(2)+j);
        end loop;
        resy (i) := sum (resx);
      end loop;
      return resy;
    else
      report complex_matrix_pkg'instance_name & "sum " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function sum;

  -- Multiply every element in a vector
  function prod (
    arg : complex_vector)
    return complex is
    variable result : complex;
  begin
    if isempty (arg) then
      return (1.0, 0.0);
    else
      result := arg (arg'low);
      for i in arg'low+1 to arg'high loop
        result := result * arg(i);
      end loop;
      return result;
    end if;
  end function prod;

  function prod (
    arg : complex_polar_vector)
    return complex_polar is
    variable result : complex_polar;
  begin
    if isempty (arg) then
      return (1.0, 0.0);
    else
      result := arg (arg'low);
      for i in arg'low+1 to arg'high loop
        result := result * arg(i);
      end loop;
      return result;
    end if;
  end function prod;

  -- Multiply elements in a matrix and returns a vector
  function prod (
    arg          : complex_matrix;
    constant dim : POSITIVE := 1)                           -- 1 = y, 2 = x
    return complex_vector is
    variable resx : complex_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : complex_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := arg (arg'low(1)+j, arg'low(2)+i);
        end loop;
        resx (i) := prod (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := arg (arg'low(1)+i, arg'low(2)+j);
        end loop;
        resy (i) := prod (resx);
      end loop;
      return resy;
    else
      report complex_matrix_pkg'instance_name & "prod " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function prod;

  function prod (
    arg          : complex_polar_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return complex_polar_vector is
    variable resx : complex_polar_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : complex_polar_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := arg (arg'low(1)+j, arg'low(2)+i);
        end loop;
        resx (i) := prod (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := arg (arg'low(1)+i, arg'low(2)+j);
        end loop;
        resy (i) := prod (resx);
      end loop;
      return resy;
    else
      report complex_matrix_pkg'instance_name & "prod " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function prod;

  -- purpose: Dot product of two vectors
  function dot (
    l, r : complex_vector)
    return complex is
    variable result : complex;
  begin
    result := (0.0, 0.0);
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Dot " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in 0 to l'length-1 loop
        result := result + (l (l'low+i) * r (r'low+i));
      end loop;
    end if;
    return result;
  end function dot;

  -- purpose: Dot product of two vectors
  function dot (
    l, r : complex_polar_vector)
    return complex_polar is
    variable result : complex_polar;
  begin
    result := (0.0, 0.0);
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Dot " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in 0 to l'length-1 loop
        result := result + (l (l'low+i) * r (r'low+i));
      end loop;
    end if;
    return result;
  end function dot;

  -- purpose: cross product of two vectors
  function cross (
    l, r : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Cross " &
        "Vectors do not match l(" & INTEGER'image(l'length) & ") /= r("&
        INTEGER'image(r'length) & ")"
        severity error;
    elsif l'length /= 3 then
      report complex_matrix_pkg'instance_name & "Cross " &
        "function only works on a vector length of 3, length given was "
        & INTEGER'image(l'length)
        severity error;
    else
      result(0) := l(l'low+1)*r(r'low+2) - l(l'low+2)*r(r'low+1);
      result(1) := l(l'low+2)*r(r'low+0) - l(l'low+0)*r(r'low+2);
      result(2) := l(l'low+0)*r(r'low+1) - l(l'low+1)*r(r'low+0);
    end if;
    return result;
  end function cross;

  -- purpose: cross product of two matrices
  function cross (
    l, r : complex_matrix)
    return complex_matrix is
    variable a, b, c : complex_vector (0 to l'length(1)-1);  -- variables
    variable result  : complex_matrix (0 to l'length(1)-1, 0 to l'length(2)-1);
  begin
    if l'length(1) /= r'length(1) and l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Cross " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    elsif l'length(2) /= 3 then
      report complex_matrix_pkg'instance_name & "Cross " &
        "function only works on a matrix length of 3, length given was ("
        & INTEGER'image(l'length(1)) & "," & INTEGER'image(l'length(2)) & ")"
        severity error;
    else
      for i in result'range(2) loop
        for j in a'range loop
          a (j) := l (l'low(1)+j, l'low(2)+i);
          b (j) := r (r'low(1)+j, r'low(2)+i);
        end loop;
--        a := SubMatrix (l, l'low(1), i+l'low(2), a'length, 1);  -- return column i
--        b := SubMatrix (r, r'low(1), i+l'low(2), b'length, 1);
        c := cross (a, b);
        InsertColumn (c, result, 0, i);  -- Put result in column i
      end loop;
    end if;
    return result;
  end function cross;

  -- Kronecker product.
  function kron (
    l, r : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to (l'length(1)*r'length(1))-1,
                                      0 to (l'length(2)*r'length(2))-1);
  begin
    for i in 0 to l'length(1)-1 loop
      for j in 0 to l'length(2)-1 loop
        for m in 0 to r'length(1)-1 loop
          for n in 0 to r'length(2)-1 loop
            result ((i*r'length(1))+m, (j*r'length(2))+n) :=
              l(i, j) * r(m, n);
          end loop;  -- n
        end loop;  -- m
      end loop;  -- j
    end loop;  -- i
    return result;
  end function kron;

  -- purpose: cross product of two vectors
  function cross (
    l, r : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report complex_matrix_pkg'instance_name & "Cross " &
        "Vectors do not match l(" & INTEGER'image(l'length) & ") /= r("&
        INTEGER'image(r'length) & ")"
        severity error;
    elsif l'length /= 3 then
      report complex_matrix_pkg'instance_name & "Cross " &
        "function only works on a vector length of 3, length given was "
        & INTEGER'image(l'length)
        severity error;
    else
      result(0) := l(l'low+1)*r(r'low+2) - l(l'low+2)*r(r'low+1);
      result(1) := l(l'low+2)*r(r'low+0) - l(l'low+0)*r(r'low+2);
      result(2) := l(l'low+0)*r(r'low+1) - l(l'low+1)*r(r'low+0);
    end if;
    return result;
  end function cross;

  -- purpose: cross product of two matrices
  function cross (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
    variable a, b, c : complex_polar_vector (0 to l'length(1)-1);  -- variables
    variable result  : complex_polar_matrix (0 to l'length(1)-1, 0 to l'length(2)-1);
  begin
    if l'length(1) /= r'length(1) and l'length(2) /= r'length(2) then
      report complex_matrix_pkg'instance_name & "Cross " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    elsif l'length(2) /= 3 then
      report complex_matrix_pkg'instance_name & "Cross " &
        "function only works on a matrix length of 3, length given was ("
        & INTEGER'image(l'length(1)) & "," & INTEGER'image(l'length(2)) & ")"
        severity error;
    else
      for i in result'range(2) loop
        for j in a'range loop
          a (j) := l (l'low(1)+j, l'low(2)+i);
          b (j) := r (r'low(1)+j, r'low(2)+i);
        end loop;
--        a := SubMatrix (l, l'low(1), i+l'low(2), a'length, 1);  -- return column i
--        b := SubMatrix (r, r'low(1), i+l'low(2), b'length, 1);
        c := cross (a, b);
        InsertColumn (c, result, 0, i);  -- Put result in column i
      end loop;
    end if;
    return result;
  end function cross;

  -- Kronecker product.
  function kron (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to (l'length(1)*r'length(1))-1,
                                            0 to (l'length(2)*r'length(2))-1);
  begin
    for i in 0 to l'length(1)-1 loop
      for j in 0 to l'length(2)-1 loop
        for m in 0 to r'length(1)-1 loop
          for n in 0 to r'length(2)-1 loop
            result ((i*r'length(1))+m, (j*r'length(2))+n) :=
              l(i, j) * r(m, n);
          end loop;  -- n
        end loop;  -- m
      end loop;  -- j
    end loop;  -- i
    return result;
  end function kron;

  -- purpose: Finds the determinant of a matrix
  function det (
    arg : complex_matrix)
    return complex is
    variable i, j : INTEGER;            -- temp variables
    variable plus : BOOLEAN;            -- Used on the last sum
    variable reduced : complex_matrix (0 to arg'length(1)-2,
                                       0 to arg'length(2)-2);  -- reduced matrix
    variable result, prod : complex;
  begin  -- determinant
    if isempty(arg) then
      result := (0.0, 0.0);
    elsif arg'length(1) /= arg'length(2) then
      report complex_matrix_pkg'instance_name & "determinant " &
        " Matrix is not square " & INTEGER'image(arg'length(1)) &
        " /= " & INTEGER'image(arg'length(2)) severity error;
      result := (0.0, 0.0);
    elsif arg'length(1) = 1 then        -- 1x1 matrix.
      result := arg(arg'low(1), arg'low(2));
    elsif arg'length(1) = 2 then        -- 2x2 matrix
      -- return ad - bc
      result := (arg(arg'low(1), arg'low(2)) * arg(arg'high(1), arg'high(2))) -
                (arg(arg'low(1), arg'high(2)) * arg(arg'high(1), arg'low(2)));
    else                                -- Go across the top row
      plus   := true;
      result := (0.0, 0.0);
      for j in arg'range(2) loop
        reduced := exclude (arg, arg'low(1), j);
        prod    := arg (arg'low(1), j) * det (reduced);
        if plus then
          result := result + prod;
        else
          result := result - prod;
        end if;
        plus := not plus;
      end loop;  -- j
    end if;
    return result;
  end function det;
  
  function det (
    arg : complex_polar_matrix)
    return complex_polar is
    variable i, j : INTEGER;            -- temp variables
    variable plus : BOOLEAN;            -- Used on the last sum
    variable reduced : complex_polar_matrix (0 to arg'length(1)-2,
                                             0 to arg'length(2)-2);  -- reduced matrix
    variable result, prod : complex_polar;
  begin  -- determinant
    if isempty(arg) then
      result := (0.0, 0.0);
    elsif arg'length(1) /= arg'length(2) then
      report complex_matrix_pkg'instance_name & "determinant " &
        " Matrix is not square " & INTEGER'image(arg'length(1)) &
        " /= " & INTEGER'image(arg'length(2)) severity error;
      result := (0.0, 0.0);
    elsif arg'length(1) = 1 then        -- 1x1 matrix.
      result := arg(arg'low(1), arg'low(2));
    elsif arg'length(1) = 2 then        -- 2x2 matrix
      -- return ad - bc
      result := (arg(arg'low(1), arg'low(2)) * arg(arg'high(1), arg'high(2))) -
                (arg(arg'low(1), arg'high(2)) * arg(arg'high(1), arg'low(2)));
    else                                -- Go across the top row
      plus   := true;
      result := (0.0, 0.0);
      for j in arg'range(2) loop
        reduced := exclude (arg, arg'low(1), j);
        prod    := arg (arg'low(1), j) * det (reduced);
        if plus then
          result := result + prod;
        else
          result := result - prod;
        end if;
        plus := not plus;
      end loop;  -- j
    end if;
    return result;
  end function det;

  -- purpose: Inverts a matrix
  function inv (
    arg : complex_matrix)
    return complex_matrix is
    variable i, j : INTEGER;            -- temp variables
    variable plus : BOOLEAN;            -- Used on the last sum
    variable reduced : complex_matrix (0 to arg'length(1)-2,
                                       0 to arg'length(2)-2);  -- reduced matrix
    variable cofact : complex_matrix (0 to arg'length(1)-1,
                                      0 to arg'length(2)-1);   -- minor matrix
    variable result : complex_matrix (0 to arg'length(2)-1,
                                      0 to arg'length(1)-1);
    variable deter, prod : complex;
    constant zero : complex := (0.0, 0.0);
  begin  -- invert
    if isempty(arg) then
      null;
    elsif arg'length(1) /= arg'length(2) then
      report complex_matrix_pkg'instance_name & "invert " &
        " Matrix is not square " & INTEGER'image(arg'length(1)) &
        " /= " & INTEGER'image(arg'length(2)) severity error;
      result := zeros (result'length(1), result'length(2));
    elsif arg'length(1) = 1 then        -- 1x1 case
      if arg (arg'low(1), arg'low(2)) = zero then
        report complex_matrix_pkg'instance_name & "invert " &
          " Matrix is not invertible, Determinant = 0"
          severity error;
        result (0, 0) := zero;
      else
        result (0, 0) := 1.0 / arg(arg'low(1), arg'low(2));
      end if;
    elsif arg'length(1) = 2 then        -- 2x2 case
      deter := det (arg);
      if deter = (0.0, 0.0) then
        report complex_matrix_pkg'instance_name & "invert " &
          " Matrix is not invertible, Determinant = 0"
          severity error;
        result := zeros (2, 2);
      else
        prod          := 1.0/deter;
        result (0, 0) := arg (arg'high(1), arg'high(2)) * prod;
        result (0, 1) := -arg (arg'low(1), arg'high(2)) * prod;
        result (1, 0) := -arg (arg'high(1), arg'low(2)) * prod;
        result (1, 1) := arg (arg'low(1), arg'low(2)) * prod;
      end if;
    else
      -- reduce the matrix to a matrix of cofactors
      plus := true;
      for i in arg'range(1) loop
        for j in arg'range(2) loop
          reduced := exclude (arg, i, j);
          deter   := det (reduced);
          if plus then
            cofact (i-arg'low(1), j-arg'low(2)) := deter;
          else
            cofact (i-arg'low(1), j-arg'low(2)) := -deter;
          end if;
          plus := not plus;
        end loop;  -- j
      end loop;  -- i
      -- Find the determinant of the entire matrix.
      -- Since I already have a matrix of cofactors, I can just add it up.
      deter := zero;
      for j in arg'range(2) loop
        prod  := arg (arg'low(1), j) * cofact(0, j-arg'low(2));
        deter := deter + prod;
      end loop;  -- j
      if deter = zero then
        report complex_matrix_pkg'instance_name & "invert " &
          " Matrix is not invertible, Determinant = 0"
          severity error;
        result := zeros (result'length(1), result'length(2));
      else
        -- multiply the transposed cofactors by 1/determinant
        result := (1.0/deter) * transpose (cofact);
      end if;
    end if;
    return result;
  end function inv;

  function inv (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable i, j : INTEGER;            -- temp variables
    variable plus : BOOLEAN;            -- Used on the last sum
    variable reduced : complex_polar_matrix (0 to arg'length(1)-2,
                                             0 to arg'length(2)-2);  -- reduced matrix
    variable cofact : complex_polar_matrix (0 to arg'length(1)-1,
                                            0 to arg'length(2)-1);  -- minor matrix
    variable result : complex_polar_matrix (0 to arg'length(2)-1,
                                            0 to arg'length(1)-1);
    variable deter, prod : complex_polar;
    constant zero : complex_polar := (0.0, 0.0);
  begin  -- invert
    if isempty(arg) then
      null;
    elsif arg'length(1) /= arg'length(2) then
      report complex_matrix_pkg'instance_name & "invert " &
        " Matrix is not square " & INTEGER'image(arg'length(1)) &
        " /= " & INTEGER'image(arg'length(2)) severity error;
      result := zeros (result'length(1), result'length(2));
    elsif arg'length(1) = 1 then        -- 1x1 case
      if arg (arg'low(1), arg'low(2)) = zero then
        report complex_matrix_pkg'instance_name & "invert " &
          " Matrix is not invertible, Determinant = 0"
          severity error;
        result (0, 0) := zero;
      else
        result (0, 0) := 1.0 / arg(arg'low(1), arg'low(2));
      end if;
    elsif arg'length(1) = 2 then        -- 2x2 case
      deter := det (arg);
      if deter = zero then
        report complex_matrix_pkg'instance_name & "invert " &
          " Matrix is not invertible, Determinant = 0"
          severity error;
        result := zeros (2, 2);
      else
        prod          := 1.0/deter;
        result (0, 0) := arg (arg'high(1), arg'high(2)) * prod;
        result (0, 1) := -arg (arg'low(1), arg'high(2)) * prod;
        result (1, 0) := -arg (arg'high(1), arg'low(2)) * prod;
        result (1, 1) := arg (arg'low(1), arg'low(2)) * prod;
      end if;
    else
      -- reduce the matrix to a matrix of cofactors
      plus := true;
      for i in arg'range(1) loop
        for j in arg'range(2) loop
          reduced := exclude (arg, i, j);
          deter   := det (reduced);
          if plus then
            cofact (i-arg'low(1), j-arg'low(2)) := deter;
          else
            cofact (i-arg'low(1), j-arg'low(2)) := -deter;
          end if;
          plus := not plus;
        end loop;  -- j
      end loop;  -- i
      -- Find the determinant of the entire matrix.
      -- Since I already have a matrix of cofactors, I can just add it up.
      deter := zero;
      for j in arg'range(2) loop
        prod  := arg (arg'low(1), j) * cofact(0, j-arg'low(2));
        deter := deter + prod;
      end loop;  -- j
      if deter = zero then
        report complex_matrix_pkg'instance_name & "invert " &
          " Matrix is not invertible, Determinant = 0"
          severity error;
        result := zeros (result'length(1), result'length(2));
      else
        -- multiply the transposed cofactors by 1/determinant
        result := (1.0/deter) * transpose (cofact);
      end if;
    end if;
    return result;
  end function inv;

  -- Solve a linear equation
  -- This is done via the "lower triangle" method.
  function linsolve (
    l : complex_matrix;
    r : complex_vector)
    return complex_vector is
    -- Augmented matrix
    variable augmat : complex_matrix (0 to l'length(1)-1, 0 to l'length(2));
    variable result : complex_vector (0 to r'length-1);
    variable var    : COMPLEX;
    constant zero   : complex := (0.0, 0.0);
  begin
    if l'length(1) /= r'length then
      report complex_matrix_pkg'instance_name & "linsolve " &
        "Width of matrix does not equal length of vector "
        & INTEGER'image(l'length(2)) & " /= " &
        INTEGER'image(r'length) severity error;
      return r;
    else
      BuildMatrix (l, augmat, 0, 0);    -- Put matrix l at position 0,0
      -- Put vector r vertically at position 0,3
      InsertColumn (r, augmat, 0, l'length(2));
      -- Perform a "lower triangle" solution
      for j in 0 to l'length(2)-1 loop
        for i in 0 to l'length(1)-1 loop
          if i = j then
            -- divide this row by augmat(i,j)
            var := augmat (i, j);
            if var = zero then
              report complex_matrix_pkg'instance_name & "linsolve " &
                "Linear system has no solution" severity error;
              print_matrix (augmat);
              return r;
            end if;
            for k in j to l'length(2) loop
              augmat (i, k) := augmat (i, k)/var;
            end loop;
          elsif i > j then
            -- subtract last diagonal row *-(i,j)
            var := augmat(i, j);
            for k in j to l'length(2) loop
              augmat (i, k) := augmat (i, k) - (var * augmat (j, k));
            end loop;
          end if;
        end loop;
      end loop;
      -- reverse the diagonal to solve
      for k in result'range loop
        result(k) := augmat (k, augmat'high(2));
      end loop;
--      result := SubMatrix (augmat, 0, augmat'high(2), result'length, 1);
      for m in result'high-1 downto 0 loop
        for n in m+1 to l'length(1) -1 loop
          result(m) := result(m) - (augmat(m, n) * result(n));
        end loop;
      end loop;
      return result;
    end if;
    ---------------------------------------------------------------------------
    -- I could have done this as inv(l)*r, but this is faster.
    ---------------------------------------------------------------------------
  end function linsolve;

  -- Normalize a Matrix
  function normalize (
    arg           : complex_matrix;
    constant rval : REAL := 1.0)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(1)-1,
                                      0 to arg'length(2)-1);
    variable max : REAL;                -- largest number in this matrix
  begin
    if not isempty (arg) then
      max := abs(arg (arg'low(1), arg'low(2)));
      for i in arg'range(1) loop
        for j in arg'range(2) loop
          max := maximum (max, abs (arg(i, j)));
        end loop;
      end loop;
      result := arg * (rval/max);
    end if;
    return result;
  end function normalize;

  -- Normalize a Vector
  function normalize (
    arg           : complex_vector;
    constant rval : REAL := 1.0)
    return complex_vector is
    variable result : complex_vector (0 to arg'length-1);
    variable max    : REAL;             -- largest number in this matrix
  begin
    if not isempty (arg) then
      max := abs(arg (arg'low));
      for i in arg'range loop
        max := maximum (max, abs (arg(i)));
      end loop;
      result := arg * (rval/max);
    end if;
    return result;
  end function normalize;

  -- Solve a linear equation
  -- This is done via the "lower triangle" method.
  function linsolve (
    l : complex_polar_matrix;
    r : complex_polar_vector)
    return complex_polar_vector is
    -- Augmented matrix
    variable augmat : complex_polar_matrix (0 to l'length(1)-1, 0 to l'length(2));
    variable result : complex_polar_vector (0 to r'length-1);
    variable var    : COMPLEX_POLAR;
    constant zero   : COMPLEX_POLAR := (0.0, 0.0);
  begin
    if l'length(1) /= r'length then
      report complex_matrix_pkg'instance_name & "linsolve " &
        "Width of matrix does not equal length of vector "
        & INTEGER'image(l'length(2)) & " /= " &
        INTEGER'image(r'length) severity error;
      return r;
    else
      BuildMatrix (l, augmat, 0, 0);    -- Put matrix l at position 0,0
      -- Put vector r vertically at position 0,3
      InsertColumn (r, augmat, 0, l'length(2));
      -- Perform a "lower triangle" solution
      for j in 0 to l'length(2)-1 loop
        for i in 0 to l'length(1)-1 loop
          if i = j then
            -- divide this row by augmat(i,j)
            var := augmat (i, j);
            if var = zero then
              report complex_matrix_pkg'instance_name & "linsolve " &
                "Linear system has no solution" severity error;
              print_matrix (augmat);
              return r;
            end if;
            for k in j to l'length(2) loop
              augmat (i, k) := augmat (i, k)/var;
            end loop;
          elsif i > j then
            -- subtract last diagonal row *-(i,j)
            var := augmat(i, j);
            for k in j to l'length(2) loop
              augmat (i, k) := augmat (i, k) - (var * augmat (j, k));
            end loop;
          end if;
        end loop;
      end loop;
      -- reverse the diagonal to solve
      for k in result'range loop
        result(k) := augmat (k, augmat'high(2));
      end loop;
--      result := SubMatrix (augmat, 0, augmat'high(2), result'length, 1);
      for m in result'high-1 downto 0 loop
        for n in m+1 to l'length(1) -1 loop
          result(m) := result(m) - (augmat(m, n) * result(n));
        end loop;
      end loop;
      return result;
    end if;
    ---------------------------------------------------------------------------
    -- I could have done this as inv(l)*r, but this is faster.
    ---------------------------------------------------------------------------
  end function linsolve;

  -- Normalize a Matrix
  function normalize (
    arg           : complex_polar_matrix;
    constant rval : REAL := 1.0)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(1)-1,
                                            0 to arg'length(2)-1);
    variable max : REAL;                -- largest number in this matrix
  begin
    if not isempty (arg) then
      max := abs(arg (arg'low(1), arg'low(2)));
      for i in arg'range(1) loop
        for j in arg'range(2) loop
          max := maximum (max, abs (arg(i, j)));
        end loop;
      end loop;
      result := arg * (rval/max);
    end if;
    return result;
  end function normalize;

  -- Normalize a Vector
  function normalize (
    arg           : complex_polar_vector;
    constant rval : REAL := 1.0)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to arg'length-1);
    variable max    : REAL;             -- largest number in this matrix
  begin
    if not isempty (arg) then
      max := abs(arg (arg'low));
      for i in arg'range loop
        max := maximum (max, abs (arg(i)));
      end loop;
      result := arg * (rval/max);
    end if;
    return result;
  end function normalize;

  -----------------------------------------------------------------------------
  -- Functions parsing matrices
  -----------------------------------------------------------------------------

  -- purpose: Transpose a matrix (Similar to Matlab A' syntax)
  function transpose (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(2)-1,
                                      0 to arg'length(1)-1);
  begin  -- transpose
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg (j+arg'low(1), i+arg'low(2));
      end loop;  -- j
    end loop;  -- i
    return result;
  end function transpose;

  -- purpose: Transpose a matrix
  function transpose (
    arg : complex_vector)
    return complex_matrix is
    -- return a matrix with 1 column
    variable result : complex_matrix (0 to arg'length-1, 0 to 0);
  begin  -- transpose
    for i in result'range(1) loop
      result (i, 0) := arg (i+arg'low);
    end loop;  -- i
    return result;
  end function transpose;

    -- purpose: Transpose a matrix
  function transpose (
    arg : complex_matrix)
    return complex_vector is
    variable result : complex_vector (0 to arg'length(1)-1);
  begin  -- transpose
    if arg'length(2) /= 1 then
      report complex_matrix_pkg'instance_name &
        "Transpose (Matrix) return Vector: " &
        "input vector must have one column, found " &
        INTEGER'image(arg'length(2)) severity error;
    else
      for i in result'range loop
        result (i) := arg (i+arg'low(1), arg'low(2));
      end loop;  -- i
    end if;
    return result;
  end function transpose;

  function transpose (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(2)-1,
                                            0 to arg'length(1)-1);
  begin  -- transpose
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg (j+arg'low(1), i+arg'low(2));
      end loop;  -- j
    end loop;  -- i
    return result;
  end function transpose;

    -- purpose: Transpose a matrix
  function transpose (
    arg : complex_polar_vector)
    return complex_polar_matrix is
    -- return a matrix with 1 column
    variable result : complex_polar_matrix (0 to arg'length-1, 0 to 0);
  begin  -- transpose
    for i in result'range(1) loop
      result (i, 0) := arg (i+arg'low);
    end loop;  -- i
    return result;
  end function transpose;

    -- purpose: Transpose a matrix
  function transpose (
    arg : complex_polar_matrix)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to arg'length(1)-1);
  begin  -- transpose
    if arg'length(2) /= 1 then
      report complex_matrix_pkg'instance_name &
        "Transpose (Matrix) return Vector: " &
        "input vector must have one column, found " &
        INTEGER'image(arg'length(2)) severity error;
    else
      for i in result'range loop
        result (i) := arg (i+arg'low(1), arg'low(2));
      end loop;  -- i
    end if;
    return result;
  end function transpose;

  -- purpose: Complex Conjugate transpose a matrix (Similar to Matlab A' syntax)
  function ctranspose (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(2)-1,
                                      0 to arg'length(1)-1);
  begin  -- transpose
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := conj (arg (j+arg'low(1), i+arg'low(2)));
      end loop;  -- j
    end loop;  -- i
    return result;
  end function ctranspose;

    -- purpose: Transpose a matrix
  function ctranspose (
    arg : complex_vector)
    return complex_matrix is
    -- return a matrix with 1 column
    variable result : complex_matrix (0 to arg'length-1, 0 to 0);
  begin  -- ctranspose
    for i in result'range(1) loop
      result (i, 0) :=  conj (arg (i+arg'low));
    end loop;  -- i
    return result;
  end function ctranspose;

    -- purpose: Transpose a matrix
  function ctranspose (
    arg : complex_matrix)
    return complex_vector is
    variable result : complex_vector (0 to arg'length(1)-1);
  begin  -- transpose
    if arg'length(2) /= 1 then
      report complex_matrix_pkg'instance_name &
        "CTranspose (Matrix) return Vector: " &
        "input vector must have one column, found " &
        INTEGER'image(arg'length(2)) severity error;
    else
      for i in result'range loop
        result (i) :=  conj (arg (i+arg'low(1), arg'low(2)));
      end loop;  -- i
    end if;
    return result;
  end function ctranspose;

  function ctranspose (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(2)-1,
                                            0 to arg'length(1)-1);
  begin  -- transpose
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := conj (arg (j+arg'low(1), i+arg'low(2)));
      end loop;  -- j
    end loop;  -- i
    return result;
  end function ctranspose;

      -- purpose: Transpose a matrix
  function ctranspose (
    arg : complex_polar_vector)
    return complex_polar_matrix is
    -- return a matrix with 1 column
    variable result : complex_polar_matrix (0 to arg'length-1, 0 to 0);
  begin  -- ctranspose
    for i in result'range(1) loop
      result (i, 0) :=  conj (arg (i+arg'low));
    end loop;  -- i
    return result;
  end function ctranspose;

    -- purpose: Transpose a matrix
  function ctranspose (
    arg : complex_polar_matrix)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to arg'length(1)-1);
  begin  -- transpose
    if arg'length(2) /= 1 then
      report complex_matrix_pkg'instance_name &
        "CTranspose (Matrix) return Vector: " &
        "input vector must have one column, found " &
        INTEGER'image(arg'length(2)) severity error;
    else
      for i in result'range loop
        result (i) :=  conj (arg (i+arg'low(1), arg'low(2)));
      end loop;  -- i
    end if;
    return result;
  end function ctranspose;

  -- purpose: returns a matrix of zeros
  function zeros (
    rows, columns : NATURAL)
    return complex_matrix is
    constant zero : complex := (0.0, 0.0);
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  -- purpose: returns a matrix of zeros
  function zeros (
    rows, columns : NATURAL)
    return complex_vector is
    constant zero : complex := (0.0, 0.0);
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  function zeros (
    rows, columns : NATURAL)
    return complex_polar_matrix is
    constant zero : complex_polar := (0.0, 0.0);
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  -- purpose: returns a matrix of zeros
  function zeros (
    rows, columns : NATURAL)
    return complex_polar_vector is
    constant zero : complex_polar := (0.0, 0.0);
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  -- purpose: returns a matrix of ones
  function ones (
    rows, columns : NATURAL)
    return complex_matrix is
    constant one : complex := (1.0, 0.0);
  begin  -- ones
    return repmat (arg     => one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  -- purpose: returns a matrix of zeros
  function ones (
    rows, columns : NATURAL)
    return complex_vector is
    constant one : complex := (1.0, 0.0);
  begin  -- ones
    return repmat (arg     => one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  function ones (
    rows, columns : NATURAL)
    return complex_polar_matrix is
    constant one : complex_polar := (1.0, 0.0);
  begin  -- ones
    return repmat (arg     => one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  -- purpose: returns a matrix of zeros
  function ones (
    rows, columns : NATURAL)
    return complex_polar_vector is
    constant one : complex_polar := (1.0, 0.0);
  begin  -- ones
    return repmat (arg     => one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  -- purpose: Returns an identity matrix
  function eye (
    rows, columns : NATURAL)
    return complex_matrix is
    variable result : complex_matrix (0 to rows-1, 0 to columns-1);
  begin  -- eye
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := (1.0, 0.0);
        else
          result (i, j) := (0.0, 0.0);
        end if;
      end loop;  -- j
    end loop;  -- i
    return result;
  end function eye;

  function eye (
    rows, columns : NATURAL)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to rows-1, 0 to columns-1);
  begin  -- eye
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := (1.0, 0.0);
        else
          result (i, j) := (0.0, 0.0);
        end if;
      end loop;  -- j
    end loop;  -- i
    return result;
  end function eye;

  -- Concatenates two matrices together
  function cat (
    constant dim : POSITIVE;            -- 1 = y, 2 = x
    l, r         : complex_matrix)
    return complex_matrix is
  begin
    if dim = 1 then
      return vertcat (l, r);
    elsif dim = 2 then
      return horzcat (l, r);
    else
      report complex_matrix_pkg'instance_name & "cat " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return l;
    end if;
  end function cat;

  -- Concatenates two matrices together
  function horzcat (
    l, r : complex_matrix)
    return complex_matrix is
    variable rx : complex_matrix (0 to l'length(1)-1,
                                  0 to (l'length(2) + r'length(2)-1));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (1) = r'length(1) then
      for i in rx'range(1) loop
        for j in 0 to l'length(2)-1 loop
          rx (i, j) := l (i+l'low(1), j+l'low(2));
        end loop;
      end loop;
      for i in rx'range(1) loop
        for j in 0 to r'length(2)-1 loop
          rx (i, j+l'length(2)) := r (i+r'low(1), j+r'low(2));
        end loop;
      end loop;
    else
      report complex_matrix_pkg'instance_name & "horzcat " &
        "row dimension does not match " & INTEGER'image(l'length(1)) &
        " /= " & INTEGER'image(r'length(1)) severity error;
    end if;
    return rx;
  end function horzcat;

  -- Concatenates two matrices together
  function vertcat (
    l, r : complex_matrix)
    return complex_matrix is
    variable ry : complex_matrix (0 to (l'length(1) + r'length(1)-1),
                                  0 to l'length(2));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (2) = r'length(2) then
      for i in 0 to l'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i, j) := l (i+l'low(1), j+l'low(2));
        end loop;
      end loop;
      for i in 0 to r'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i+l'length(1), j) := r (i+r'low(1), j+r'low(2));
        end loop;
      end loop;
    else
      report complex_matrix_pkg'instance_name & "vertcat " &
        "column dimension does not match " & INTEGER'image(l'length(2)) &
        " /= " & INTEGER'image(r'length(2)) severity error;
    end if;
    return ry;
  end function vertcat;

  -- Flip the dimensions on a matrix
  function flipdim (
    arg          : complex_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return complex_matrix is
  begin
    if dim = 1 then
      return flipup (arg);
    elsif dim = 2 then
      return fliplr (arg);
    else
      report complex_matrix_pkg'instance_name & "flipdim " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return arg;
    end if;
  end function flipdim;

  -- flip left to right
  function fliplr (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(1)-1,
                                      0 to arg'length(2)-1);
    variable i, j : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg (arg'low(1)+i, arg'high(2)-j);
      end loop;
    end loop;
    return result;
  end function fliplr;

  -- Flip up and down
  function flipup (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(1)-1, 0 to arg'length(2)-1);
    variable i, j   : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg (arg'high(1)-i, arg'low(2)+j);
      end loop;
    end loop;
    return result;
  end function flipup;

  -- flip a vector
  function fliplr (
    arg : complex_vector)
    return complex_vector is
    variable result : complex_vector (0 to arg'length-1);
    variable i      : INTEGER;
  begin
    for i in result'range(1) loop
      result (i) := arg (arg'high-i);
    end loop;
    return result;
  end function fliplr;

  -- Matrix rotation
  function rot90 (
    arg          : complex_matrix;
    constant dim : INTEGER := 1)
    return complex_matrix is
    variable rx   : complex_matrix (0 to arg'length(1)-1, 0 to arg'length(2)-1);
    variable ry   : complex_matrix (0 to arg'length(2)-1, 0 to arg'length(1)-1);
    variable i, j : INTEGER;
  begin
    if dim = 1 or dim = -3 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := arg (arg'low(1)+j, arg'high(2)-i);
        end loop;
      end loop;
      return ry;
    elsif dim = 2 or dim = -2 then
      for i in rx'range(1) loop
        for j in rx'range(2) loop
          rx (i, j) := arg (arg'high(1)-i, arg'high(2)-j);
        end loop;
      end loop;
      return rx;
    elsif dim = 3 or dim = -1 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := arg (arg'high(1)-j, arg'low(2)+i);
        end loop;
      end loop;
      return ry;
    else
      return arg;
    end if;
  end function rot90;

  -- Concatenates two matrices together
  function cat (
    constant dim : POSITIVE;            -- 1 = y, 2 = x
    l, r         : complex_polar_matrix)
    return complex_polar_matrix is
  begin
    if dim = 1 then
      return vertcat (l, r);
    elsif dim = 2 then
      return horzcat (l, r);
    else
      report complex_matrix_pkg'instance_name & "cat " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return l;
    end if;
  end function cat;

  -- Concatenates two matrices together
  function horzcat (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
    variable rx : complex_polar_matrix (0 to l'length(1)-1,
                                        0 to (l'length(2) + r'length(2)-1));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (1) = r'length(1) then
      for i in rx'range(1) loop
        for j in 0 to l'length(2)-1 loop
          rx (i, j) := l (i+l'low(1), j+l'low(2));
        end loop;
      end loop;
      for i in rx'range(1) loop
        for j in 0 to r'length(2)-1 loop
          rx (i, j+l'length(2)) := r (i+r'low(1), j+r'low(2));
        end loop;
      end loop;
    else
      report complex_matrix_pkg'instance_name & "horzcat " &
        "row dimension does not match " & INTEGER'image(l'length(1)) &
        " /= " & INTEGER'image(r'length(1)) severity error;
    end if;
    return rx;
  end function horzcat;

  -- Concatenates two matrices together
  function vertcat (
    l, r : complex_polar_matrix)
    return complex_polar_matrix is
    variable ry : complex_polar_matrix (0 to (l'length(1) + r'length(1)-1),
                                        0 to l'length(2));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (2) = r'length(2) then
      for i in 0 to l'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i, j) := l (i+l'low(1), j+l'low(2));
        end loop;
      end loop;
      for i in 0 to r'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i+l'length(1), j) := r (i+r'low(1), j+r'low(2));
        end loop;
      end loop;
    else
      report complex_matrix_pkg'instance_name & "vertcat " &
        "column dimension does not match " & INTEGER'image(l'length(2)) &
        " /= " & INTEGER'image(r'length(2)) severity error;
    end if;
    return ry;
  end function vertcat;

  -- Flip the dimensions on a matrix
  function flipdim (
    arg          : complex_polar_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return complex_polar_matrix is
  begin
    if dim = 1 then
      return flipup (arg);
    elsif dim = 2 then
      return fliplr (arg);
    else
      report complex_matrix_pkg'instance_name & "flipdim " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return arg;
    end if;
  end function flipdim;

  -- flip left to right
  function fliplr (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(1)-1,
                                            0 to arg'length(2)-1);
    variable i, j : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg (arg'low(1)+i, arg'high(2)-j);
      end loop;
    end loop;
    return result;
  end function fliplr;

  -- Flip up and down
  function flipup (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(1)-1, 0 to arg'length(2)-1);
    variable i, j   : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg (arg'high(1)-i, arg'low(2)+j);
      end loop;
    end loop;
    return result;
  end function flipup;

  -- flip a vector
  function fliplr (
    arg : complex_polar_vector)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to arg'length-1);
    variable i      : INTEGER;
  begin
    for i in result'range(1) loop
      result (i) := arg (arg'high-i);
    end loop;
    return result;
  end function fliplr;

  -- Matrix rotation
  function rot90 (
    arg          : complex_polar_matrix;
    constant dim : INTEGER := 1)
    return complex_polar_matrix is
    variable rx   : complex_polar_matrix (0 to arg'length(1)-1, 0 to arg'length(2)-1);
    variable ry   : complex_polar_matrix (0 to arg'length(2)-1, 0 to arg'length(1)-1);
    variable i, j : INTEGER;
  begin
    if dim = 1 or dim = -3 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := arg (arg'low(1)+j, arg'high(2)-i);
        end loop;
      end loop;
      return ry;
    elsif dim = 2 or dim = -2 then
      for i in rx'range(1) loop
        for j in rx'range(2) loop
          rx (i, j) := arg (arg'high(1)-i, arg'high(2)-j);
        end loop;
      end loop;
      return rx;
    elsif dim = 3 or dim = -1 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := arg (arg'high(1)-j, arg'low(2)+i);
        end loop;
      end loop;
      return ry;
    else
      return arg;
    end if;
  end function rot90;

  -- Creates a matrix set to the value "val"
  function repmat (
    arg                    : complex;
    constant rows, columns : NATURAL)
    return complex_matrix is
    variable result : complex_matrix (0 to rows-1, 0 to columns-1);
  begin  -- ones
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg;
      end loop;  -- j
    end loop;  -- i
    return result;
  end function repmat;

  -- Creates a matrix set to the value "val"
  function repmat (
    arg                    : complex;
    constant rows, columns : NATURAL)
    return complex_vector is
    variable result : complex_vector (0 to columns-1);
  begin  -- ones
    if rows /= 1 then
      report complex_matrix_pkg'instance_name & "repmat" &
        " return vector, number of rows not 1, was " &
        INTEGER'image(rows) severity error;
    else
      for i in 0 to result'high loop
        result (i) := arg;
      end loop;  -- i
    end if;
    return result;
  end function repmat;

  -- Creates a matrix set to the value "val"
  function repmat (
    arg                    : complex_polar;
    constant rows, columns : NATURAL)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to rows-1, 0 to columns-1);
  begin  -- ones
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg;
      end loop;  -- j
    end loop;  -- i
    return result;
  end function repmat;

  -- Creates a matrix set to the value "val"
  function repmat (
    arg                    : complex_polar;
    constant rows, columns : NATURAL)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to columns-1);
  begin  -- ones
    if rows /= 1 then
      report complex_matrix_pkg'instance_name & "repmat" &
        " return vector, number of rows not 1, was " &
        INTEGER'image(rows) severity error;
    else
      for i in 0 to result'high loop
        result (i) := arg;
      end loop;  -- i
    end if;
    return result;
  end function repmat;

  -----------------------------------------------------------------------------
  -- These functions allow you to do matrix and vector slicing
  -----------------------------------------------------------------------------

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : complex_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return complex_matrix is
    variable result : complex_matrix (0 to rows-1, 0 to columns-1);
  begin
    if arg'length(1)-x < rows or arg'length(2)-y < columns then
      report complex_matrix_pkg'instance_name & "SubMatrix " &
        "Matrix size does not match, can not extract a (" &
        INTEGER'image(rows) & "," & INTEGER'image(columns) &
        ") matrix from a (" & INTEGER'image (arg'length(1)-x) & "," &
        INTEGER'image (arg'length(2)-y) & ") matrix"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := arg (x + i, y + j);
        end loop;
      end loop;
    end if;
    return result;
  end function SubMatrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : complex_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return complex_vector is
    variable result2 : complex_vector (0 to columns-1);
  begin
    if rows /= 1 then
      report complex_matrix_pkg'instance_name & "SubMatrix " &
        "Vector version can only have 1 row.  Number of rows entered was "
        & INTEGER'image(rows) severity error;
    elsif arg'length(2)-y < columns then
      report complex_matrix_pkg'instance_name & "SubMatrix " &
        "Vector length does not match " & INTEGER'image (arg'length(2)-y) &
        " /= " & INTEGER'image(columns)
        severity error;
    else
      for i in result2'range loop
        result2 (i) := arg (x, y+i);
      end loop;
    end if;
    return result2;
  end function SubMatrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  procedure BuildMatrix (
    arg           : in    complex_matrix;
    result        : inout complex_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report complex_matrix_pkg'instance_name & "BuildMatrix " &
--        "arg input was an empty matrix"
--        severity error;
      return;
    elsif isempty(result) then
--      report complex_matrix_pkg'instance_name & "BuildMatrix " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif (arg'length(1) > result'length(1)-(x-result'low(1))) or
      (arg'length(2) > result'length(2)-(y-result'low(2))) then
      report complex_matrix_pkg'instance_name & "BuildMatrix " &
        "Dimensions of arg (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ") > result range (" &
        INTEGER'image(result'high(1)-(x-result'low(1))) & "," &
        INTEGER'image(result'high(2)-(y-result'low(2))) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length(1)-1 loop
        for j in 0 to arg'length(2)-1 loop
          result (x+i, y+j) := arg (i+arg'low(1), j+arg'low(2));
        end loop;
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    complex_vector;
    result        : inout complex_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report complex_matrix_pkg'instance_name & "BuildMatrix " &
--        "arg input was an empty vector"
--        severity error;
      return;
    elsif isempty(result) then
--      report complex_matrix_pkg'instance_name & "BuildMatrix " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif arg'length > result'length(2)-(y-result'low(2)) then
      report complex_matrix_pkg'instance_name & "BuildMatrix " &
        "Dimension of arg(" & INTEGER'image(arg'length) &
        ") larger than result (" & INTEGER'image(x) & "," &
        INTEGER'image(result'length(2)-(y-result'low(2))) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x, y+i) := arg (i+arg'low);
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    complex_vector;
    result        : inout complex_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report complex_matrix_pkg'instance_name & "InsertColumn " &
--        "arg input was an empty vector"
--        severity error;
      return;
    elsif isempty(result) then
--      report complex_matrix_pkg'instance_name & "InsertColumn " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif arg'length > result'length(1)-(x-result'low(1)) then
      report complex_matrix_pkg'instance_name & "InsertColumn " &
        "Dimension of arg(" & INTEGER'image(arg'length) &
        ") larger than result (" &
        INTEGER'image(result'length(1)-(x-result'low(1))) & "," &
        INTEGER'image(y) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x+i, y) := arg (i+arg'low);
      end loop;
    end if;
  end procedure InsertColumn;

  -- purpose: SubMatrix returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : complex_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return complex_matrix is
    variable i, j, k, l : INTEGER;      -- loop variables
    variable result : complex_matrix (0 to arg'length(1)-2,
                                      0 to arg'length(2)-2);  -- SubMatrix
  begin  -- SubMatrix
    if arg'length(1) < 3 then
      report complex_matrix_pkg'instance_name & "exclude " &
        "arg is smaller than 3x3" severity error;
    else
      k := 0;
      l := 0;
      for i in arg'low(1) to arg'high(1) loop
        for j in arg'low(2) to arg'high(2) loop
          if not (i = row or j = column) then  -- exclude this row/column
            result (k, l) := arg (i, j);
            if l = result'high(2) then
              k := k + 1;
              l := 0;
            else
              l := l + 1;
            end if;
          end if;
        end loop;  -- j
      end loop;  -- i      
    end if;
    return result;
  end function exclude;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : complex_polar_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to rows-1, 0 to columns-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg (x + i, y + j);
      end loop;
    end loop;
    return result;
  end function SubMatrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : complex_polar_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return complex_polar_vector is
    variable result2 : complex_polar_vector (0 to columns-1);
  begin
    if rows /= 1 then
      report complex_matrix_pkg'instance_name & "SubMatrix " &
        "Vector version can only have 1 row.  Number of rows entered was "
        & INTEGER'image(rows) severity error;
    elsif arg'length(2)-y < columns then
      report complex_matrix_pkg'instance_name & "SubMatrix " &
        "Vector length does not match " & INTEGER'image (arg'length(2)-y) &
        " /= " & INTEGER'image(columns)
        severity error;
    else
      for i in result2'range loop
        result2 (i) := arg (x, y+i);
      end loop;
    end if;
    return result2;
  end function SubMatrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  procedure BuildMatrix (
    arg           : in    complex_polar_matrix;
    result        : inout complex_polar_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) or isempty(result) then
      return;
    else
      for i in 0 to arg'length(1)-1 loop
        for j in 0 to arg'length(2)-1 loop
          result (x+i, y+j) := arg (i+arg'low(1), j+arg'low(2));
        end loop;
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    complex_polar_vector;
    result        : inout complex_polar_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) or isempty(result) then
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x, y+i) := arg (i+arg'low);
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    complex_polar_vector;
    result        : inout complex_polar_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) or isempty(result) then
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x+i, y) := arg (i+arg'low);
      end loop;
    end if;
  end procedure InsertColumn;

  -- purpose: SubMatrix returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : complex_polar_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return complex_polar_matrix is
    variable i, j, k, l : INTEGER;      -- loop variables
    variable result : complex_polar_matrix (0 to arg'length(1)-2,
                                            0 to arg'length(2)-2);  -- SubMatrix
  begin  -- SubMatrix
    if arg'length(1) < 3 then
      report complex_matrix_pkg'instance_name & "exclude " &
        "arg is smaller than 3x3" severity error;
    else
      k := 0;
      l := 0;
      for i in arg'low(1) to arg'high(1) loop
        for j in arg'low(2) to arg'high(2) loop
          if not (i = row or j = column) then  -- exclude this row/column
            result (k, l) := arg (i, j);
            if l = result'high(2) then
              k := k + 1;
              l := 0;
            else
              l := l + 1;
            end if;
          end if;
        end loop;  -- j
      end loop;  -- i      
    end if;
    return result;
  end function exclude;

  -- Change the shape of a matrix
  function reshape (
    arg                    : complex_matrix;
    constant rows, columns : POSITIVE)
    return complex_matrix is
    variable result     : complex_matrix (0 to rows-1, 0 to columns-1);  -- result
    variable i, j, k, l : INTEGER;
  begin
    if arg'length(1)*arg'length(2) < rows*columns then
      report complex_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
        "," & INTEGER'image(arg'length(2)) & ") < result (" &
        INTEGER'image(rows) & "," & INTEGER'image(columns) & ")"
        severity error;
      return result;
    else
      k := arg'low(1);
      l := arg'low(2);
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := arg (k, l);
          if k = arg'high(1) then
            k := arg'low(1);
            l := l + 1;
          else
            k := k + 1;
          end if;
        end loop;
      end loop;
      return result;
    end if;
  end function reshape;

  -- Change the shape of a matrix
  function reshape (
    arg                    : complex_vector;
    constant rows, columns : POSITIVE)
    return complex_matrix is
    variable result  : complex_matrix (0 to rows-1, 0 to columns-1);  -- result
    variable i, j, k : INTEGER;
  begin
    if arg'length < rows*columns then
      report complex_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length) &
        ") < result (" & INTEGER'image(rows) & "," &
        INTEGER'image(columns) & ")"
        severity error;
      return result;
    else
      k := arg'low;
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := arg (k);
          k             := k + 1;
        end loop;
      end loop;
      return result;
    end if;
  end function reshape;

  function reshape (
    arg           : complex_matrix;
    rows, columns : POSITIVE)
    return complex_vector is
    variable rx         : complex_vector (0 to rows-1);
    variable ry         : complex_vector (0 to columns-1);
    variable i, j, k, l : INTEGER;
  begin
    if rows = 1 then
      if arg'length(1) * arg'length(2) < ry'length then
        report complex_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (ry'length) & ")"
          severity error;
        return ry;
      else
        k := arg'low(2);
        l := arg'low(1);
        for j in ry'range loop
          ry (j) := arg (l, k);
          if k = arg'high(2) then
            k := arg'low(2);
            l := l + 1;
          else
            k := k + 1;
          end if;
        end loop;
        return ry;
      end if;
    elsif columns = 1 then
      if arg'length(1) * arg'length(2) < rx'length then
        report complex_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (rx'length) & ")"
          severity error;
        return rx;
      else
        k := arg'low(1);
        l := arg'low(2);
        for j in rx'range loop
          rx (j) := arg (k, l);
          if k = arg'high(1) then
            k := arg'low(1);
            l := l + 1;
          else
            k := k + 1;
          end if;
        end loop;
        return rx;
      end if;
    else
      report complex_matrix_pkg'instance_name & "reshape " &
        "rows or columns need to be 1 got " & INTEGER'image(rows) & "," &
        INTEGER'image(columns) severity error;
      return rx;
    end if;
  end function reshape;

  -- Change the shape of a matrix
  function reshape (
    arg                    : complex_polar_matrix;
    constant rows, columns : POSITIVE)
    return complex_polar_matrix is
    variable result     : complex_polar_matrix (0 to rows-1, 0 to columns-1);  -- result
    variable i, j, k, l : INTEGER;
  begin
    if arg'length(1)*arg'length(2) < rows*columns then
      report complex_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
        "," & INTEGER'image(arg'length(2)) & ") < result (" &
        INTEGER'image(rows) & "," & INTEGER'image(columns) & ")"
        severity error;
      return result;
    else
      k := arg'low(1);
      l := arg'low(2);
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := arg (k, l);
          if k = arg'high(1) then
            k := arg'low(1);
            l := l + 1;
          else
            k := k + 1;
          end if;
        end loop;
      end loop;
      return result;
    end if;
  end function reshape;

  -- Change the shape of a matrix
  function reshape (
    arg                    : complex_polar_vector;
    constant rows, columns : POSITIVE)
    return complex_polar_matrix is
    variable result  : complex_polar_matrix (0 to rows-1, 0 to columns-1);  -- result
    variable i, j, k : INTEGER;
  begin
    if arg'length < rows*columns then
      report complex_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length) &
        ") < result (" & INTEGER'image(rows) & "," &
        INTEGER'image(columns) & ")"
        severity error;
      return result;
    else
      k := arg'low;
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := arg (k);
          k             := k + 1;
        end loop;
      end loop;
      return result;
    end if;
  end function reshape;

  function reshape (
    arg           : complex_polar_matrix;
    rows, columns : POSITIVE)
    return complex_polar_vector is
    variable rx         : complex_polar_vector (0 to rows-1);
    variable ry         : complex_polar_vector (0 to columns-1);
    variable i, j, k, l : INTEGER;
  begin
    if rows = 1 then
      if arg'length(1) * arg'length(2) < ry'length then
        report complex_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (ry'length) & ")"
          severity error;
        return ry;
      else
        k := arg'low(2);
        l := arg'low(1);
        for j in ry'range loop
          ry (j) := arg (l, k);
          if k = arg'high(2) then
            k := arg'low(2);
            l := l + 1;
          else
            k := k + 1;
          end if;
        end loop;
        return ry;
      end if;
    elsif columns = 1 then
      if arg'length(1) * arg'length(2) < rx'length then
        report complex_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (rx'length) & ")"
          severity error;
        return rx;
      else
        k := arg'low(1);
        l := arg'low(2);
        for j in rx'range loop
          rx (j) := arg (k, l);
          if k = arg'high(1) then
            k := arg'low(1);
            l := l + 1;
          else
            k := k + 1;
          end if;
        end loop;
        return rx;
      end if;
    else
      report complex_matrix_pkg'instance_name & "reshape " &
        "rows or columns need to be 1 got " & INTEGER'image(rows) & "," &
        INTEGER'image(columns) severity error;
      return rx;
    end if;
  end function reshape;


  -- returns the size of a matrix
  function size (
    arg : complex_matrix)
    return integer_vector is
    variable result : integer_vector (0 to 1);
  begin
    result (0) := arg'length(1);
    result (1) := arg'length(2);
    return result;
  end function size;

  -- True if matrix is one dimensional
  function isvector (
    arg : complex_matrix)
    return BOOLEAN is
  begin
    if arg'length(1) = 1 or arg'length(2) = 1 then
      return true;
    else
      return false;
    end if;
  end function isvector;

  -- True if a 1/1 matrix
  function isscalar (
    arg : complex_matrix)
    return BOOLEAN is
  begin
    if arg'length(1) = 1 and arg'length(2) = 1 then
      return true;
    else
      return false;
    end if;
  end function isscalar;

  -- returns the number of elements in a matrix
  function numel (
    arg : complex_matrix)
    return INTEGER is
  begin
    if isempty (arg) then
      return 0;
    else
      return arg'length(1) * arg'length(2);
    end if;
  end function numel;

  -- Return the diagonal of a matrix
  function diag (
    arg : complex_matrix)
    return complex_vector is
    variable result : complex_vector (0 to minimum (arg'length(2),
                                                    arg'length(1)) - 1);
  begin
    for i in result'range loop
      result (i) := arg (i+arg'low(1), i+arg'low(2));
    end loop;
    return result;
  end function diag;

  -- Return a matrix with the vector as the diagonal
  function diag (
    arg : complex_vector)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length-1, 0 to arg'length-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := arg (i+arg'low);
        else
          result (i, j) := (0.0, 0.0);
        end if;
      end loop;
    end loop;
    return result;
  end function diag;

  -- Return the matrix of a diagonal
  function blkdiag (
    arg : complex_vector)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length-1, 0 to arg'length-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := arg (i+arg'low);
        else
          result (i, j) := (0.0, 0.0);
        end if;
      end loop;
    end loop;
    return result;
  end function blkdiag;

  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  -- This differs from the function of "blkdiag" in Matlab
  function blockdiag (
    arg : complex_matrix;
    rep : POSITIVE)
    return complex_matrix is
    variable result : complex_matrix (0 to (arg'length(1)*rep)-1,
                                      0 to (arg'length(2)*rep)-1);
    constant zero : complex := (0.0, 0.0);
  begin
    -- Zero out the result matrix
    result := repmat (zero, arg'length(1)*rep, arg'length(2)*rep);
    -- Fill in across the diagonal
    for k in 0 to rep-1 loop
      for m in 0 to arg'length(1)-1 loop
        for n in 0 to arg'length(2)-1 loop
          result ((k*arg'length(1))+m, (k*arg'length(2))+n) :=
            arg (m+arg'low(1), n+arg'low(2));
        end loop;
      end loop;
    end loop;
    return result;
  end function blockdiag;

  -- Replicate a matrix row/column times
  function repmat (
    arg                    : complex_matrix;
    constant rows, columns : NATURAL)
    return complex_matrix is
    variable result : complex_matrix (0 to (arg'length(1)*rows)-1,
                                      0 to (arg'length(2)*columns)-1);
    variable i, j, m, n : INTEGER;      -- index variables
  begin
    m := 0;
    n := 0;
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg (m+arg'low(1), n+arg'low(2));
        if n = arg'length(2)-1 then
          n := 0;
        else
          n := n + 1;
        end if;
      end loop;
      if m = arg'length(1)-1 then
        m := 0;
      else
        m := m + 1;
      end if;
    end loop;
    return result;
  end function repmat;

  -- Return the lower triangle of a matrix
  function tril (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(1)-1,
                                      0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i > j then
          result (i, j) := arg (i+ arg'low(1), j+arg'low(2));
        else
          result (i, j) := (0.0, 0.0);
        end if;
      end loop;
    end loop;
    return result;
  end function tril;

  -- Return the upper triangle of a matrix
  function triu (
    arg : complex_matrix)
    return complex_matrix is
    variable result : complex_matrix (0 to arg'length(1)-1,
                                      0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i < j then
          result (i, j) := arg (i+ arg'low(1), j+arg'low(2));
        else
          result (i, j) := (0.0, 0.0);
        end if;
      end loop;
    end loop;
    return result;
  end function triu;

  -- returns the size of a matrix
  function size (
    arg : complex_polar_matrix)
    return integer_vector is
    variable result : integer_vector (0 to 1);
  begin
    result (0) := arg'length(1);
    result (1) := arg'length(2);
    return result;
  end function size;

  -- True if matrix is one dimensional
  function isvector (
    arg : complex_polar_matrix)
    return BOOLEAN is
  begin
    if arg'length(1) = 1 or arg'length(2) = 1 then
      return true;
    else
      return false;
    end if;
  end function isvector;

  -- True if a 1/1 matrix
  function isscalar (
    arg : complex_polar_matrix)
    return BOOLEAN is
  begin
    if arg'length(1) = 1 and arg'length(2) = 1 then
      return true;
    else
      return false;
    end if;
  end function isscalar;

  -- returns the number of elements in a matrix
  function numel (
    arg : complex_polar_matrix)
    return INTEGER is
  begin
    if isempty (arg) then
      return 0;
    else
      return arg'length(1) * arg'length(2);
    end if;
  end function numel;

  -- Return the diagonal of a matrix
  function diag (
    arg : complex_polar_matrix)
    return complex_polar_vector is
    variable result : complex_polar_vector (0 to minimum (arg'length(2),
                                                          arg'length(1))-1);
  begin
    for i in result'range loop
      result (i) := arg (i+arg'low(1), i+arg'low(2));
    end loop;
    return result;
  end function diag;

  -- Return a matrix with the vector as the diagonal
  function diag (
    arg : complex_polar_vector)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length-1,
                                            0 to arg'length-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := arg (i+arg'low);
        else
          result (i, j) := (0.0, 0.0);
        end if;
      end loop;
    end loop;
    return result;
  end function diag;

  -- Return the matrix of a diagonal
  function blkdiag (
    arg : complex_polar_vector)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length-1,
                                            0 to arg'length-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := arg (i+arg'low);
        else
          result (i, j) := (0.0, 0.0);
        end if;
      end loop;
    end loop;
    return result;
  end function blkdiag;

  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  -- This differs from the function of "blkdiag" in Matlab
  function blockdiag (
    arg : complex_polar_matrix;
    rep : POSITIVE)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to (arg'length(1)*rep)-1,
                                            0 to (arg'length(2)*rep)-1);
    constant zero : complex_polar := (0.0, 0.0);
  begin
    -- Zero out the result matrix
    result := repmat (zero, arg'length(1)*rep, arg'length(2)*rep);
    -- Fill in across the diagonal
    for k in 0 to rep-1 loop
      for m in 0 to arg'length(1)-1 loop
        for n in 0 to arg'length(2)-1 loop
          result ((k*arg'length(1))+m, (k*arg'length(2))+n) :=
            arg (m+arg'low(1), n+arg'low(2));
        end loop;
      end loop;
    end loop;
    return result;
  end function blockdiag;

  -- Replicate a matrix row/column times
  function repmat (
    arg                    : complex_polar_matrix;
    constant rows, columns : NATURAL)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to (arg'length(1)*rows)-1,
                                            0 to (arg'length(2)*columns)-1);
    variable i, j, m, n : INTEGER;      -- index variables
  begin
    m := 0;
    n := 0;
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := arg (m+arg'low(1), n+arg'low(2));
        if n = arg'length(2)-1 then
          n := 0;
        else
          n := n + 1;
        end if;
      end loop;
      if m = arg'length(1)-1 then
        m := 0;
      else
        m := m + 1;
      end if;
    end loop;
    return result;
  end function repmat;

  -- Return the lower triangle of a matrix
  function tril (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(1)-1,
                                            0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i > j then
          result (i, j) := arg (i+ arg'low(1), j+arg'low(2));
        else
          result (i, j) := (0.0, 0.0);
        end if;
      end loop;
    end loop;
    return result;
  end function tril;

  -- Return the upper triangle of a matrix
  function triu (
    arg : complex_polar_matrix)
    return complex_polar_matrix is
    variable result : complex_polar_matrix (0 to arg'length(1)-1,
                                            0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i < j then
          result (i, j) := arg (i+ arg'low(1), j+arg'low(2));
        else
          result (i, j) := (0.0, 0.0);
        end if;
      end loop;
    end loop;
    return result;
  end function triu;

  -----------------------------------------------------------------------------
  -- Text IO functions
  -----------------------------------------------------------------------------

  -- This alias is in VHDL-2008 std.textio
  alias SWRITE is WRITE [LINE, STRING, SIDE, WIDTH];

  -- Since there is no textio for the math_complex package, put it here.
  function to_string (
    value : complex)
    return STRING is
    variable L : LINE;
  begin
    write (L      => L,
           value  => value.RE,
           digits => 4);
    swrite (L, " ");
    write (L      => L,
           value  => value.IM,
           digits => 4);
    swrite (L, "i");
    return L.all;
  end function to_string;

  function to_string (
    value : complex_polar)
    return STRING is
    variable L : LINE;
  begin
    write (L      => L,
           value  => value.MAG,
           digits => 4);
    swrite (L, " ");
    write (L      => L,
           value  => value.ARG,
           digits => 4);
    swrite (L, "j");
    return L.all;
  end function to_string;

  function to_string (
    value : complex_vector)
    return STRING is
    variable L : LINE;
  begin
    for i in value'range loop
      write (L      => L,
             value  => value (i).RE,
             digits => 4);
      swrite (L, " ");
      write (L      => L,
             value  => value (i).IM,
             digits => 4);
      swrite (L, "i ");
    end loop;  -- i
    return L.all;
  end function to_string;

  function to_string (
    value : complex_matrix)
    return STRING is
    variable L : LINE;
  begin
    for i in value'range(1) loop
      for j in value'range(2) loop
        write (L      => L,
               value  => value (i, j).RE,
               digits => 4);
        swrite (L, " ");
        write (L      => L,
               value  => value (i, j).IM,
               digits => 4);
        swrite (L, "i ");
      end loop;  -- j
      if i /= value'high(1) then
        write (L, CR);
      end if;
    end loop;  -- i
    return L.all;
  end function to_string;

  function to_string (
    value : complex_polar_vector)
    return STRING is
    variable L : LINE;
  begin
    for i in value'range loop
      write (L      => L,
             value  => value (i).MAG,
             digits => 4);
      swrite (L, " ");
      write (L      => L,
             value  => value (i).ARG,
             digits => 4);
      swrite (L, "j ");
    end loop;  -- i
    return L.all;
  end function to_string;

  function to_string (
    value : complex_polar_matrix)
    return STRING is
    variable L : LINE;                  -- output line
  begin
    for i in value'range(1) loop
      for j in value'range(2) loop
        write (L      => L,
               value  => value (i, j).MAG,
               digits => 4);
        swrite (L, " ");
        write (L      => L,
               value  => value (i, j).ARG,
               digits => 4);
        swrite (L, "j ");
      end loop;  -- j
      if i /= value'high(1) then
        write (L, CR);
      end if;
    end loop;  -- i
    return L.all;
  end function to_string;

  procedure write (
    L      : inout LINE;
    VALUE  : in    complex;
    DIGITS : in    POSITIVE := 4) is
  begin
    write (L      => L,
           value  => value.RE,
           digits => DIGITS);
    swrite (L, " ");
    write (L      => L,
           value  => value.IM,
           digits => DIGITS);
    swrite (L, "i");
  end procedure write;

  procedure write (
    L      : inout LINE;
    VALUE  : in    complex_polar;
    DIGITS : in    POSITIVE := 4) is
  begin
    write (L      => L,
           value  => value.MAG,
           digits => DIGITS);
    swrite (L, " ");
    write (L      => L,
           value  => value.ARG,
           digits => DIGITS);
    swrite (L, "j");
  end procedure write;
  
  procedure write (
    L      : inout LINE;
    VALUE  : in    complex_vector;
    DIGITS : in    POSITIVE := 4) is
  begin
    swrite (L, "( ");
    for i in VALUE'range loop
      write (L      => L,
             value  => value (i).RE,
             digits => DIGITS);
      swrite (L, " ");
      write (L      => L,
             value  => value (i).IM,
             digits => DIGITS);
      if i /= VALUE'high then
        swrite (L, "i, ");
      else
        swrite (L, "i ");
      end if;
    end loop;
    swrite (L, " )");
  end procedure write;

  procedure write (
    L      : inout LINE;
    VALUE  : in    complex_matrix;
    DIGITS : in    POSITIVE := 4) is
  begin
    swrite (L, "( ");
    for i in VALUE'range(1) loop
      swrite (L, "( ");
      for j in VALUE'range(2) loop
        write (L      => L,
               value  => value (i, j).RE,
               digits => DIGITS);
        swrite (L, " ");
        write (L      => L,
               value  => value (i, j).IM,
               digits => DIGITS);
        if i /= VALUE'high(2) then
          swrite (L, "i, ");
        else
          swrite (L, "i ");
        end if;
      end loop;
      if i /= VALUE'high(1) then
        swrite (L, " ),");
      else
        swrite (L, " )");
      end if;
    end loop;
    swrite (L, " )");
  end procedure write;
  
  procedure write (
    L      : inout LINE;
    VALUE  : in    complex_polar_vector;
    DIGITS : in    POSITIVE := 4) is
  begin
    swrite (L, "( ");
    for i in VALUE'range loop
      write (L      => L,
             value  => value (i).MAG,
             digits => DIGITS);
      swrite (L, " ");
      write (L      => L,
             value  => value (i).ARG,
             digits => DIGITS);
      if i /= VALUE'high then
        swrite (L, "j, ");
      else
        swrite (L, "j ");
      end if;
    end loop;
    swrite (L, " )");
  end procedure write;

  procedure write (
    L      : inout LINE;
    VALUE  : in    complex_polar_matrix;
    DIGITS : in    POSITIVE := 4) is
  begin
    swrite (L, "( ");
    for i in VALUE'range(1) loop
      swrite (L, "( ");
      for j in VALUE'range(2) loop
        write (L      => L,
               value  => value (i, j).MAG,
               digits => DIGITS);
        swrite (L, " ");
        write (L      => L,
               value  => value (i, j).ARG,
               digits => DIGITS);
        if i /= VALUE'high(2) then
          swrite (L, "j, ");
        else
          swrite (L, "j ");
        end if;
      end loop;
      if i /= VALUE'high(1) then
        swrite (L, " ),");
      else
        swrite (L, " )");
      end if;
    end loop;
    swrite (L, " )");
  end procedure write;

  constant NBSP : CHARACTER := CHARACTER'val(160);  -- space character
  -- purpose: Skips white space or punctuation
  procedure skip_whitespace_or_pc (
    L : inout LINE) is
    variable readOk : BOOLEAN;
    variable c      : CHARACTER;
  begin
    while L /= null and L.all'length /= 0 loop
      if (L.all(1) = ' ' or L.all(1) = NBSP or L.all(1) = HT or L.all(1) = CR
          or L.all(1) = '(' or L.all(1) = ')' or L.all(1) = ','
          or L.all(1) = 'i' or L.all(1) = 'j') then
        read (l, c, readOk);
      else
        exit;
      end if;
    end loop;
  end procedure skip_whitespace_or_pc;

  procedure READ(L     : inout LINE;
                 VALUE : out   complex) is
  begin
    skip_whitespace_or_pc(l);
    READ (L, VALUE.RE);
    skip_whitespace_or_pc(l);
    READ (L, VALUE.IM);
  end procedure READ;

  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar) is
  begin
    skip_whitespace_or_pc(l);
    READ (L, VALUE.MAG);
    skip_whitespace_or_pc(l);
    READ (L, VALUE.ARG);
  end procedure READ;
  
  procedure READ(L     : inout LINE;
                 VALUE : out   complex_vector) is
  begin
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i).RE);
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i).IM);
    end loop;
  end procedure READ;

  procedure READ(L     : inout LINE;
                 VALUE : out   complex_matrix) is
  begin
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j).RE);
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j).IM);
      end loop;
    end loop;
  end procedure READ;

  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar_vector) is
  begin
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i).MAG);
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i).ARG);
    end loop;
  end procedure READ;

  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar_matrix) is
  begin
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j).MAG);
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j).ARG);
      end loop;
    end loop;
  end procedure READ;

  -- Read with "GOOD" output
  procedure READ(L     : inout LINE;
                 VALUE : out   complex;
                 GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    skip_whitespace_or_pc(l);
    READ (L, VALUE.RE, isgood);
    wasgood := isgood and wasgood;
    skip_whitespace_or_pc(l);
    READ (L, VALUE.IM, isgood);
    wasgood := isgood and wasgood;
    GOOD    := wasgood;
  end procedure READ;

  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar;
                 GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    skip_whitespace_or_pc(l);
    READ (L, VALUE.MAG, isgood);
    wasgood := isgood and wasgood;
    skip_whitespace_or_pc(l);
    READ (L, VALUE.ARG, isgood);
    wasgood := isgood and wasgood;
    GOOD    := wasgood;
  end procedure READ;

  procedure READ(L     : inout LINE;
                 VALUE : out   complex_vector;
                 GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i).RE, isgood);
      wasgood := isgood and wasgood;
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i).IM, isgood);
      wasgood := isgood and wasgood;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  procedure READ(L     : inout LINE;
                 VALUE : out   complex_matrix;
                 GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j).RE, isgood);
        wasgood := isgood and wasgood;
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j).IM, isgood);
        wasgood := isgood and wasgood;
      end loop;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar_vector;
                 GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i).MAG, isgood);
      wasgood := isgood and wasgood;
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i).ARG, isgood);
      wasgood := isgood and wasgood;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar_matrix;
                 GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j).MAG, isgood);
        wasgood := isgood and wasgood;
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j).ARG, isgood);
        wasgood := isgood and wasgood;
      end loop;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in complex_matrix;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin
    if not index then
      write (L, STRING'("(" & INTEGER'image(arg'length(1))
                        & "," & INTEGER'image(arg'length(2)) & ")"));
      writeline (output, L);
    end if;
    for i in arg'range(1) loop
      for j in arg'range(2) loop
        if index then
          write (L, STRING'("(" & INTEGER'image(i)
                            & "," & INTEGER'image(j) & ") = "));
        end if;
        swrite (L, "(");
        write (L      => L,
               value  => arg (i, j).RE,
               digits => 4);
        swrite (L, " ");
        write (L      => L,
               value  => arg (i, j).IM,
               digits => 4);
        swrite (L, "i) ");
      end loop;  -- j
      writeline (output, L);
    end loop;  -- i
  end procedure print_matrix;

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in complex_vector;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin  -- pring_vector
    for i in arg'range loop
      if index then
        write (L, STRING'("(" & INTEGER'image(i) & ") = "));
      end if;
      swrite (L, "(");
      write (L      => L,
             value  => arg (i).RE,
             digits => 4);
      swrite (L, " ");
      write (L      => L,
             value  => arg (i).IM,
             digits => 4);
      swrite (L, "i) ");
    end loop;  -- i
    writeline (output, L);
  end procedure print_vector;

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in complex_polar_matrix;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin
    if not index then
      write (L, STRING'("(" & INTEGER'image(arg'length(1))
                        & "," & INTEGER'image(arg'length(2)) & ")"));
      writeline (output, L);
    end if;
    for i in arg'range(1) loop
      for j in arg'range(2) loop
        if index then
          write (L, STRING'("(" & INTEGER'image(i)
                            & "," & INTEGER'image(j) & ") = "));
        end if;
        swrite (L, "(");
        write (L      => L,
               value  => arg (i, j).MAG,
               digits => 4);
        swrite (L, " ");
        write (L      => L,
               value  => arg (i, j).ARG,
               digits => 4);
        swrite (L, "i) ");
      end loop;  -- j
      writeline (output, L);
    end loop;  -- i
  end procedure print_matrix;

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in complex_polar_vector;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin  -- print_vector
    for i in arg'range loop
      if index then
        write (L, STRING'("(" & INTEGER'image(i) & ") = "));
      end if;
      swrite (L, "(");
      write (L      => L,
             value  => arg (i).MAG,
             digits => 4);
      swrite (L, " ");
      write (L      => L,
             value  => arg (i).ARG,
             digits => 4);
      swrite (L, "j) ");
    end loop;  -- i
    writeline (output, L);
  end procedure print_vector;

end package body complex_matrix_pkg;
