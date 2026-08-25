-------------------------------------------------------------------------------
-- Title      : Matrix Math package for type REAL
-- Project    : 
-------------------------------------------------------------------------------
-- File       : real_matrix_pkg_body.vhdl
-- Author     : David Bishop  <dbishop@vhdl.org>
-- Company    : 
-- Created    : 2010-04-15
-- Last update: 2011-02-15
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: Matrix math package body for fixed and signed types
-------------------------------------------------------------------------------
-- Copyright (c) 2010 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2010-04-15  1.0      l435385 Created
-------------------------------------------------------------------------------

--
use std.textio.all;
--%VHDL2008% library ieee_proposed;
--%VHDL2008% use ieee_proposed.numeric_std_additions.all;
package body fixed_matrix_pkg is

  -- %%% This is a built in function for VHDL-2008
--%VHDL2008%  -- purpose: minimum of l and r
--%VHDL2008%  function maximum (
--%VHDL2008%    l, r : ufixed)
--%VHDL2008%    return ufixed is
--%VHDL2008%  begin
--%VHDL2008%    if l < r then
--%VHDL2008%      return r;
--%VHDL2008%    else
--%VHDL2008%      return l;
--%VHDL2008%    end if;
--%VHDL2008%  end function maximum;

  -- %%% This is a built in function for VHDL-2008
  -- purpose: max of l and r
--%VHDL2008%  function maximum (
--%VHDL2008%    l, r : sfixed)
--%VHDL2008%    return sfixed is
--%VHDL2008%  begin
--%VHDL2008%    if l < r then
--%VHDL2008%      return r;
--%VHDL2008%    else
--%VHDL2008%      return l;
--%VHDL2008%    end if;
--%VHDL2008%  end function maximum;

  -- %%% This is a built in function for VHDL-2008
--%VHDL2008%  -- purpose: minimum of l and r
--%VHDL2008%  function maximum (
--%VHDL2008%    l, r : UNSIGNED)
--%VHDL2008%    return UNSIGNED is
--%VHDL2008%  begin
--%VHDL2008%    if l < r then
--%VHDL2008%      return r;
--%VHDL2008%    else
--%VHDL2008%      return l;
--%VHDL2008%    end if;
--%VHDL2008%  end function maximum;

  -- %%% This is a built in function for VHDL-2008
  -- purpose: max of l and r
--%VHDL2008%  function maximum (
--%VHDL2008%    l, r : SIGNED)
--%VHDL2008%    return SIGNED is
--%VHDL2008%  begin
--%VHDL2008%    if l < r then
--%VHDL2008%      return r;
--%VHDL2008%    else
--%VHDL2008%      return l;
--%VHDL2008%    end if;
--%VHDL2008%  end function maximum;

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
--%VHDL2008%  -- purpose: maximum of l and r
--%VHDL2008%  function maximum (
--%VHDL2008%    l, r : INTEGER)
--%VHDL2008%    return INTEGER is
--%VHDL2008%  begin
--%VHDL2008%    if l < r then
--%VHDL2008%      return r;
--%VHDL2008%    else
--%VHDL2008%      return l;
--%VHDL2008%    end if;
--%VHDL2008%  end function maximum;

  -- purpose: Returns "true" if a matrix is null.
  function isempty (
    arg : ufixed_matrix)
    return BOOLEAN is
  begin
    if arg'length(1) < 1 or arg'length(2) < 1 then
      return true;
    else
      return false;
    end if;
  end function isempty;

  -- purpose: Returns "true" if a matrix is null.
  function isempty (
    arg : ufixed_vector)
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
    arg : sfixed_matrix)
    return BOOLEAN is
  begin
    if arg'length(1) < 1 or arg'length(2) < 1 then
      return true;
    else
      return false;
    end if;
  end function isempty;

  -- purpose: Returns "true" if a matrix is null.
  function isempty (
    arg : sfixed_vector)
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
    arg : signed_matrix)
    return BOOLEAN is
  begin
    if arg'length(1) < 1 or arg'length(2) < 1 then
      return true;
    else
      return false;
    end if;
  end function isempty;

  -- purpose: Returns "true" if a matrix is null.
  function isempty (
    arg : signed_vector)
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
    arg : unsigned_matrix)
    return BOOLEAN is
  begin
    if arg'length(1) < 1 or arg'length(2) < 1 then
      return true;
    else
      return false;
    end if;
  end function isempty;

  -- purpose: Returns "true" if a matrix is null.
  function isempty (
    arg : unsigned_vector)
    return BOOLEAN is
  begin
    if arg'length < 1 then
      return true;
    else
      return false;
    end if;
  end function isempty;

  -- purpose: Transpose a matrix (Similar to MatLab A' syntax)
  function transpose (
    arg : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(2)-1,
                                     0 to arg'length(1)-1);
  begin  -- transpose
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (j+arg'low(1), i+arg'low(2)),
                                 result (i, j)'high,
                                 result (i, j)'low);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function transpose;

  -- purpose: Transpose a matrix
  function transpose (
    arg : ufixed_vector)
    return ufixed_matrix is
    -- return a matrix with 1 column
    variable result : ufixed_matrix (0 to arg'length-1, 0 to 0);
  begin  -- transpose
    for i in result'range(1) loop
      result (i, 0) := arg (i+arg'low);
    end loop;  -- i
    return result;
  end function transpose;

  -- purpose: Transpose a matrix
  function transpose (
    arg : ufixed_matrix)
    return ufixed_vector is
    variable result : ufixed_vector (0 to arg'length(1)-1);
  begin  -- transpose
    if arg'length(2) /= 1 then
      report fixed_matrix_pkg'instance_name &
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
    arg : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(2)-1,
                                     0 to arg'length(1)-1);
  begin  -- transpose
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (j+arg'low(1), i+arg'low(2)),
                                 result (i, j)'high,
                                 result (i, j)'low);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function transpose;

  -- purpose: Transpose a matrix
  function transpose (
    arg : sfixed_vector)
    return sfixed_matrix is
    -- return a matrix with 1 column
    variable result : sfixed_matrix (0 to arg'length-1, 0 to 0);
  begin  -- transpose
    for i in result'range(1) loop
      result (i, 0) := arg (i+arg'low);
    end loop;  -- i
    return result;
  end function transpose;

  -- purpose: Transpose a matrix
  function transpose (
    arg : sfixed_matrix)
    return sfixed_vector is
    variable result : sfixed_vector (0 to arg'length(1)-1);
  begin  -- transpose
    if arg'length(2) /= 1 then
      report fixed_matrix_pkg'instance_name &
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
    arg : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length(2)-1,
                                       0 to arg'length(1)-1);
  begin  -- transpose
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (j+arg'low(1), i+arg'low(2)),
                                 result (i, j)'length);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function transpose;

  -- purpose: Transpose a matrix
  function transpose (
    arg : unsigned_vector)
    return unsigned_matrix is
    -- return a matrix with 1 column
    variable result : unsigned_matrix (0 to arg'length-1, 0 to 0);
  begin  -- transpose
    for i in result'range(1) loop
      result (i, 0) := arg (i+arg'low);
    end loop;  -- i
    return result;
  end function transpose;

  -- purpose: Transpose a matrix
  function transpose (
    arg : unsigned_matrix)
    return unsigned_vector is
    variable result : unsigned_vector (0 to arg'length(1)-1);
  begin  -- transpose
    if arg'length(2) /= 1 then
      report fixed_matrix_pkg'instance_name &
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
    arg : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length(2)-1,
                                     0 to arg'length(1)-1);
  begin  -- transpose
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (j+arg'low(1), i+arg'low(2)),
                                 result (i, j)'length);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function transpose;

  -- purpose: Transpose a matrix
  function transpose (
    arg : signed_vector)
    return signed_matrix is
    -- return a matrix with 1 column
    variable result : signed_matrix (0 to arg'length-1, 0 to 0);
  begin  -- transpose
    for i in result'range(1) loop
      result (i, 0) := arg (i+arg'low);
    end loop;  -- i
    return result;
  end function transpose;

  -- purpose: Transpose a matrix
  function transpose (
    arg : signed_matrix)
    return signed_vector is
    variable result : signed_vector (0 to arg'length(1)-1);
  begin  -- transpose
    if arg'length(2) /= 1 then
      report fixed_matrix_pkg'instance_name &
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

  -- purpose: returns a matrix of zeros
  function zeros (
    rows, columns : NATURAL)
    return ufixed_matrix is
    constant zero : ufixed (1 downto 0) := (others => '0');
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  function zeros (
    rows, columns : NATURAL)
    return ufixed_vector is
    constant zero : ufixed (1 downto 0) := (others => '0');
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  function zeros (
    rows, columns : NATURAL)
    return sfixed_matrix is
    constant zero : sfixed (1 downto 0) := (others => '0');
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  function zeros (
    rows, columns : NATURAL)
    return sfixed_vector is
    constant zero : sfixed (1 downto 0) := (others => '0');
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  function zeros (
    rows, columns : NATURAL)
    return unsigned_matrix is
    constant zero : UNSIGNED (1 downto 0) := (others => '0');
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  function zeros (
    rows, columns : NATURAL)
    return unsigned_vector is
    constant zero : UNSIGNED (1 downto 0) := (others => '0');
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  function zeros (
    rows, columns : NATURAL)
    return signed_matrix is
    constant zero : SIGNED (1 downto 0) := (others => '0');
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  function zeros (
    rows, columns : NATURAL)
    return signed_vector is
    constant zero : SIGNED (1 downto 0) := (others => '0');
  begin  -- zeros
    return repmat (arg     => zero,
                   rows    => rows,
                   columns => columns);
  end function zeros;

  -- purpose: returns a matrix of ones
  function ones (
    rows, columns : NATURAL)
    return ufixed_matrix is
  begin  -- ones
    return repmat (arg     => ufixed_one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  function ones (
    rows, columns : NATURAL)
    return ufixed_vector is
  begin  -- ones
    return repmat (arg     => ufixed_one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  function ones (
    rows, columns : NATURAL)
    return sfixed_matrix is
  begin  -- ones
    return repmat (arg     => sfixed_one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  function ones (
    rows, columns : NATURAL)
    return sfixed_vector is
  begin  -- ones
    return repmat (arg     => sfixed_one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  function ones (
    rows, columns : NATURAL)
    return unsigned_matrix is
    constant one : UNSIGNED (1 downto 0) := "01";
  begin  -- ones
    return repmat (arg     => one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  function ones (
    rows, columns : NATURAL)
    return unsigned_vector is
    constant one : UNSIGNED (1 downto 0) := "01";
  begin  -- ones
    return repmat (arg     => one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  function ones (
    rows, columns : NATURAL)
    return signed_matrix is
    constant one : SIGNED (1 downto 0) := "01";
  begin  -- ones
    return repmat (arg     => one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  function ones (
    rows, columns : NATURAL)
    return signed_vector is
    constant one : SIGNED (1 downto 0) := "01";
  begin  -- ones
    return repmat (arg     => one,
                   rows    => rows,
                   columns => columns);
  end function ones;

  -- purpose: Returns an identity matrix
  function eye (
    rows, columns : NATURAL)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to rows-1, 0 to columns-1);
    constant zero   : ufixed (1 downto 0) := "00";

  begin  -- eye
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := resize (ufixed_one,
                                   result (i, j)'high,
                                   result (i, j)'low);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'high,
                                   result (i, j)'low);
        end if;
      end loop;  -- j
    end loop;  -- i
    return result;
  end function eye;

  function eye (
    rows, columns : NATURAL)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to rows-1, 0 to columns-1);
    constant zero   : sfixed (1 downto 0) := "00";

  begin  -- eye
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := resize (sfixed_one,
                                   result (i, j)'high,
                                   result (i, j)'low);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'high,
                                   result (i, j)'low);
        end if;
      end loop;  -- j
    end loop;  -- i
    return result;
  end function eye;

  function eye (
    rows, columns : NATURAL)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to rows-1, 0 to columns-1);
    constant zero   : UNSIGNED (1 downto 0) := "00";
    constant one    : UNSIGNED (1 downto 0) := "01";
  begin  -- eye
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := resize (one,
                                   result (i, j)'length);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'length);
        end if;
      end loop;  -- j
    end loop;  -- i
    return result;
  end function eye;

  function eye (
    rows, columns : NATURAL)
    return signed_matrix is
    variable result : signed_matrix (0 to rows-1, 0 to columns-1);
    constant zero   : SIGNED (1 downto 0) := "00";
    constant one    : SIGNED (1 downto 0) := "01";

  begin  -- eye
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := resize (one,
                                   result (i, j)'length);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'length);
        end if;
      end loop;  -- j
    end loop;  -- i
    return result;
  end function eye;

  -- Concatenates two matrices together
  function cat (
    constant dim : POSITIVE;            -- 1 = y, 2 = x
    l, r         : ufixed_matrix)
    return ufixed_matrix is
  begin
    if dim = 1 then
      return vertcat (l, r);
    elsif dim = 2 then
      return horzcat (l, r);
    else
      report fixed_matrix_pkg'instance_name & "cat " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return l;
    end if;
  end function cat;

  -- Concatenates two matrices together
  function horzcat (
    l, r : ufixed_matrix)
    return ufixed_matrix is
    variable rx : ufixed_matrix (0 to l'length(1)-1,
                                 0 to (l'length(2) + r'length(2)-1));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (1) = r'length(1) then
      for i in rx'range(1) loop
        for j in 0 to l'length(2)-1 loop
          rx (i, j) := resize (l (i+l'low(1), j+l'low(2)),
                               rx (i, j)'high,
                               rx (i, j)'low);
        end loop;
      end loop;
      for i in rx'range(1) loop
        for j in 0 to r'length(2)-1 loop
          rx (i, j+l'length(2)) := resize (r (i+r'low(1), j+r'low(2)),
                                           rx (i, j+l'length(2))'high,
                                           rx (i, j+l'length(2))'low);
        end loop;
      end loop;
    else
      report fixed_matrix_pkg'instance_name & "horzcat " &
        "row dimension does not match " & INTEGER'image(l'length(1)) &
        " /= " & INTEGER'image(r'length(1)) severity error;
    end if;
    return rx;
  end function horzcat;

  -- Concatenates two matrices together
  function vertcat (
    l, r : ufixed_matrix)
    return ufixed_matrix is
    variable ry : ufixed_matrix (0 to (l'length(1) + r'length(1)-1),
                                 0 to l'length(2));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (2) = r'length(2) then
      for i in 0 to l'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i, j) := resize(l (i+l'low(1), j+l'low(2)),
                              ry (i, j)'high,
                              ry (i, j)'low);
        end loop;
      end loop;
      for i in 0 to r'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i+l'length(1), j) := resize (r (i+r'low(1), j+r'low(2)),
                                           ry (i+l'length(1), j)'high,
                                           ry (i+l'length(1), j)'low);
        end loop;
      end loop;
    else
      report fixed_matrix_pkg'instance_name & "vertcat " &
        "column dimension does not match " & INTEGER'image(l'length(2)) &
        " /= " & INTEGER'image(r'length(2)) severity error;
    end if;
    return ry;
  end function vertcat;

  -- Flip the dimensions on a matrix
  function flipdim (
    arg          : ufixed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return ufixed_matrix is
  begin
    if dim = 1 then
      return flipup (arg);
    elsif dim = 2 then
      return fliplr (arg);
    else
      report fixed_matrix_pkg'instance_name & "flipdim " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return arg;
    end if;
  end function flipdim;

  -- flip left to right
  function fliplr (
    arg : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable i, j : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (arg'low(1)+i, arg'high(2)-j),
                                 result (i, j)'high,
                                 result (i, j)'low);
      end loop;
    end loop;
    return result;
  end function fliplr;

  -- Flip up and down
  function flipup (
    arg : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable i, j : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (arg'high(1)-i, arg'low(2)+j),
                                 result (i, j)'high,
                                 result (i, j)'low);
      end loop;
    end loop;
    return result;
  end function flipup;

  -- flip a vector
  function fliplr (
    arg : ufixed_vector)
    return ufixed_vector is
    variable result : ufixed_vector (0 to arg'length-1);
    variable i      : INTEGER;
  begin
    for i in result'range(1) loop
      result (i) := resize (arg (arg'high-i),
                            result (i)'high,
                            result (i)'low);
    end loop;
    return result;
  end function fliplr;

  -- Matrix rotation
  function rot90 (
    arg          : ufixed_matrix;
    constant dim : INTEGER := 1)
    return ufixed_matrix is
    variable rx   : ufixed_matrix (0 to arg'length(1)-1, 0 to arg'length(2)-1);
    variable ry   : ufixed_matrix (0 to arg'length(2)-1, 0 to arg'length(1)-1);
    variable i, j : INTEGER;
  begin
    if dim = 1 or dim = -3 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := resize (arg (arg'low(1)+j, arg'high(2)-i),
                               ry (i, j)'high,
                               ry (i, j)'low);
        end loop;
      end loop;
      return ry;
    elsif dim = 2 or dim = -2 then
      for i in rx'range(1) loop
        for j in rx'range(2) loop
          rx (i, j) := resize (arg (arg'high(1)-i, arg'high(2)-j),
                               rx (i, j)'high,
                               rx (i, j)'low);
        end loop;
      end loop;
      return rx;
    elsif dim = 3 or dim = -1 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := resize (arg (arg'high(1)-j, arg'low(2)+i),
                               ry (i, j)'high,
                               ry (i, j)'low);
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
    l, r         : sfixed_matrix)
    return sfixed_matrix is
  begin
    if dim = 1 then
      return vertcat (l, r);
    elsif dim = 2 then
      return horzcat (l, r);
    else
      report fixed_matrix_pkg'instance_name & "cat " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return l;
    end if;
  end function cat;

  -- Concatenates two matrices together
  function horzcat (
    l, r : sfixed_matrix)
    return sfixed_matrix is
    variable rx : sfixed_matrix (0 to l'length(1)-1,
                                 0 to (l'length(2) + r'length(2)-1));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (1) = r'length(1) then
      for i in rx'range(1) loop
        for j in 0 to l'length(2)-1 loop
          rx (i, j) := resize (l (i+l'low(1), j+l'low(2)),
                               rx (i, j)'high,
                               rx (i, j)'low);
        end loop;
      end loop;
      for i in rx'range(1) loop
        for j in 0 to r'length(2)-1 loop
          rx (i, j+l'length(2)) := resize (r (i+r'low(1), j+r'low(2)),
                                           rx (i, j+l'length(2))'high,
                                           rx (i, j+l'length(2))'low);
        end loop;
      end loop;
    else
      report fixed_matrix_pkg'instance_name & "horzcat " &
        "row dimension does not match " & INTEGER'image(l'length(1)) &
        " /= " & INTEGER'image(r'length(1)) severity error;
    end if;
    return rx;
  end function horzcat;

  -- Concatenates two matrices together
  function vertcat (
    l, r : sfixed_matrix)
    return sfixed_matrix is
    variable ry : sfixed_matrix (0 to (l'length(1) + r'length(1)-1),
                                 0 to l'length(2));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (2) = r'length(2) then
      for i in 0 to l'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i, j) := resize(l (i+l'low(1), j+l'low(2)),
                              ry (i, j)'high,
                              ry (i, j)'low);
        end loop;
      end loop;
      for i in 0 to r'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i+l'length(1), j) := resize (r (i+r'low(1), j+r'low(2)),
                                           ry (i+l'length(1), j)'high,
                                           ry (i+l'length(1), j)'low);
        end loop;
      end loop;
    else
      report fixed_matrix_pkg'instance_name & "vertcat " &
        "column dimension does not match " & INTEGER'image(l'length(2)) &
        " /= " & INTEGER'image(r'length(2)) severity error;
    end if;
    return ry;
  end function vertcat;

  -- Flip the dimensions on a matrix
  function flipdim (
    arg          : sfixed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return sfixed_matrix is
  begin
    if dim = 1 then
      return flipup (arg);
    elsif dim = 2 then
      return fliplr (arg);
    else
      report fixed_matrix_pkg'instance_name & "flipdim " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return arg;
    end if;
  end function flipdim;

  -- flip left to right
  function fliplr (
    arg : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable i, j : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (arg'low(1)+i, arg'high(2)-j),
                                 result (i, j)'high,
                                 result (i, j)'low);
      end loop;
    end loop;
    return result;
  end function fliplr;

  -- Flip up and down
  function flipup (
    arg : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable i, j : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (arg'high(1)-i, arg'low(2)+j),
                                 result (i, j)'high,
                                 result (i, j)'low);
      end loop;
    end loop;
    return result;
  end function flipup;

  -- flip a vector
  function fliplr (
    arg : sfixed_vector)
    return sfixed_vector is
    variable result : sfixed_vector (0 to arg'length-1);
    variable i      : INTEGER;
  begin
    for i in result'range(1) loop
      result (i) := resize (arg (arg'high-i),
                            result (i)'high,
                            result (i)'low);
    end loop;
    return result;
  end function fliplr;

  -- Matrix rotation
  function rot90 (
    arg          : sfixed_matrix;
    constant dim : INTEGER := 1)
    return sfixed_matrix is
    variable rx   : sfixed_matrix (0 to arg'length(1)-1, 0 to arg'length(2)-1);
    variable ry   : sfixed_matrix (0 to arg'length(2)-1, 0 to arg'length(1)-1);
    variable i, j : INTEGER;
  begin
    if dim = 1 or dim = -3 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := resize (arg (arg'low(1)+j, arg'high(2)-i),
                               ry (i, j)'high,
                               ry (i, j)'low);
        end loop;
      end loop;
      return ry;
    elsif dim = 2 or dim = -2 then
      for i in rx'range(1) loop
        for j in rx'range(2) loop
          rx (i, j) := resize (arg (arg'high(1)-i, arg'high(2)-j),
                               rx (i, j)'high,
                               rx (i, j)'low);
        end loop;
      end loop;
      return rx;
    elsif dim = 3 or dim = -1 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := resize (arg (arg'high(1)-j, arg'low(2)+i),
                               ry (i, j)'high,
                               ry (i, j)'low);
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
    l, r         : unsigned_matrix)
    return unsigned_matrix is
  begin
    if dim = 1 then
      return vertcat (l, r);
    elsif dim = 2 then
      return horzcat (l, r);
    else
      report fixed_matrix_pkg'instance_name & "cat " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return l;
    end if;
  end function cat;

  -- Concatenates two matrices together
  function horzcat (
    l, r : unsigned_matrix)
    return unsigned_matrix is
    variable rx : unsigned_matrix (0 to l'length(1)-1,
                                   0 to (l'length(2) + r'length(2)-1));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (1) = r'length(1) then
      for i in rx'range(1) loop
        for j in 0 to l'length(2)-1 loop
          rx (i, j) := resize (l (i+l'low(1), j+l'low(2)),
                               rx (i, j)'length);
        end loop;
      end loop;
      for i in rx'range(1) loop
        for j in 0 to r'length(2)-1 loop
          rx (i, j+l'length(2)) := resize (r (i+r'low(1), j+r'low(2)),
                                           rx (i, j+l'length(2))'length);
        end loop;
      end loop;
    else
      report fixed_matrix_pkg'instance_name & "horzcat " &
        "row dimension does not match " & INTEGER'image(l'length(1)) &
        " /= " & INTEGER'image(r'length(1)) severity error;
    end if;
    return rx;
  end function horzcat;

  -- Concatenates two matrices together
  function vertcat (
    l, r : unsigned_matrix)
    return unsigned_matrix is
    variable ry : unsigned_matrix (0 to (l'length(1) + r'length(1)-1),
                                   0 to l'length(2));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (2) = r'length(2) then
      for i in 0 to l'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i, j) := resize(l (i+l'low(1), j+l'low(2)),
                              ry (i, j)'length);
        end loop;
      end loop;
      for i in 0 to r'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i+l'length(1), j) := resize (r (i+r'low(1), j+r'low(2)),
                                           ry (i+l'length(1), j)'length);
        end loop;
      end loop;
    else
      report fixed_matrix_pkg'instance_name & "vertcat " &
        "column dimension does not match " & INTEGER'image(l'length(2)) &
        " /= " & INTEGER'image(r'length(2)) severity error;
    end if;
    return ry;
  end function vertcat;

  -- Flip the dimensions on a matrix
  function flipdim (
    arg          : unsigned_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return unsigned_matrix is
  begin
    if dim = 1 then
      return flipup (arg);
    elsif dim = 2 then
      return fliplr (arg);
    else
      report fixed_matrix_pkg'instance_name & "flipdim " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return arg;
    end if;
  end function flipdim;

  -- flip left to right
  function fliplr (
    arg : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length(1)-1,
                                       0 to arg'length(2)-1);
    variable i, j : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (arg'low(1)+i, arg'high(2)-j),
                                 result (i, j)'length);
      end loop;
    end loop;
    return result;
  end function fliplr;

  -- Flip up and down
  function flipup (
    arg : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length(1)-1, 0 to arg'length(2)-1);
    variable i, j   : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (arg'high(1)-i, arg'low(2)+j),
                                 result (i, j)'length);
      end loop;
    end loop;
    return result;
  end function flipup;

  -- flip a vector
  function fliplr (
    arg : unsigned_vector)
    return unsigned_vector is
    variable result : unsigned_vector (0 to arg'length-1);
    variable i      : INTEGER;
  begin
    for i in result'range(1) loop
      result (i) := resize (arg (arg'high-i),
                            result (i)'length);
    end loop;
    return result;
  end function fliplr;

  -- Matrix rotation
  function rot90 (
    arg          : unsigned_matrix;
    constant dim : INTEGER := 1)
    return unsigned_matrix is
    variable rx : unsigned_matrix (0 to arg'length(1)-1,
                                   0 to arg'length(2)-1);
    variable ry : unsigned_matrix (0 to arg'length(2)-1,
                                   0 to arg'length(1)-1);
    variable i, j : INTEGER;
  begin
    if dim = 1 or dim = -3 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := resize (arg (arg'low(1)+j, arg'high(2)-i),
                               ry (i, j)'length);
        end loop;
      end loop;
      return ry;
    elsif dim = 2 or dim = -2 then
      for i in rx'range(1) loop
        for j in rx'range(2) loop
          rx (i, j) := resize (arg (arg'high(1)-i, arg'high(2)-j),
                               rx (i, j)'length);
        end loop;
      end loop;
      return rx;
    elsif dim = 3 or dim = -1 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := resize (arg (arg'high(1)-j, arg'low(2)+i),
                               ry (i, j)'length);
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
    l, r         : signed_matrix)
    return signed_matrix is
  begin
    if dim = 1 then
      return vertcat (l, r);
    elsif dim = 2 then
      return horzcat (l, r);
    else
      report fixed_matrix_pkg'instance_name & "cat " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return l;
    end if;
  end function cat;

  -- Concatenates two matrices together
  function horzcat (
    l, r : signed_matrix)
    return signed_matrix is
    variable rx : signed_matrix (0 to l'length(1)-1,
                                 0 to (l'length(2) + r'length(2)-1));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (1) = r'length(1) then
      for i in rx'range(1) loop
        for j in 0 to l'length(2)-1 loop
          rx (i, j) := resize (l (i+l'low(1), j+l'low(2)),
                               rx (i, j)'length);
        end loop;
      end loop;
      for i in rx'range(1) loop
        for j in 0 to r'length(2)-1 loop
          rx (i, j+l'length(2)) := resize (r (i+r'low(1), j+r'low(2)),
                                           rx (i, j+l'length(2))'length);
        end loop;
      end loop;
    else
      report fixed_matrix_pkg'instance_name & "horzcat " &
        "row dimension does not match " & INTEGER'image(l'length(1)) &
        " /= " & INTEGER'image(r'length(1)) severity error;
    end if;
    return rx;
  end function horzcat;

  -- Concatenates two matrices together
  function vertcat (
    l, r : signed_matrix)
    return signed_matrix is
    variable ry : signed_matrix (0 to (l'length(1) + r'length(1)-1),
                                 0 to l'length(2));
    variable m, n : INTEGER;            -- index variables
  begin
    if l'length (2) = r'length(2) then
      for i in 0 to l'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i, j) := resize(l (i+l'low(1), j+l'low(2)),
                              ry (i, j)'length);
        end loop;
      end loop;
      for i in 0 to r'length(1)-1 loop
        for j in ry'range(2) loop
          ry (i+l'length(1), j) := resize (r (i+r'low(1), j+r'low(2)),
                                           ry (i+l'length(1), j)'length);
        end loop;
      end loop;
    else
      report fixed_matrix_pkg'instance_name & "vertcat " &
        "column dimension does not match " & INTEGER'image(l'length(2)) &
        " /= " & INTEGER'image(r'length(2)) severity error;
    end if;
    return ry;
  end function vertcat;

  -- Flip the dimensions on a matrix
  function flipdim (
    arg          : signed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return signed_matrix is
  begin
    if dim = 1 then
      return flipup (arg);
    elsif dim = 2 then
      return fliplr (arg);
    else
      report fixed_matrix_pkg'instance_name & "flipdim " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return arg;
    end if;
  end function flipdim;

  -- flip left to right
  function fliplr (
    arg : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable i, j : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (arg'low(1)+i, arg'high(2)-j),
                                 result (i, j)'length);
      end loop;
    end loop;
    return result;
  end function fliplr;

  -- Flip up and down
  function flipup (
    arg : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable i, j : INTEGER;
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg (arg'high(1)-i, arg'low(2)+j),
                                 result (i, j)'length);
      end loop;
    end loop;
    return result;
  end function flipup;

  -- flip a vector
  function fliplr (
    arg : signed_vector)
    return signed_vector is
    variable result : signed_vector (0 to arg'length-1);
    variable i      : INTEGER;
  begin
    for i in result'range(1) loop
      result (i) := resize (arg (arg'high-i),
                            result (i)'length);
    end loop;
    return result;
  end function fliplr;

  -- Matrix rotation
  function rot90 (
    arg          : signed_matrix;
    constant dim : INTEGER := 1)
    return signed_matrix is
    variable rx   : signed_matrix (0 to arg'length(1)-1, 0 to arg'length(2)-1);
    variable ry   : signed_matrix (0 to arg'length(2)-1, 0 to arg'length(1)-1);
    variable i, j : INTEGER;
  begin
    if dim = 1 or dim = -3 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := resize (arg (arg'low(1)+j, arg'high(2)-i),
                               ry (i, j)'length);
        end loop;
      end loop;
      return ry;
    elsif dim = 2 or dim = -2 then
      for i in rx'range(1) loop
        for j in rx'range(2) loop
          rx (i, j) := resize (arg (arg'high(1)-i, arg'high(2)-j),
                               rx (i, j)'length);
        end loop;
      end loop;
      return rx;
    elsif dim = 3 or dim = -1 then
      for i in ry'range(1) loop
        for j in ry'range(2) loop
          ry (i, j) := resize (arg (arg'high(1)-j, arg'low(2)+i),
                               ry (i, j)'length);
        end loop;
      end loop;
      return ry;
    else
      return arg;
    end if;
  end function rot90;

  -- Change the shape of a matrix
  function reshape (
    arg                    : ufixed_matrix;
    constant rows, columns : POSITIVE)
    return ufixed_matrix is
    variable result     : ufixed_matrix (0 to rows-1, 0 to columns-1);
    variable i, j, k, l : INTEGER;
  begin
    if arg'length(1)*arg'length(2) < rows*columns then
      report fixed_matrix_pkg'instance_name & "reshape " &
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
          result (j, i) := resize (arg (k, l),
                                   result (j, i)'high,
                                   result (j, i)'low);
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
    arg                    : ufixed_vector;
    constant rows, columns : POSITIVE)
    return ufixed_matrix is
    variable result  : ufixed_matrix (0 to rows-1, 0 to columns-1);  -- result
    variable i, j, k : INTEGER;
  begin
    if arg'length < rows*columns then
      report fixed_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length) &
        ") < result (" & INTEGER'image(rows) & "," &
        INTEGER'image(columns) & ")"
        severity error;
      return result;
    else
      k := arg'low;
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := resize (arg (k),
                                   result (j, i)'high,
                                   result (j, i)'low);
          k := k + 1;
        end loop;
      end loop;
      return result;
    end if;
  end function reshape;

  function reshape (
    arg           : ufixed_matrix;
    rows, columns : POSITIVE)
    return ufixed_vector is
    variable rx         : ufixed_vector (0 to rows-1);
    variable ry         : ufixed_vector (0 to columns-1);
    variable i, j, k, l : INTEGER;
  begin
    if rows = 1 then
      if arg'length(1) * arg'length(2) < ry'length then
        report fixed_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (ry'length) & ")"
          severity error;
        return ry;
      else
        k := arg'low(2);
        l := arg'low(1);
        for j in ry'range loop
          ry (j) := resize (arg (l, k),
                            ry (j)'high,
                            ry (j)'low);
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
        report fixed_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (rx'length) & ")"
          severity error;
        return rx;
      else
        k := arg'low(1);
        l := arg'low(2);
        for j in rx'range loop
          rx (j) := resize (arg (k, l),
                            rx (j)'high,
                            rx (j)'low);
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
      report fixed_matrix_pkg'instance_name & "reshape " &
        "rows or columns need to be 1 got " & INTEGER'image(rows) & "," &
        INTEGER'image(columns) severity error;
      return rx;
    end if;
  end function reshape;


  -- Change the shape of a matrix
  function reshape (
    arg                    : sfixed_matrix;
    constant rows, columns : POSITIVE)
    return sfixed_matrix is
    variable result     : sfixed_matrix (0 to rows-1, 0 to columns-1);
    variable i, j, k, l : INTEGER;
  begin
    if arg'length(1)*arg'length(2) < rows*columns then
      report fixed_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
        "," & INTEGER'image(arg'length(2)) & ") < result (" &
        INTEGER'image(rows) & "," & INTEGER'image(columns) & ")"
        severity error;
    else
      k := arg'low(1);
      l := arg'low(2);
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := resize (arg (k, l),
                                   result (j, i)'high,
                                   result (j, i)'low);
          if k = arg'high(1) then
            k := arg'low(1);
            l := l + 1;
          else
            k := k + 1;
          end if;
        end loop;
      end loop;
    end if;
    return result;
  end function reshape;

  -- Change the shape of a matrix
  function reshape (
    arg                    : sfixed_vector;
    constant rows, columns : POSITIVE)
    return sfixed_matrix is
    variable result  : sfixed_matrix (0 to rows-1, 0 to columns-1);  -- result
    variable i, j, k : INTEGER;
  begin
    if arg'length < rows*columns then
      report fixed_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length) &
        ") < result (" & INTEGER'image(rows) & "," &
        INTEGER'image(columns) & ")"
        severity error;
    else
      k := arg'low;
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := resize (arg (k),
                                   result (j, i)'high,
                                   result (j, i)'low);
          k := k + 1;
        end loop;
      end loop;
    end if;
    return result;
  end function reshape;

  function reshape (
    arg           : sfixed_matrix;
    rows, columns : POSITIVE)
    return sfixed_vector is
    variable rx         : sfixed_vector (0 to rows-1);
    variable ry         : sfixed_vector (0 to columns-1);
    variable i, j, k, l : INTEGER;
  begin
    if rows = 1 then
      if arg'length(1) * arg'length(2) < ry'length then
        report fixed_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (ry'length) & ")"
          severity error;
        return ry;
      else
        k := arg'low(2);
        l := arg'low(1);
        for j in ry'range loop
          ry (j) := resize (arg (l, k),
                            ry (j)'high,
                            ry (j)'low);
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
        report fixed_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (rx'length) & ")"
          severity error;
        return rx;
      else
        k := arg'low(1);
        l := arg'low(2);
        for j in rx'range loop
          rx (j) := resize (arg (k, l),
                            rx (j)'high,
                            rx (j)'low);
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
      report fixed_matrix_pkg'instance_name & "reshape " &
        "rows or columns need to be 1 got " & INTEGER'image(rows) & "," &
        INTEGER'image(columns) severity error;
      return rx;
    end if;
  end function reshape;


  -- Change the shape of a matrix
  function reshape (
    arg                    : unsigned_matrix;
    constant rows, columns : POSITIVE)
    return unsigned_matrix is
    variable result     : unsigned_matrix (0 to rows-1, 0 to columns-1);
    variable i, j, k, l : INTEGER;
  begin
    if arg'length(1)*arg'length(2) < rows*columns then
      report fixed_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
        "," & INTEGER'image(arg'length(2)) & ") < result (" &
        INTEGER'image(rows) & "," & INTEGER'image(columns) & ")"
        severity error;
    else
      k := arg'low(1);
      l := arg'low(2);
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := resize (arg (k, l),
                                   result (j, i)'length);
          if k = arg'high(1) then
            k := arg'low(1);
            l := l + 1;
          else
            k := k + 1;
          end if;
        end loop;
      end loop;
    end if;
    return result;
  end function reshape;

  -- Change the shape of a matrix
  function reshape (
    arg                    : unsigned_vector;
    constant rows, columns : POSITIVE)
    return unsigned_matrix is
    variable result  : unsigned_matrix (0 to rows-1, 0 to columns-1);
    variable i, j, k : INTEGER;
  begin
    if arg'length < rows*columns then
      report fixed_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length) &
        ") < result (" & INTEGER'image(rows) & "," &
        INTEGER'image(columns) & ")"
        severity error;
    else
      k := arg'low;
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := resize (arg (k),
                                   result (j, i)'length);
          k := k + 1;
        end loop;
      end loop;
    end if;
    return result;
  end function reshape;

  function reshape (
    arg           : unsigned_matrix;
    rows, columns : POSITIVE)
    return unsigned_vector is
    variable rx         : unsigned_vector (0 to rows-1);
    variable ry         : unsigned_vector (0 to columns-1);
    variable i, j, k, l : INTEGER;
  begin
    if rows = 1 then
      if arg'length(1) * arg'length(2) < ry'length then
        report fixed_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (ry'length) & ")"
          severity error;
        return ry;
      else
        k := arg'low(2);
        l := arg'low(1);
        for j in ry'range loop
          ry (j) := resize (arg (l, k),
                            ry (j)'length);
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
        report fixed_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (rx'length) & ")"
          severity error;
        return rx;
      else
        k := arg'low(1);
        l := arg'low(2);
        for j in rx'range loop
          rx (j) := resize (arg (k, l),
                            rx (j)'length);
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
      report fixed_matrix_pkg'instance_name & "reshape " &
        "rows or columns need to be 1 got " & INTEGER'image(rows) & "," &
        INTEGER'image(columns) severity error;
      return rx;
    end if;
  end function reshape;

  -- Change the shape of a matrix
  function reshape (
    arg                    : signed_matrix;
    constant rows, columns : POSITIVE)
    return signed_matrix is
    variable result     : signed_matrix (0 to rows-1, 0 to columns-1);
    variable i, j, k, l : INTEGER;
  begin
    if arg'length(1)*arg'length(2) < rows*columns then
      report fixed_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
        "," & INTEGER'image(arg'length(2)) & ") < result (" &
        INTEGER'image(rows) & "," & INTEGER'image(columns) & ")"
        severity error;
    else
      k := arg'low(1);
      l := arg'low(2);
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := resize (arg (k, l),
                                   result (j, i)'length);
          if k = arg'high(1) then
            k := arg'low(1);
            l := l + 1;
          else
            k := k + 1;
          end if;
        end loop;
      end loop;
    end if;
    return result;
  end function reshape;

  -- Change the shape of a matrix
  function reshape (
    arg                    : signed_vector;
    constant rows, columns : POSITIVE)
    return signed_matrix is
    variable result  : signed_matrix (0 to rows-1, 0 to columns-1);  -- result
    variable i, j, k : INTEGER;
  begin
    if arg'length < rows*columns then
      report fixed_matrix_pkg'instance_name & "reshape " &
        "not enough elements in arg (" & INTEGER'image(arg'length) &
        ") < result (" & INTEGER'image(rows) & "," &
        INTEGER'image(columns) & ")"
        severity error;
    else
      k := arg'low;
      for i in result'range(2) loop
        for j in result'range(1) loop
          result (j, i) := resize (arg (k),
                                   result (j, i)'length);
          k := k + 1;
        end loop;
      end loop;
    end if;
    return result;
  end function reshape;

  function reshape (
    arg           : signed_matrix;
    rows, columns : POSITIVE)
    return signed_vector is
    variable rx         : signed_vector (0 to rows-1);
    variable ry         : signed_vector (0 to columns-1);
    variable i, j, k, l : INTEGER;
  begin
    if rows = 1 then
      if arg'length(1) * arg'length(2) < ry'length then
        report fixed_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (ry'length) & ")"
          severity error;
        return ry;
      else
        k := arg'low(2);
        l := arg'low(1);
        for j in ry'range loop
          ry (j) := resize (arg (l, k),
                            ry (j)'length);
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
        report fixed_matrix_pkg'instance_name & "reshape " &
          "not enough elements in arg (" & INTEGER'image(arg'length(1)) &
          "," & INTEGER'image(arg'length(2)) & ") < result (" &
          INTEGER'image (rx'length) & ")"
          severity error;
        return rx;
      else
        k := arg'low(1);
        l := arg'low(2);
        for j in rx'range loop
          rx (j) := resize (arg (k, l),
                            rx (j)'length);
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
      report fixed_matrix_pkg'instance_name & "reshape " &
        "rows or columns need to be 1 got " & INTEGER'image(rows) & "," &
        INTEGER'image(columns) severity error;
      return rx;
    end if;
  end function reshape;

  -- returns the size of a matrix
  function size (
    arg : ufixed_matrix)
    return integer_vector is
    variable result : integer_vector (0 to 1);
  begin
    result (0) := arg'length(1);
    result (1) := arg'length(2);
    return result;
  end function size;

  -- True if matrix is one dimensional
  function isvector (
    arg : ufixed_matrix)
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
    arg : ufixed_matrix)
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
    arg : ufixed_matrix)
    return INTEGER is
  begin
    if isempty (arg) then
      return 0;
    else
      return arg'length(1) * arg'length(2);
    end if;
  end function numel;

  -- returns the size of a matrix
  function size (
    arg : sfixed_matrix)
    return integer_vector is
    variable result : integer_vector (0 to 1);
  begin
    result (0) := arg'length(1);
    result (1) := arg'length(2);
    return result;
  end function size;

  -- True if matrix is one dimensional
  function isvector (
    arg : sfixed_matrix)
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
    arg : sfixed_matrix)
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
    arg : sfixed_matrix)
    return INTEGER is
  begin
    if isempty (arg) then
      return 0;
    else
      return arg'length(1) * arg'length(2);
    end if;
  end function numel;

  -- returns the size of a matrix
  function size (
    arg : unsigned_matrix)
    return integer_vector is
    variable result : integer_vector (0 to 1);
  begin
    result (0) := arg'length(1);
    result (1) := arg'length(2);
    return result;
  end function size;

  -- True if matrix is one dimensional
  function isvector (
    arg : unsigned_matrix)
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
    arg : unsigned_matrix)
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
    arg : unsigned_matrix)
    return INTEGER is
  begin
    if isempty (arg) then
      return 0;
    else
      return arg'length(1) * arg'length(2);
    end if;
  end function numel;

  -- returns the size of a matrix
  function size (
    arg : signed_matrix)
    return integer_vector is
    variable result : integer_vector (0 to 1);
  begin
    result (0) := arg'length(1);
    result (1) := arg'length(2);
    return result;
  end function size;

  -- True if matrix is one dimensional
  function isvector (
    arg : signed_matrix)
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
    arg : signed_matrix)
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
    arg : signed_matrix)
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
    arg : ufixed_matrix)
    return ufixed_vector is
    variable result : ufixed_vector (0 to minimum (arg'length(2),
                                                   arg'length(1))-1);
  begin
    for i in result'range loop
      result (i) := resize (arg (i+arg'low(1), i+arg'low(2)),
                            result (i)'high,
                            result (i)'low);
    end loop;
    return result;
  end function diag;

  function diag (
    arg : sfixed_matrix)
    return sfixed_vector is
    variable result : sfixed_vector (0 to minimum (arg'length(2),
                                                   arg'length(1))-1);
  begin
    for i in result'range loop
      result (i) := resize (arg (i+arg'low(1), i+arg'low(2)),
                            result (i)'high,
                            result (i)'low);
    end loop;
    return result;
  end function diag;

  function diag (
    arg : unsigned_matrix)
    return unsigned_vector is
    variable result : unsigned_vector (0 to minimum (arg'length(2),
                                                     arg'length(1))-1);
  begin
    for i in result'range loop
      result (i) := resize (arg (i+arg'low(1), i+arg'low(2)),
                            result (i)'length);
    end loop;
    return result;
  end function diag;

  function diag (
    arg : signed_matrix)
    return signed_vector is
    variable result : signed_vector (0 to minimum (arg'length(2),
                                                   arg'length(1))-1);
  begin
    for i in result'range loop
      result (i) := resize (arg (i+arg'low(1), i+arg'low(2)),
                            result (i)'length);
    end loop;
    return result;
  end function diag;

  -- Return the diagonal of a matrix
  function diag (
    arg : ufixed_vector)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length-1, 0 to arg'length-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := arg (i+arg'low);
        else
          result (i, j) := (others => '0');
        end if;
      end loop;
    end loop;
    return result;
  end function diag;

  function diag (
    arg : sfixed_vector)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length-1, 0 to arg'length-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := arg (i+arg'low);
        else
          result (i, j) := (others => '0');
        end if;
      end loop;
    end loop;
    return result;
  end function diag;

  function diag (
    arg : unsigned_vector)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length-1, 0 to arg'length-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := arg (i+arg'low);
        else
          result (i, j) := (others => '0');
        end if;
      end loop;
    end loop;
    return result;
  end function diag;

  function diag (
    arg : signed_vector)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length-1, 0 to arg'length-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := arg (i+arg'low);
        else
          result (i, j) := (others => '0');
        end if;
      end loop;
    end loop;
    return result;
  end function diag;

  -- Creates a matrix set to the value "val"
  function repmat (
    arg                    : ufixed;
    constant rows, columns : NATURAL)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to rows-1, 0 to columns-1);
  begin  -- repmat
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg,
                                 result (i, j)'high,
                                 result (i, j)'low);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function repmat;

  function repmat (
    arg                    : ufixed;
    constant rows, columns : NATURAL)
    return ufixed_vector is
    variable result : ufixed_vector (0 to columns-1);
  begin  -- repmat
    if rows /= 1 then
      report fixed_matrix_pkg'instance_name & "repmat" &
        " return vector, number of rows not 1, was " &
        INTEGER'image(rows) severity error;
    else
      for i in result'range loop
        result (i) := resize (arg, result (i)'high, result (i)'low);
      end loop;  -- i
    end if;
    return result;
  end function repmat;

  function repmat (
    arg                    : sfixed;
    constant rows, columns : NATURAL)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to rows-1, 0 to columns-1);
  begin  -- repmat
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg,
                                 result (i, j)'high,
                                 result (i, j)'low);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function repmat;

  function repmat (
    arg                    : sfixed;
    constant rows, columns : NATURAL)
    return sfixed_vector is
    variable result : sfixed_vector (0 to columns-1);
  begin  -- repmat
    if rows /= 1 then
      report fixed_matrix_pkg'instance_name & "repmat" &
        " return vector, number of rows not 1, was " &
        INTEGER'image(rows) severity error;
    else
      for i in result'range loop
        result (i) := resize (arg, result (i)'high, result (i)'low);
      end loop;  -- i
    end if;
    return result;
  end function repmat;

  function repmat (
    arg                    : UNSIGNED;
    constant rows, columns : NATURAL)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to rows-1, 0 to columns-1);
  begin  -- repmat
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg, result (i, j)'length);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function repmat;

  function repmat (
    arg                    : UNSIGNED;
    constant rows, columns : NATURAL)
    return unsigned_vector is
    variable result : unsigned_vector (0 to columns-1);
  begin  -- repmat
    if rows /= 1 then
      report fixed_matrix_pkg'instance_name & "repmat" &
        " return vector, number of rows not 1, was " &
        INTEGER'image(rows) severity error;
    else
      for i in result'range loop
        result (i) := resize (arg, result (i)'length);
      end loop;  -- i
    end if;
    return result;
  end function repmat;
  
  function repmat (
    arg                    : SIGNED;
    constant rows, columns : NATURAL)
    return signed_matrix is
    variable result : signed_matrix (0 to rows-1, 0 to columns-1);
  begin  -- repmat
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (arg, result (i, j)'length);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function repmat;

  function repmat (
    arg                    : SIGNED;
    constant rows, columns : NATURAL)
    return signed_vector is
    variable result : signed_vector (0 to columns-1);
  begin  -- repmat
    if rows /= 1 then
      report fixed_matrix_pkg'instance_name & "repmat" &
        " return vector, number of rows not 1, was " &
        INTEGER'image(rows) severity error;
    else
      for i in result'range loop
        result (i) := resize (arg, result (i)'length);
      end loop;  -- i
    end if;
    return result;
  end function repmat;

  -- Return the matrix of a diagonal
  function blkdiag (
    arg : ufixed_vector)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length-1, 0 to arg'length-1);
    constant zero   : ufixed (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := resize (arg (i+arg'low),
                                   result (i, j)'high,
                                   result (i, j)'low);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'high,
                                   result (i, j)'low);
        end if;
      end loop;
    end loop;
    return result;
  end function blkdiag;

  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  -- This differs from the function of "blkdiag" in MatLab
  function blockdiag (
    arg : ufixed_matrix;
    rep : POSITIVE)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to (arg'length(1)*rep)-1,
                                     0 to (arg'length(2)*rep)-1);
    constant zero : ufixed (1 downto 0) := "00";
  begin
    -- Zero out the result matrix
    result := repmat (zero, arg'length(1)*rep, arg'length(2)*rep);
    -- Fill in across the diagonal
    for k in 0 to rep-1 loop
      for m in 0 to arg'length(1)-1 loop
        for n in 0 to arg'length(2)-1 loop
          result ((k*arg'length(1))+m, (k*arg'length(2))+n) :=
            resize (arg (m+arg'low(1), n+arg'low(2)),
                    result ((k*arg'length(1))+m, (k*arg'length(2))+n)'high,
                    result ((k*arg'length(1))+m, (k*arg'length(2))+n)'low);
        end loop;
      end loop;
    end loop;
    return result;
  end function blockdiag;

  -- Return the lower triangle of a matrix
  function tril (
    arg : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    constant zero : ufixed (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i > j then
          result (i, j) := resize (arg (i+ arg'low(1), j+arg'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'high,
                                   result (i, j)'low);
        end if;
      end loop;
    end loop;
    return result;
  end function tril;

  -- Return the upper triangle of a matrix
  function triu (
    arg : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    constant zero : ufixed (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i < j then
          result (i, j) := resize (arg (i+ arg'low(1), j+arg'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'high,
                                   result (i, j)'low);
        end if;
      end loop;
    end loop;
    return result;
  end function triu;

  -- Return the matrix of a diagonal
  function blkdiag (
    arg : sfixed_vector)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length-1, 0 to arg'length-1);
    constant zero   : sfixed (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := resize (arg (i+arg'low),
                                   result (i, j)'high,
                                   result (i, j)'low);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'high,
                                   result (i, j)'low);
        end if;
      end loop;
    end loop;
    return result;
  end function blkdiag;

  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  -- This differs from the function of "blkdiag" in MatLab
  function blockdiag (
    arg : sfixed_matrix;
    rep : POSITIVE)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to (arg'length(1)*rep)-1,
                                     0 to (arg'length(2)*rep)-1);
    constant zero : sfixed (1 downto 0) := "00";
  begin
    -- Zero out the result matrix
    result := repmat (zero, arg'length(1)*rep, arg'length(2)*rep);
    -- Fill in across the diagonal
    for k in 0 to rep-1 loop
      for m in 0 to arg'length(1)-1 loop
        for n in 0 to arg'length(2)-1 loop
          result ((k*arg'length(1))+m, (k*arg'length(2))+n) :=
            resize (arg (m+arg'low(1), n+arg'low(2)),
                    result ((k*arg'length(1))+m, (k*arg'length(2))+n)'high,
                    result ((k*arg'length(1))+m, (k*arg'length(2))+n)'low);
        end loop;
      end loop;
    end loop;
    return result;
  end function blockdiag;

  -- Return the lower triangle of a matrix
  function tril (
    arg : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    constant zero : sfixed (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i > j then
          result (i, j) := resize (arg (i+ arg'low(1), j+arg'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'high,
                                   result (i, j)'low);
        end if;
      end loop;
    end loop;
    return result;
  end function tril;

  -- Return the upper triangle of a matrix
  function triu (
    arg : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    constant zero : sfixed (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i < j then
          result (i, j) := resize (arg (i+ arg'low(1), j+arg'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'high,
                                   result (i, j)'low);
        end if;
      end loop;
    end loop;
    return result;
  end function triu;

  -- Return the matrix of a diagonal
  function blkdiag (
    arg : unsigned_vector)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length-1, 0 to arg'length-1);
    constant zero   : UNSIGNED (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := resize (arg (i+arg'low),
                                   result (i, j)'length);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'length);
        end if;
      end loop;
    end loop;
    return result;
  end function blkdiag;

  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  -- This differs from the function of "blkdiag" in MatLab
  function blockdiag (
    arg : unsigned_matrix;
    rep : POSITIVE)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to (arg'length(1)*rep)-1,
                                       0 to (arg'length(2)*rep)-1);
    constant zero : UNSIGNED (1 downto 0) := "00";
  begin
    -- Zero out the result matrix
    result := repmat (zero, arg'length(1)*rep, arg'length(2)*rep);
    -- Fill in across the diagonal
    for k in 0 to rep-1 loop
      for m in 0 to arg'length(1)-1 loop
        for n in 0 to arg'length(2)-1 loop
          result ((k*arg'length(1))+m, (k*arg'length(2))+n) :=
            resize (arg (m+arg'low(1), n+arg'low(2)),
                    result ((k*arg'length(1))+m, (k*arg'length(2))+n)'length);
        end loop;
      end loop;
    end loop;
    return result;
  end function blockdiag;

  -- Return the lower triangle of a matrix
  function tril (
    arg : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length(1)-1,
                                       0 to arg'length(2)-1);
    constant zero : UNSIGNED (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i > j then
          result (i, j) := resize (arg (i+ arg'low(1), j+arg'low(2)),
                                   result (i, j)'length);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'length);
        end if;
      end loop;
    end loop;
    return result;
  end function tril;

  -- Return the upper triangle of a matrix
  function triu (
    arg : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length(1)-1,
                                       0 to arg'length(2)-1);
    constant zero : UNSIGNED (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i < j then
          result (i, j) := resize (arg (i+ arg'low(1), j+arg'low(2)),
                                   result (i, j)'length);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'length);
        end if;
      end loop;
    end loop;
    return result;
  end function triu;

  -- Return the matrix of a diagonal
  function blkdiag (
    arg : signed_vector)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length-1, 0 to arg'length-1);
    constant zero   : SIGNED (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i = j then
          result (i, j) := resize (arg (i+arg'low),
                                   result (i, j)'length);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'length);
        end if;
      end loop;
    end loop;
    return result;
  end function blkdiag;

  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  -- This differs from the function of "blkdiag" in MatLab
  function blockdiag (
    arg : signed_matrix;
    rep : POSITIVE)
    return signed_matrix is
    variable result : signed_matrix (0 to (arg'length(1)*rep)-1,
                                     0 to (arg'length(2)*rep)-1);
    constant zero : SIGNED (1 downto 0) := "00";
  begin
    -- Zero out the result matrix
    result := repmat (zero, arg'length(1)*rep, arg'length(2)*rep);
    -- Fill in across the diagonal
    for k in 0 to rep-1 loop
      for m in 0 to arg'length(1)-1 loop
        for n in 0 to arg'length(2)-1 loop
          result ((k*arg'length(1))+m, (k*arg'length(2))+n) :=
            resize (arg (m+arg'low(1), n+arg'low(2)),
                    result ((k*arg'length(1))+m, (k*arg'length(2))+n)'length);
        end loop;
      end loop;
    end loop;
    return result;
  end function blockdiag;

  -- Return the lower triangle of a matrix
  function tril (
    arg : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    constant zero : SIGNED (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i > j then
          result (i, j) := resize (arg (i+ arg'low(1), j+arg'low(2)),
                                   result (i, j)'length);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'length);
        end if;
      end loop;
    end loop;
    return result;
  end function tril;

  -- Return the upper triangle of a matrix
  function triu (
    arg : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    constant zero : SIGNED (1 downto 0) := "00";
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if i < j then
          result (i, j) := resize (arg (i+ arg'low(1), j+arg'low(2)),
                                   result (i, j)'length);
        else
          result (i, j) := resize (zero,
                                   result (i, j)'length);
        end if;
      end loop;
    end loop;
    return result;
  end function triu;

  -----------------------------------------------------------------------------
  -- Operators
  -----------------------------------------------------------------------------

  function "*" (
    l, r : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to l'length(1)-1,
                                     0 to r'length(2)-1);
  begin  -- multiply
    if l'length(2) /= r'length(1) then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length(2)) &
        " and rows or right = " & INTEGER'image (r'length(1))
        & " should be equal" severity error;
    elsif isempty (l) or isempty(r) then
      -- Silently return an empty matrix
      result := zeros(result'length(1), result'length(2));
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l(i+l'low(1), l'low(2)) *
                                   r(r'low(1), j+r'low(2)),
                                   result(i, j)'high,
                                   result(i, j)'low);
          for k in 1 to l'length(2)-1 loop
            result (i, j) := resize (result (i, j) +
                                     (l(i+l'low(1), k+l'low(2)) *
                                      r(k+r'low(1), j+r'low(2))),
                                     result(i, j)'high,
                                     result(i, j)'low);
          end loop;  -- k
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : ufixed_matrix;
    r : ufixed_vector)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to l'length(1)-1,
                                     0 to r'length-1);
  begin  -- multiply
    if l'length(2) /= 1 then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & " Matrix must have only one column to be multiplied by a vector, "
        & " l (" & INTEGER'image(l'length(1)) & ","
        & INTEGER'image(l'length(2)) & ") * r (" & INTEGER'image(r'length) &
        ") invalid" severity error;
    elsif l'length(1) /= r'length then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "rows of left matrix = " & INTEGER'image(l'length(1)) &
        " and size of right vector = " & INTEGER'image(r'length)
        & " should be equal" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l(i+l'low(1), l'low(2)) * r(j+r'low),
                                   result(i, j)'high,
                                   result(i, j)'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : ufixed_vector;
    r : ufixed_matrix)
    return ufixed_vector is
    variable result : ufixed_vector (0 to r'length(2)-1);
  begin  -- multiply
    if l'length /= r'length(1) then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "left vector length = " & INTEGER'image(l'length) &
        " and rows in right matrix = " & INTEGER'image(r'length(1))
        & " should be equal" severity error;
    elsif isempty(r) or isempty (l) then
      -- Silently return an empty matrix
      result := zeros (1, result'length);
    else
      for i in result'range loop
        result (i) := resize (l(l'low) * r(r'low(1), i+r'low(2)),
                              result (i)'high,
                              result (i)'low);
        for k in 1 to r'length(1)-1 loop
          result (i) := resize (result (i) + (l(k+l'low) *
                                              r(k+r'low(1), i+r'low(2))),
                                result(i)'high,
                                result(i)'low);
        end loop;  -- k
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : ufixed;
    r : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to r'length(1)-1,
                                     0 to r'length(2)-1);
  begin  -- multiply
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (l * r (i+r'low(1), j+r'low(2)),
                                 result (i, j)'high,
                                 result (i, j)'low);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : ufixed_matrix;
    r : ufixed)
    return ufixed_matrix is
  begin  -- multiply
    return r * l;
  end function "*";

  function "*" (
    l : ufixed;
    r : ufixed_vector)
    return ufixed_vector is
    variable result : ufixed_vector (0 to r'length-1);
  begin  -- multiply
    for i in result'range loop
      result (i) := resize (l * r (i+r'low),
                            result (i)'high,
                            result (i)'low);
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : ufixed_vector;
    r : ufixed)
    return ufixed_vector is
  begin
    return r * l;
  end function "*";

  -----------------------------------------------------------------------------
  -- Signed fixed point multiply
  -----------------------------------------------------------------------------
  function "*" (
    l, r : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to l'length(1)-1,
                                     0 to r'length(2)-1);
  begin  -- multiply
    if l'length(2) /= r'length(1) then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length(2)) &
        " and rows or right = " & INTEGER'image (r'length(1))
        & " should be equal" severity error;
    elsif isempty (l) or isempty(r) then
      -- Silently return an empty matrix
      result := zeros(result'length(1), result'length(2));
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l(i+l'low(1), l'low(2)) *
                                   r(r'low(1), j+r'low(2)),
                                   result(i, j)'high,
                                   result(i, j)'low);
          for k in 1 to l'length(2)-1 loop
            result (i, j) := resize (result (i, j) +
                                     (l(i+l'low(1), k+l'low(2)) *
                                      r(k+r'low(1), j+r'low(2))),
                                     result(i, j)'high,
                                     result(i, j)'low);
          end loop;  -- k
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : sfixed_vector)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to l'length(1)-1,
                                     0 to r'length-1);
  begin  -- multiply
    if l'length(2) /= 1 then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & " Matrix must have only one column to be multiplied by a vector, "
        & " l (" & INTEGER'image(l'length(1)) & ","
        & INTEGER'image(l'length(2)) & ") * r (" & INTEGER'image(r'length) &
        ") invalid" severity error;
    elsif l'length(1) /= r'length then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "rows of left matrix = " & INTEGER'image(l'length(1)) &
        " and size of right vector = " & INTEGER'image(r'length)
        & " should be equal" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l(i+l'low(1), l'low(2)) * r(j+r'low),
                                   result(i, j)'high,
                                   result(i, j)'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : sfixed_vector;
    r : sfixed_matrix)
    return sfixed_vector is
    variable result : sfixed_vector (0 to r'length(2)-1);
  begin  -- multiply
    if l'length /= r'length(1) then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "left vector length = " & INTEGER'image(l'length) &
        " and rows in right matrix = " & INTEGER'image(r'length(1))
        & " should be equal" severity error;
    elsif isempty(r) or isempty (l) then
      -- Silently return an empty matrix
      result := zeros (1, result'length);
    else
      for i in result'range loop
        result (i) := resize (l(l'low) * r(r'low(1), i+r'low(2)),
                              result (i)'high,
                              result (i)'low);
        for k in 1 to r'length(1)-1 loop
          result (i) := resize (result (i) + (l(k+l'low) *
                                              r(k+r'low(1), i+r'low(2))),
                                result(i)'high,
                                result(i)'low);
        end loop;  -- k
      end loop;  -- i
    end if;
    return result;
  end function "*";


  function "*" (
    l : sfixed;
    r : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to r'length(1)-1,
                                     0 to r'length(2)-1);
  begin  -- multiply
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (l * r (i+r'low(1), j+r'low(2)),
                                 result (i, j)'high,
                                 result (i, j)'low);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : sfixed)
    return sfixed_matrix is
  begin  -- multiply
    return r * l;
  end function "*";

  function "*" (
    l : sfixed;
    r : sfixed_vector)
    return sfixed_vector is
    variable result : sfixed_vector (0 to r'length-1);
  begin  -- multiply
    for i in result'range loop
      result (i) := resize (l * r (i+r'low),
                            result (i)'high,
                            result (i)'low);
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : sfixed_vector;
    r : sfixed)
    return sfixed_vector is
  begin
    return r * l;
  end function "*";

  -----------------------------------------------------------------------------
  -- unsigned multiply
  -----------------------------------------------------------------------------

  function "*" (
    l, r : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to l'length(1)-1,
                                       0 to r'length(2)-1);
  begin  -- multiply
    if l'length(2) /= r'length(1) then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length(2)) &
        " and rows or right = " & INTEGER'image (r'length(1))
        & " should be equal" severity error;
    elsif isempty (l) or isempty(r) then
      -- Silently return an empty matrix
      result := zeros(result'length(1), result'length(2));
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l(i+l'low(1), l'low(2)) *
                                   r(r'low(1), j+r'low(2)),
                                   result(i, j)'length);
          for k in 1 to l'length(2)-1 loop
            result (i, j) := resize (result (i, j) +
                                     (l(i+l'low(1), k+l'low(2)) *
                                      r(k+r'low(1), j+r'low(2))),
                                     result(i, j)'length);
          end loop;  -- k
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : unsigned_matrix;
    r : unsigned_vector)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to l'length(1)-1,
                                       0 to r'length-1);
  begin  -- multiply
    if l'length(2) /= 1 then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & " Matrix must have only one column to be multiplied by a vector, "
        & " l (" & INTEGER'image(l'length(1)) & ","
        & INTEGER'image(l'length(2)) & ") * r (" & INTEGER'image(r'length) &
        ") invalid" severity error;
    elsif l'length(1) /= r'length then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "rows of left matrix = " & INTEGER'image(l'length(1)) &
        " and size of right vector = " & INTEGER'image(r'length)
        & " should be equal" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l(i+l'low(1), l'low(2)) * r(j+r'low),
                                   result(i, j)'length);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : unsigned_vector;
    r : unsigned_matrix)
    return unsigned_vector is
    variable result : unsigned_vector (0 to r'length(2)-1);
  begin  -- multiply
    if l'length /= r'length(1) then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "left vector length = " & INTEGER'image(l'length) &
        " and rows in right matrix = " & INTEGER'image(r'length(1))
        & " should be equal" severity error;
    elsif isempty(r) or isempty (l) then
      -- Silently return an empty matrix
      result := zeros (1, result'length);
    else
      for i in result'range loop
        result (i) := resize (l(l'low) * r(r'low(1), i+r'low(2)),
                              result (i)'length);
        for k in 1 to r'length(1)-1 loop
          result (i) := resize (result (i) + (l(k+l'low) *
                                              r(k+r'low(1), i+r'low(2))),
                                result(i)'length);
        end loop;  -- k
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : UNSIGNED;
    r : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to r'length(1)-1,
                                       0 to r'length(2)-1);
  begin  -- multiply
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (l * r (i+r'low(1), j+r'low(2)),
                                 result (i, j)'length);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : unsigned_matrix;
    r : UNSIGNED)
    return unsigned_matrix is
  begin  -- multiply
    return r * l;
  end function "*";

  function "*" (
    l : UNSIGNED;
    r : unsigned_vector)
    return unsigned_vector is
    variable result : unsigned_vector (0 to r'length-1);
  begin  -- multiply
    for i in result'range loop
      result (i) := resize (l * r (i+r'low),
                            result (i)'length);
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : unsigned_vector;
    r : UNSIGNED)
    return unsigned_vector is
  begin
    return r * l;
  end function "*";

  -----------------------------------------------------------------------------
  -- signed multiply
  -----------------------------------------------------------------------------
  function "*" (
    l, r : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to l'length(1)-1,
                                     0 to r'length(2)-1);
  begin  -- multiply
    if l'length(2) /= r'length(1) then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "columns of left = " & INTEGER'image(l'length(2)) &
        " and rows or right = " & INTEGER'image (r'length(1))
        & " should be equal" severity error;
    elsif isempty (l) or isempty(r) then
      -- Silently return an empty matrix
      result := zeros(result'length(1), result'length(2));
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l(i+l'low(1), l'low(2)) *
                                   r(r'low(1), j+r'low(2)),
                                   result(i, j)'length);
          for k in 1 to l'length(2)-1 loop
            result (i, j) := resize (result (i, j) +
                                     (l(i+l'low(1), k+l'low(2)) *
                                      r(k+r'low(1), j+r'low(2))),
                                     result(i, j)'length);
          end loop;  -- k
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : signed_matrix;
    r : signed_vector)
    return signed_matrix is
    variable result : signed_matrix (0 to l'length(1)-1,
                                     0 to r'length-1);
  begin  -- multiply
    if l'length(2) /= 1 then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & " Matrix must have only one column to be multiplied by a vector, "
        & " l (" & INTEGER'image(l'length(1)) & ","
        & INTEGER'image(l'length(2)) & ") * r (" & INTEGER'image(r'length) &
        ") invalid" severity error;
    elsif l'length(1) /= r'length then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "rows of left matrix = " & INTEGER'image(l'length(1)) &
        " and size of right vector = " & INTEGER'image(r'length)
        & " should be equal" severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l(i+l'low(1), l'low(2)) * r(j+r'low),
                                   result (i, j)'length);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : signed_vector;
    r : signed_matrix)
    return signed_vector is
    variable result : signed_vector (0 to r'length(2)-1);
  begin  -- multiply
    if l'length /= r'length(1) then
      report fixed_matrix_pkg'instance_name & "Multiply "
        & "left vector length = " & INTEGER'image(l'length) &
        " and rows in right matrix = " & INTEGER'image(r'length(1))
        & " should be equal" severity error;
    elsif isempty(r) or isempty (l) then
      -- Silently return an empty matrix
      result := zeros (1, result'length);
    else
      for i in result'range loop
        result (i) := resize (l(l'low) * r(r'low(1), i+r'low(2)),
                              result (i)'length);
        for k in 1 to r'length(1)-1 loop
          result (i) := resize (result (i) + (l(k+l'low) *
                                              r(k+r'low(1), i+r'low(2))),
                                result(i)'length);
        end loop;  -- k
      end loop;  -- i
    end if;
    return result;
  end function "*";

  function "*" (
    l : SIGNED;
    r : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to r'length(1)-1,
                                     0 to r'length(2)-1);
  begin  -- multiply
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (l * r (i+r'low(1), j+r'low(2)),
                                 result (i, j)'length);
      end loop;  -- j
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : signed_matrix;
    r : SIGNED)
    return signed_matrix is
  begin  -- multiply
    return r * l;
  end function "*";

  function "*" (
    l : SIGNED;
    r : signed_vector)
    return signed_vector is
    variable result : signed_vector (0 to r'length-1);
  begin  -- multiply
    for i in result'range loop
      result (i) := resize (l * r (i+r'low),
                            result (i)'length);
    end loop;  -- i
    return result;
  end function "*";

  function "*" (
    l : signed_vector;
    r : SIGNED)
    return signed_vector is
  begin
    return r * l;
  end function "*";

  -----------------------------------------------------------------------------
  -- Division
  -----------------------------------------------------------------------------
  function "/" (
    l : ufixed_matrix;
    r : ufixed)
    return ufixed_matrix is
  begin
    return reciprocal (r) * l;
  end function "/";

  function "/" (
    l : ufixed_vector;
    r : ufixed)
    return ufixed_vector is
  begin
    return reciprocal (r) * l;
  end function "/";

  function "/" (
    l : sfixed_matrix;
    r : sfixed)
    return sfixed_matrix is
  begin
    return reciprocal (r) * l;
  end function "/";

  function "/" (
    l : sfixed_vector;
    r : sfixed)
    return sfixed_vector is
  begin
    return reciprocal (r) * l;
  end function "/";

  -----------------------------------------------------------------------------
  -- Addition
  -----------------------------------------------------------------------------
  function "+" (
    l, r : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- addition
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Addition " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l (i+l'low(1), j+l'low(2)) +
                                   r (i+r'low(1), j+r'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "+";

  function "+" (
    l, r : ufixed_vector)
    return ufixed_vector is
    variable result : ufixed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Addition " &
        "Vector lengths do not match l(" & INTEGER'image(l'length) &
        ") /= r(" & INTEGER'image(r'length) & ")" severity error;
    else
      for i in result'range loop
        result(i) := resize (l(l'low+i) + r(r'low+i),
                             result(i)'high,
                             result(i)'low);
      end loop;
    end if;
    return result;
  end function "+";

  function "+" (
    l, r : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- addition
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Addition " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l (i+l'low(1), j+l'low(2)) +
                                   r (i+r'low(1), j+r'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "+";

  function "+" (
    l, r : sfixed_vector)
    return sfixed_vector is
    variable result : sfixed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Addition " &
        "Vector lengths do not match l(" & INTEGER'image(l'length) &
        ") /= r(" & INTEGER'image(r'length) & ")" severity error;
    else
      for i in result'range loop
        result(i) := resize (l(l'low+i) + r(r'low+i),
                             result(i)'high,
                             result(i)'low);
      end loop;
    end if;
    return result;
  end function "+";

  function "+" (
    l, r : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to l'length(1)-1,
                                       0 to l'length(2)-1);
  begin  -- addition
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Addition " &
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
    l, r : unsigned_vector)
    return unsigned_vector is
    variable result : unsigned_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Addition " &
        "Vector lengths do not match l(" & INTEGER'image(l'length) &
        ") /= r(" & INTEGER'image(r'length) & ")" severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) + r(r'low+i);
      end loop;
    end if;
    return result;
  end function "+";

  function "+" (
    l, r : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- addition
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Addition " &
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
    l, r : signed_vector)
    return signed_vector is
    variable result : signed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Addition " &
        "Vector lengths do not match l(" & INTEGER'image(l'length) &
        ") /= r(" & INTEGER'image(r'length) & ")" severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) + r(r'low+i);
      end loop;
    end if;
    return result;
  end function "+";

  -----------------------------------------------------------------------------
  -- Subtraction
  -----------------------------------------------------------------------------
  function "-" (
    l, r : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- subtraction
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Subtraction " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l (i+l'low(1), j+l'low(2)) -
                                   r (i+r'low(1), j+r'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "-";

  function "-" (
    l, r : ufixed_vector)
    return ufixed_vector is
    variable result : ufixed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Subtraction " &
        "Vector lengths do not match l(" & INTEGER'image(l'length) &
        ") /= r(" & INTEGER'image(r'length) & ")" severity error;
    else
      for i in result'range loop
        result(i) := resize (l(l'low+i) - r(r'low+i),
                             result(i)'high,
                             result(i)'low);
      end loop;
    end if;
    return result;
  end function "-";

  function "-" (
    l, r : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- subtraction
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Subtraction " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l (i+l'low(1), j+l'low(2)) -
                                   r (i+r'low(1), j+r'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function "-";

  function "-" (
    l, r : sfixed_vector)
    return sfixed_vector is
    variable result : sfixed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Subtraction " &
        "Vector lengths do not match l(" & INTEGER'image(l'length) &
        ") /= r(" & INTEGER'image(r'length) & ")" severity error;
    else
      for i in result'range loop
        result(i) := resize (l(l'low+i) - r(r'low+i),
                             result(i)'high,
                             result(i)'low);
      end loop;
    end if;
    return result;
  end function "-";

  function "-" (
    arg : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := resize (- (arg(i, j)),
                                result(i, j)'high,
                                result(i, j)'low);
      end loop;
    end loop;
    return result;
  end function "-";

  function "-" (
    arg : sfixed_vector)
    return sfixed_vector is
    variable result : sfixed_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := resize (- (arg(i)),
                           result(i)'high,
                           result(i)'low);
    end loop;
    return result;
  end function "-";

  function "-" (
    l, r : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to l'length(1)-1,
                                       0 to l'length(2)-1);
  begin  -- subtraction
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Subtraction " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
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
    l, r : unsigned_vector)
    return unsigned_vector is
    variable result : unsigned_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Subtraction " &
        "Vector lengths do not match l(" & INTEGER'image(l'length) &
        ") /= r(" & INTEGER'image(r'length) & ")" severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) - r(r'low+i);
      end loop;
    end if;
    return result;
  end function "-";

  function "-" (
    l, r : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- subtraction
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Subtraction " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
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
    l, r : signed_vector)
    return signed_vector is
    variable result : signed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Subtraction " &
        "Vector lengths do not match l(" & INTEGER'image(l'length) &
        ") /= r(" & INTEGER'image(r'length) & ")" severity error;
    else
      for i in result'range loop
        result(i) := l(l'low+i) - r(r'low+i);
      end loop;
    end if;
    return result;
  end function "-";

  function "-" (
    arg : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := - arg(i, j);
      end loop;
    end loop;
    return result;
  end function "-";

  function "-" (
    arg : signed_vector)
    return signed_vector is
    variable result : signed_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := - arg(i);
    end loop;
    return result;
  end function "-";

  -- Absolute value
  function "abs" (
    arg : sfixed_vector)
    return sfixed_vector is
    variable result : sfixed_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := resize (abs (arg(i)),
                           result(i)'high,
                           result(i)'low);
    end loop;
    return result;
  end function "abs";

  function "abs" (
    arg : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := resize (abs (arg(i, j)),
                                result(i, j)'high,
                                result(i, j)'low);
      end loop;
    end loop;
    return result;
  end function "abs";

  -- Absolute value
  function "abs" (
    arg : signed_vector)
    return signed_vector is
    variable result : signed_vector (arg'range);
  begin
    for i in result'range loop
      result(i) := abs (arg(i));
    end loop;
    return result;
  end function "abs";

  function "abs" (
    arg : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result(i, j) := abs (arg(i, j));
      end loop;
    end loop;
    return result;
  end function "abs";

  -- MatLab .* operator
  -- purpose: element by element multiply, MatLab .* operator
  function times (
    l, r : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- ".*"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "times " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l (i+l'low(1), j+l'low(2)) *
                                   r (i+r'low(1), j+r'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function times;

  -- purpose: vector multiplication ".*" operator
  function times (
    l, r : ufixed_vector)
    return ufixed_vector is
    variable result : ufixed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "times " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := resize (l(l'low+i) * r(r'low+i),
                             result(i)'high,
                             result(i)'low);
      end loop;
    end if;
    return result;
  end function times;

  -- purpose: element by element multiply, MatLab .* operator
  function times (
    l, r : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- ".*"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "times " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l (i+l'low(1), j+l'low(2)) *
                                   r (i+r'low(1), j+r'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function times;

  -- purpose: vector multiplication ".*" operator
  function times (
    l, r : sfixed_vector)
    return sfixed_vector is
    variable result : sfixed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "times " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := resize (l(l'low+i) * r(r'low+i),
                             result(i)'high,
                             result(i)'low);
      end loop;
    end if;
    return result;
  end function times;

  -- purpose: element by element multiply, MatLab .* operator
  function times (
    l, r : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to l'length(1)-1,
                                       0 to l'length(2)-1);
  begin  -- ".*"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "times " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l (i+l'low(1), j+l'low(2)) *
                                   r (i+r'low(1), j+r'low(2)),
                                   result (i, j)'length);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function times;

  -- purpose: vector multiplication ".*" operator
  function times (
    l, r : unsigned_vector)
    return unsigned_vector is
    variable result : unsigned_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "times " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := resize (l(l'low+i) * r(r'low+i),
                             result(i)'length);
      end loop;
    end if;
    return result;
  end function times;

  -- purpose: element by element multiply, MatLab .* operator
  function times (
    l, r : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- ".*"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "times " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l (i+l'low(1), j+l'low(2)) *
                                   r (i+r'low(1), j+r'low(2)),
                                   result (i, j)'length);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function times;

  -- purpose: vector multiplication ".*" operator
  function times (
    l, r : signed_vector)
    return signed_vector is
    variable result : signed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "times " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := resize (l(l'low+i) * r(r'low+i),
                             result(i)'length);
      end loop;
    end if;
    return result;
  end function times;

  -- purpose: element by element divide, MatLab "./" operator
  function rdivide (
    l, r : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- "./"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "rdivide " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l (i+l'low(1), j+l'low(2)) /
                                   r (i+r'low(1), j+r'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function rdivide;

  -- purpose: vector multiplication "./" operator
  function rdivide (
    l, r : ufixed_vector)
    return ufixed_vector is
    variable result : ufixed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "rdivide " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := resize (l(l'low+i) / r(r'low+i),
                             result(i)'high,
                             result(i)'low);
      end loop;
    end if;
    return result;
  end function rdivide;

  -- purpose: element by element divide, MatLab "./" operator
  function rdivide (
    l, r : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to l'length(1)-1,
                                     0 to l'length(2)-1);
  begin  -- "./"
    if l'length(1) /= r'length(1) or l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "rdivide " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r(" &
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (l (i+l'low(1), j+l'low(2)) /
                                   r (i+r'low(1), j+r'low(2)),
                                   result (i, j)'high,
                                   result (i, j)'low);
        end loop;  -- j
      end loop;  -- i
    end if;
    return result;
  end function rdivide;

  -- purpose: vector multiplication "./" operator
  function rdivide (
    l, r : sfixed_vector)
    return sfixed_vector is
    variable result : sfixed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "rdivide " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in result'range loop
        result(i) := resize (l(l'low+i) / r(r'low+i),
                             result(i)'high,
                             result(i)'low);
      end loop;
    end if;
    return result;
  end function rdivide;

  -- MatLab / operator
  function "/" (
    l, r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  -- MatLab / operator
  function mrdivide (
    l, r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return l * inv(r);
  end function mrdivide;

  -- MatLab \ operator (= .\ function)
  function mldivide (
    l, r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return inv(l)*r;
  end function mldivide;

  -- Raise a matrix to a power ^ operator
  -- These functions are recursive!
  -- %%% These two functions belong in "fixed_generic_pkg", and not here.
  function "**" (
    arg : ufixed;
    pow : INTEGER)
    return ufixed is
    variable result : ufixed (arg'range);
    variable Half   : INTEGER;
  begin
    if pow < 0 then
      result := resize (reciprocal(arg)**(-pow),
                        result'high,
                        result'low);
    elsif pow = 0 then
      result := resize (ufixed_one, result'high, result'low);
    elsif pow = 1 then
      result := arg;
    elsif pow = 2 then
      result := resize (arg * arg,
                        result'high,
                        result'low);
    else
      Half := pow / 2;
      result := resize ((arg**Half) * (arg**(pow-Half)),
                        result'high,
                        result'low);
    end if;
    return result;
  end function "**";

  function "**" (
    arg : sfixed;
    pow : INTEGER)
    return sfixed is
    variable result : sfixed (arg'range);
    variable Half   : INTEGER;
  begin
    if pow < 0 then
      result := resize (reciprocal(arg)**(-pow),
                        result'high,
                        result'low);
    elsif pow = 0 then
      result := resize (sfixed_one, result'high, result'low);
    elsif pow = 1 then
      result := arg;
    elsif pow = 2 then
      result := resize (arg * arg,
                        result'high,
                        result'low);
    else
      Half := pow / 2;
      result := resize ((arg**Half) * (arg**(pow-Half)),
                        result'high,
                        result'low);
    end if;
    return result;
  end function "**";

  -- Raise a matrix to a power, "^" operator
  -- Recursive
  function "**" (
    arg : ufixed_matrix;
    pow : NATURAL)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable Half : INTEGER;
  begin
    if arg'length(1) /= arg'length(2) then
      report fixed_matrix_pkg'instance_name & "** " &
        "Matrix is not square (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ")" severity error;
      return arg;
    elsif pow = 0 then
      return ones (arg'length(1), arg'length(2));
    elsif pow = 1 then
      return arg;
    elsif pow = 2 then
      return arg * arg;
    else  -- Recursively call this function until complete
      Half   := pow / 2;
      result := (arg**Half) * (arg**(pow-Half));
      return result;
    end if;
  end function "**";

  -- Raise a matrix to a power, "^" operator
  -- Recursive
  function "**" (
    arg : sfixed_matrix;
    pow : INTEGER)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable Half : INTEGER;
  begin
    if arg'length(1) /= arg'length(2) then
      report fixed_matrix_pkg'instance_name & "** " &
        "Matrix is not square (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ")" severity error;
      return arg;
    elsif pow < 0 then
      -- arg^(-1) = inv(arg)  arg^(-2) = inv(arg)^2
      return inv(arg)**(-pow);
    elsif pow = 0 then
      return ones (arg'length(1), arg'length(2));
    elsif pow = 1 then
      return arg;
    elsif pow = 2 then
      return arg * arg;
    else  -- Recursively call this function until complete
      Half   := pow / 2;
      result := (arg**Half) * (arg**(pow-Half));
      return result;
    end if;
  end function "**";

  -- Raise a matrix to a power, "^" operator
  -- Recursive
  function "**" (
    arg : unsigned_matrix;
    pow : NATURAL)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length(1)-1,
                                       0 to arg'length(2)-1);
    variable Half : INTEGER;
  begin
    if arg'length(1) /= arg'length(2) then
      report fixed_matrix_pkg'instance_name & "** " &
        "Matrix is not square (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ")" severity error;
      return arg;
    elsif pow = 0 then
      return ones (arg'length(1), arg'length(2));
    elsif pow = 1 then
      return arg;
    elsif pow = 2 then
      return arg * arg;
    else  -- Recursively call this function until complete
      Half   := pow / 2;
      result := (arg**Half) * (arg**(pow-Half));
      return result;
    end if;
  end function "**";

  -- Raise a matrix to a power, "^" operator
  -- Recursive
  function "**" (
    arg : signed_matrix;
    pow : NATURAL)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable Half : INTEGER;
  begin
    if arg'length(1) /= arg'length(2) then
      report fixed_matrix_pkg'instance_name & "** " &
        "Matrix is not square (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ")" severity error;
      return arg;
    elsif pow = 0 then
      return ones (arg'length(1), arg'length(2));
    elsif pow = 1 then
      return arg;
    elsif pow = 2 then
      return arg * arg;
    else  -- Recursively call this function until complete
      Half   := pow / 2;
      result := (arg**Half) * (arg**(pow-Half));
      return result;
    end if;
  end function "**";

  -----------------------------------------------------------------------------
  -- compare functions
  -----------------------------------------------------------------------------
  function "=" (
    l : ufixed_matrix;
    r : ufixed_vector)
    return BOOLEAN is
    variable lv : ufixed_vector (0 to r'length-1);
  begin
    if l'length(1) = 1 and l'length(2) = r'length then
      lv := SubMatrix (l, l'low(1), l'low(2), 1, r'length);
      return lv = r;
    else
      return false;
    end if;
  end function "=";

  function "=" (
    l : sfixed_matrix;
    r : sfixed_vector)
    return BOOLEAN is
    variable lv : sfixed_vector (0 to r'length-1);
  begin
    if l'length(1) = 1 and l'length(2) = r'length then
      lv := SubMatrix (l, l'low(1), l'low(2), 1, r'length);
      return lv = r;
    else
      return false;
    end if;
  end function "=";

  function "=" (
    l : unsigned_matrix;
    r : unsigned_vector)
    return BOOLEAN is
    variable lv : unsigned_vector (0 to r'length-1);
  begin
    if l'length(1) = 1 and l'length(2) = r'length then
      lv := SubMatrix (l, l'low(1), l'low(2), 1, r'length);
      return lv = r;
    else
      return false;
    end if;
  end function "=";

  function "=" (
    l : signed_matrix;
    r : signed_vector)
    return BOOLEAN is
    variable lv : signed_vector (0 to r'length-1);
  begin
    if l'length(1) = 1 and l'length(2) = r'length then
      lv := SubMatrix (l, l'low(1), l'low(2), 1, r'length);
      return lv = r;
    else
      return false;
    end if;
  end function "=";

  function "=" (
    l : ufixed_vector;
    r : ufixed_matrix)
    return BOOLEAN is
  begin
    return r = l;
  end function "=";

  function "=" (
    l : sfixed_vector;
    r : sfixed_matrix)
    return BOOLEAN is
  begin
    return r = l;
  end function "=";

  function "=" (
    l : unsigned_vector;
    r : unsigned_matrix)
    return BOOLEAN is
  begin
    return r = l;
  end function "=";

  function "=" (
    l : signed_vector;
    r : signed_matrix)
    return BOOLEAN is
  begin
    return r = l;
  end function "=";

  function "/=" (
    l : ufixed_matrix;
    r : ufixed_vector)
    return BOOLEAN is
  begin
    return not (l = r);
  end function "/=";

  function "/=" (
    l : sfixed_matrix;
    r : sfixed_vector)
    return BOOLEAN is
  begin
    return not (l = r);
  end function "/=";

  function "/=" (
    l : unsigned_matrix;
    r : unsigned_vector)
    return BOOLEAN is
  begin
    return not (l = r);
  end function "/=";

  function "/=" (
    l : signed_matrix;
    r : signed_vector)
    return BOOLEAN is
  begin
    return not (l = r);
  end function "/=";

  function "/=" (
    l : ufixed_vector;
    r : ufixed_matrix)
    return BOOLEAN is
  begin
    return not (r = l);
  end function "/=";

  function "/=" (
    l : sfixed_vector;
    r : sfixed_matrix)
    return BOOLEAN is
  begin
    return not (r = l);
  end function "/=";

  function "/=" (
    l : unsigned_vector;
    r : unsigned_matrix)
    return BOOLEAN is
  begin
    return not (r = l);
  end function "/=";

  function "/=" (
    l : signed_vector;
    r : signed_matrix)
    return BOOLEAN is
  begin
    return not (r = l);
  end function "/=";

  -----------------------------------------------------------------------------
  -- Algorithmic functions
  -----------------------------------------------------------------------------

  -- Sum the diagonal
  function trace (
    arg : ufixed_matrix)
    return ufixed is
  begin
    return sum (diag(arg));
  end function trace;

  -- Sum the diagonal
  function trace (
    arg : sfixed_matrix)
    return sfixed is
  begin
    return sum (diag(arg));
  end function trace;

  -- Sum the diagonal
  function trace (
    arg : unsigned_matrix)
    return UNSIGNED is
  begin
    return sum (diag(arg));
  end function trace;

  -- Sum the diagonal
  function trace (
    arg : signed_matrix)
    return SIGNED is
  begin
    return sum (diag(arg));
  end function trace;

  -- Sum a vector
  function sum (
    arg : ufixed_vector)
    return ufixed is
    variable result : ufixed (arg(arg'low)'range);
  begin
    if isempty (arg) then
      result := (others => '0');
    else
      result := arg (arg'low);
      for i in arg'low+1 to arg'high loop
        result := resize (result + arg(i),
                          result'high,
                          result'low);
      end loop;
    end if;
    return result;
  end function sum;

  -- Sum a vector
  function sum (
    arg : sfixed_vector)
    return sfixed is
    variable result : sfixed (arg(arg'low)'range);
  begin
    if isempty (arg) then
      result := (others => '0');
    else
      result := arg (arg'low);
      for i in arg'low+1 to arg'high loop
        result := resize (result + arg(i),
                          result'high,
                          result'low);
      end loop;
    end if;
    return result;
  end function sum;

  -- Sum a vector
  function sum (
    arg : unsigned_vector)
    return UNSIGNED is
    variable result : UNSIGNED (arg(arg'low)'range);
  begin
    if isempty (arg) then
      result := (others => '0');
    else
      result := arg (arg'low);
      for i in arg'low+1 to arg'high loop
        result := resize (result + arg(i),
                          result'length);
      end loop;
    end if;
    return result;
  end function sum;

  -- Sum a vector
  function sum (
    arg : signed_vector)
    return SIGNED is
    variable result : SIGNED (arg(arg'low)'range);
  begin
    if isempty (arg) then
      result := (others => '0');
    else
      result := arg (arg'low);
      for i in arg'low+1 to arg'high loop
        result := resize (result + arg(i),
                          result'length);
      end loop;
    end if;
    return result;
  end function sum;

  -- Sum a matrix and returns a vector
  function sum (
    arg          : ufixed_matrix;
    constant dim : POSITIVE := 1)                          -- 1 = y, 2 = x
    return ufixed_vector is
    variable resx : ufixed_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : ufixed_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := resize (arg (arg'low(1)+j, arg'low(2)+i),
                              resy(j)'high,
                              resy(j)'low);
        end loop;
        resx (i) := sum (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := resize (arg (arg'low(1)+i, arg'low(2)+j),
                              resx(j)'high,
                              resx(j)'low);
        end loop;
        resy (i) := sum (resx);
      end loop;
      return resy;
    else
      report fixed_matrix_pkg'instance_name & "sum " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function sum;

  -- Sum a matrix and returns a vector
  function sum (
    arg          : sfixed_matrix;
    constant dim : POSITIVE := 1)                          -- 1 = y, 2 = x
    return sfixed_vector is
    variable resx : sfixed_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : sfixed_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := resize (arg (arg'low(1)+j, arg'low(2)+i),
                              resy(j)'high,
                              resy(j)'low);
        end loop;
        resx (i) := sum (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := resize (arg (arg'low(1)+i, arg'low(2)+j),
                              resx(j)'high,
                              resx(j)'low);
        end loop;
        resy (i) := sum (resx);
      end loop;
      return resy;
    else
      report fixed_matrix_pkg'instance_name & "sum " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function sum;

  -- Sum a matrix and returns a vector
  function sum (
    arg          : unsigned_matrix;
    constant dim : POSITIVE := 1)                            -- 1 = y, 2 = x
    return unsigned_vector is
    variable resx : unsigned_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : unsigned_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := resize (arg (arg'low(1)+j, arg'low(2)+i),
                              resy(j)'length);
        end loop;
        resx (i) := sum (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := resize (arg (arg'low(1)+i, arg'low(2)+j),
                              resx(j)'length);
        end loop;
        resy (i) := sum (resx);
      end loop;
      return resy;
    else
      report fixed_matrix_pkg'instance_name & "sum " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function sum;

  -- Sum a matrix and returns a vector
  function sum (
    arg          : signed_matrix;
    constant dim : POSITIVE := 1)                          -- 1 = y, 2 = x
    return signed_vector is
    variable resx : signed_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : signed_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := resize (arg (arg'low(1)+j, arg'low(2)+i),
                              resy(j)'length);
        end loop;
        resx (i) := sum (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := resize (arg (arg'low(1)+i, arg'low(2)+j),
                              resx(j)'length);
        end loop;
        resy (i) := sum (resx);
      end loop;
      return resy;
    else
      report fixed_matrix_pkg'instance_name & "sum " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function sum;

  -- Multiply every element in a vector
  function prod (
    arg : ufixed_vector)
    return ufixed is
    variable result : ufixed (arg(arg'low)'range);
  begin
    if isempty (arg) then
      result    := (others => '0');
      result(0) := '1';                 -- 1.0
    else
      result := resize (arg (arg'low),
                        result'high,
                        result'low);
      for i in arg'low+1 to arg'high loop
        result := resize (result * arg(i),
                          result'high,
                          result'low);
      end loop;
    end if;
    return result;
  end function prod;

  -- Multiply elements in a matrix and returns a vector
  function prod (
    arg          : ufixed_matrix;
    constant dim : POSITIVE := 1)                          -- 1 = y, 2 = x
    return ufixed_vector is
    variable resx : ufixed_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : ufixed_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := resize (arg (arg'low(1)+j, arg'low(2)+i),
                              resy(j)'high,
                              resy(j)'low);
        end loop;
        resx (i) := prod (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := resize (arg (arg'low(1)+i, arg'low(2)+j),
                              resx(j)'high,
                              resx(j)'low);
        end loop;
        resy (i) := prod (resx);
      end loop;
      return resy;
    else
      report fixed_matrix_pkg'instance_name & "prod " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function prod;

  -- purpose: Dot product of two vectors
  function dot (
    l, r : ufixed_vector)
    return ufixed is
    variable result : ufixed (l(l'low)'range);
    constant zero   : ufixed (result'range) := (others => '0');
  begin
    result := zero;
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Dot " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in 0 to l'length-1 loop
        result := resize (result + (l (l'low+i) * r (r'low+i)),
                          result'high,
                          result'low);
      end loop;
    end if;
    return result;
  end function dot;

  -- Multiply every element in a vector
  function prod (
    arg : sfixed_vector)
    return sfixed is
    variable result : sfixed (arg(arg'low)'range);
  begin
    if isempty (arg) then
      result    := (others => '0');
      result(0) := '1';                 -- 1.0
    else
      result := resize (arg (arg'low),
                        result'high,
                        result'low);
      for i in arg'low+1 to arg'high loop
        result := resize (result * arg(i),
                          result'high,
                          result'low);
      end loop;
    end if;
    return result;
  end function prod;

  -- Multiply elements in a matrix and returns a vector
  function prod (
    arg          : sfixed_matrix;
    constant dim : POSITIVE := 1)                          -- 1 = y, 2 = x
    return sfixed_vector is
    variable resx : sfixed_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : sfixed_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := resize (arg (arg'low(1)+j, arg'low(2)+i),
                              resy(j)'high,
                              resy(j)'low);
        end loop;
        resx (i) := prod (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := resize (arg (arg'low(1)+i, arg'low(2)+j),
                              resx(j)'high,
                              resx(j)'low);
        end loop;
        resy (i) := prod (resx);
      end loop;
      return resy;
    else
      report fixed_matrix_pkg'instance_name & "prod " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function prod;

  -- purpose: Dot product of two vectors
  function dot (
    l, r : sfixed_vector)
    return sfixed is
    variable result : sfixed (l(l'low)'range);
    constant zero   : sfixed (result'range) := (others => '0');
  begin
    result := zero;
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Dot " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in 0 to l'length-1 loop
        result := resize (result + (l (l'low+i) * r (r'low+i)),
                          result'high,
                          result'low);
      end loop;
    end if;
    return result;
  end function dot;

  -- Multiply every element in a vector
  function prod (
    arg : unsigned_vector)
    return UNSIGNED is
    variable result : UNSIGNED (arg(arg'low)'range);
  begin
    if isempty (arg) then
      result    := (others => '0');
      result(0) := '1';                 -- 1
    else
      result := resize (arg (arg'low),
                        result'length);
      for i in arg'low+1 to arg'high loop
        result := resize (result * arg(i),
                          result'length);
      end loop;
    end if;
    return result;
  end function prod;

  -- Multiply elements in a matrix and returns a vector
  function prod (
    arg          : unsigned_matrix;
    constant dim : POSITIVE := 1)                            -- 1 = y, 2 = x
    return unsigned_vector is
    variable resx : unsigned_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : unsigned_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := resize (arg (arg'low(1)+j, arg'low(2)+i),
                              resy(j)'length);
        end loop;
        resx (i) := prod (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := resize (arg (arg'low(1)+i, arg'low(2)+j),
                              resx(j)'length);
        end loop;
        resy (i) := prod (resx);
      end loop;
      return resy;
    else
      report fixed_matrix_pkg'instance_name & "prod " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function prod;

  -- purpose: Dot product of two vectors
  function dot (
    l, r : unsigned_vector)
    return UNSIGNED is
    variable result : UNSIGNED (l(l'low)'range);
    constant zero   : UNSIGNED (result'range) := (others => '0');
  begin
    result := zero;
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Dot " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in 0 to l'length-1 loop
        result := resize (result + (l (l'low+i) * r (r'low+i)),
                          result'length);
      end loop;
    end if;
    return result;
  end function dot;

  -- Multiply every element in a vector
  function prod (
    arg : signed_vector)
    return SIGNED is
    variable result : SIGNED (arg(arg'low)'range);
  begin
    if isempty (arg) then
      result    := (others => '0');
      result(0) := '1';                 -- 1
    else
      result := resize (arg (arg'low),
                        result'length);
      for i in arg'low+1 to arg'high loop
        result := resize (result * arg(i),
                          result'length);
      end loop;
    end if;
    return result;
  end function prod;

  -- Multiply elements in a matrix and returns a vector
  function prod (
    arg          : signed_matrix;
    constant dim : POSITIVE := 1)                          -- 1 = y, 2 = x
    return signed_vector is
    variable resx : signed_vector (0 to arg'length(2)-1);  -- x vector
    variable resy : signed_vector (0 to arg'length(1)-1);  -- y vector
  begin
    if dim = 1 then
      for i in resx'range loop
        -- Pull out a column
        for j in resy'range loop
          resy (j) := resize (arg (arg'low(1)+j, arg'low(2)+i),
                              resy(j)'length);
        end loop;
        resx (i) := prod (resy);
      end loop;
      return resx;
    elsif dim = 2 then
      for i in resy'range loop
        -- Pull out a row
        for j in resx'range loop
          resx (j) := resize (arg (arg'low(1)+i, arg'low(2)+j),
                              resx(j)'length);
        end loop;
        resy (i) := prod (resx);
      end loop;
      return resy;
    else
      report fixed_matrix_pkg'instance_name & "prod " &
        "dim input must be 1 or 2, was " & INTEGER'image(dim)
        severity error;
      return resx;
    end if;
  end function prod;

  -- purpose: Dot product of two vectors
  function dot (
    l, r : signed_vector)
    return SIGNED is
    variable result : SIGNED (l(l'low)'range);
    constant zero   : SIGNED (result'range) := (others => '0');
  begin
    result := zero;
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Dot " &
        "Vectors lengths do not match l(" & INTEGER'image(l'length)
        & ") /= r("& INTEGER'image(r'length) & ")"
        severity error;
    else
      for i in 0 to l'length-1 loop
        result := resize (result + (l (l'low+i) * r (r'low+i)),
                          result'length);
      end loop;
    end if;
    return result;
  end function dot;

  -- Kronecker product.
  function kron (
    l, r : ufixed_matrix)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to (l'length(1)*r'length(1))-1,
                                     0 to (l'length(2)*r'length(2))-1);
  begin
    for i in 0 to l'length(1)-1 loop
      for j in 0 to l'length(2)-1 loop
        for m in 0 to r'length(1)-1 loop
          for n in 0 to r'length(2)-1 loop
            result ((i*r'length(1))+m, (j*r'length(2))+n) :=
              resize (l(i, j) * r(m, n),
                      result ((i*r'length(1))+m, (j*r'length(2))+n)'high,
                      result ((i*r'length(1))+m, (j*r'length(2))+n)'low);
          end loop;  -- n
        end loop;  -- m
      end loop;  -- j
    end loop;  -- i
    return result;
  end function kron;

  -- purpose: cross product of two vectors
  function cross (
    l, r : sfixed_vector)
    return sfixed_vector is
    variable result : sfixed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "Vectors do not match l(" & INTEGER'image(l'length) & ") /= r("&
        INTEGER'image(r'length) & ")"
        severity error;
    elsif l'length /= 3 then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "function only works on a vector length of 3, length given was "
        & INTEGER'image(l'length)
        severity error;
    else
      result(0) := resize (l(l'low+1)*r(r'low+2) - l(l'low+2)*r(r'low+1),
                           result(0)'high,
                           result(0)'low);
      result(1) := resize (l(l'low+2)*r(r'low+0) - l(l'low+0)*r(r'low+2),
                           result(1)'high,
                           result(1)'low);
      result(2) := resize (l(l'low+0)*r(r'low+1) - l(l'low+1)*r(r'low+0),
                           result(2)'high,
                           result(2)'low);
    end if;
    return result;
  end function cross;

  -- purpose: cross product of two matrices
  function cross (
    l, r : sfixed_matrix)
    return sfixed_matrix is
    variable a, b, c : sfixed_vector (0 to l'length(1)-1);      -- variables
    variable result  : sfixed_matrix (0 to l'length(1)-1, 0 to l'length(2)-1);
  begin
    if l'length(1) /= r'length(1) and l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    elsif l'length(2) /= 3 then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "function only works on a matrix length of 3, length given was ("
        & INTEGER'image(l'length(1)) & "," & INTEGER'image(l'length(2)) & ")"
        severity error;
    else
      for i in result'range(2) loop
        a := SubMatrix (l, l'low(1), i+l'low(2), a'length, 1);  -- column i
        b := SubMatrix (r, r'low(1), i+l'low(2), b'length, 1);
        c := cross (a, b);
        InsertColumn (c, result, 0, i);  -- Put result in column i
      end loop;
    end if;
    return result;
  end function cross;

  -- Kronecker product.
  function kron (
    l, r : sfixed_matrix)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to (l'length(1)*r'length(1))-1,
                                     0 to (l'length(2)*r'length(2))-1);
  begin
    for i in 0 to l'length(1)-1 loop
      for j in 0 to l'length(2)-1 loop
        for m in 0 to r'length(1)-1 loop
          for n in 0 to r'length(2)-1 loop
            result ((i*r'length(1))+m, (j*r'length(2))+n) :=
              resize (l(i, j) * r(m, n),
                      result ((i*r'length(1))+m, (j*r'length(2))+n)'high,
                      result ((i*r'length(1))+m, (j*r'length(2))+n)'low);
          end loop;  -- n
        end loop;  -- m
      end loop;  -- j
    end loop;  -- i
    return result;
  end function kron;

  -- purpose: Finds the determinant of a matrix
  -- Note that this one is recursive!
  -- http://people.richland.edu/james/lecture/m116/matrices/determinant.html
  function det (
    arg : sfixed_matrix)
    return SFIXED is
    variable i, j : INTEGER;            -- temp variables
    variable plus : BOOLEAN;            -- Used on the last sum
    variable reduced : sfixed_matrix (0 to arg'length(1)-2,
                                      0 to arg'length(2)-2);  -- reduced matrix
    variable result : sfixed (arg(arg'low(1), arg'low(2))'range);
    variable prod   : sfixed ((2*result'high) + 1 downto 2*result'low);
    constant zero   : sfixed (result'range) := (others => '0');
  begin  -- determinant
    if isempty(arg) then
      result := zero;
    elsif arg'length(1) /= arg'length(2) then
      report fixed_matrix_pkg'instance_name & "determinant " &
        " Matrix is not square " & INTEGER'image(arg'length(1)) &
        " /= " & INTEGER'image(arg'length(2)) severity error;
      result := zero;
    elsif arg'length(1) = 1 then        -- 1x1 matrix.
      result := resize (arg(arg'low(1), arg'low(2)),
                        result'high,
                        result'low);
    elsif arg'length(1) = 2 then        -- 2x2 matrix
      -- return ad - bc
      result := resize ((arg(arg'low(1), arg'low(2)) *
                         arg(arg'high(1), arg'high(2))) -
                        (arg(arg'low(1), arg'high(2)) *
                         arg(arg'high(1), arg'low(2))),
                        result'high,
                        result'low);
    else                                -- Go across the top row
      plus   := true;
      result := zero;
      for j in arg'low(2) to arg'high(2) loop
        reduced := exclude (arg, arg'low(1), j);
        prod    := arg (arg'low(1), j) * det (reduced);
        if plus then
          result := resize (result + prod,
                            result'high,
                            result'low);
        else
          result := resize (result - prod,
                            result'high,
                            result'low);
        end if;
        plus := not plus;
      end loop;  -- j
    end if;
    return result;
  end function det;

  -- purpose: cross product of two vectors
  function cross (
    l, r : unsigned_vector)
    return unsigned_vector is
    variable result : unsigned_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "Vectors do not match l(" & INTEGER'image(l'length) & ") /= r("&
        INTEGER'image(r'length) & ")"
        severity error;
    elsif l'length /= 3 then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "function only works on a vector length of 3, length given was "
        & INTEGER'image(l'length)
        severity error;
    else
      result(0) := resize (l(l'low+1)*r(r'low+2) - l(l'low+2)*r(r'low+1),
                           result(0)'length);
      result(1) := resize (l(l'low+2)*r(r'low+0) - l(l'low+0)*r(r'low+2),
                           result(1)'length);
      result(2) := resize (l(l'low+0)*r(r'low+1) - l(l'low+1)*r(r'low+0),
                           result(2)'length);
    end if;
    return result;
  end function cross;

  -- purpose: cross product of two matrices
  function cross (
    l, r : unsigned_matrix)
    return unsigned_matrix is
    variable a, b, c : unsigned_vector (0 to l'length(1)-1);    -- variables
    variable result : unsigned_matrix (0 to l'length(1)-1,
                                       0 to l'length(2)-1);
  begin
    if l'length(1) /= r'length(1) and l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    elsif l'length(2) /= 3 then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "function only works on a matrix length of 3, length given was ("
        & INTEGER'image(l'length(1)) & "," & INTEGER'image(l'length(2)) & ")"
        severity error;
    else
      for i in result'range(2) loop
        a := SubMatrix (l, l'low(1), i+l'low(2), a'length, 1);  -- column i
        b := SubMatrix (r, r'low(1), i+l'low(2), b'length, 1);
        c := cross (a, b);
        InsertColumn (c, result, 0, i);  -- Put result in column i
      end loop;
    end if;
    return result;
  end function cross;

  -- Kronecker product.
  function kron (
    l, r : unsigned_matrix)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to (l'length(1)*r'length(1))-1,
                                       0 to (l'length(2)*r'length(2))-1);
  begin
    for i in 0 to l'length(1)-1 loop
      for j in 0 to l'length(2)-1 loop
        for m in 0 to r'length(1)-1 loop
          for n in 0 to r'length(2)-1 loop
            result ((i*r'length(1))+m, (j*r'length(2))+n) :=
              resize (l(i, j) * r(m, n),
                      result ((i*r'length(1))+m, (j*r'length(2))+n)'length);
          end loop;  -- n
        end loop;  -- m
      end loop;  -- j
    end loop;  -- i
    return result;
  end function kron;

  -- purpose: Finds the determinant of a matrix
  -- Note that this one is recursive!
  -- http://people.richland.edu/james/lecture/m116/matrices/determinant.html
  function det (
    arg : unsigned_matrix)
    return UNSIGNED is
    variable i, j : INTEGER;            -- temp variables
    variable plus : BOOLEAN;            -- Used on the last sum
    variable reduced : unsigned_matrix (0 to arg'length(1)-2,
                                        0 to arg'length(2)-2);  -- reduced matrix
    variable result : UNSIGNED (arg(arg'low(1), arg'low(2))'range);
    variable prod   : UNSIGNED ((2*result'high) + 1 downto 0);
    constant zero   : UNSIGNED (result'range) := (others => '0');
  begin  -- determinant
    if isempty(arg) then
      result := zero;
    elsif arg'length(1) /= arg'length(2) then
      report fixed_matrix_pkg'instance_name & "determinant " &
        " Matrix is not square " & INTEGER'image(arg'length(1)) &
        " /= " & INTEGER'image(arg'length(2)) severity error;
      result := zero;
    elsif arg'length(1) = 1 then        -- 1x1 matrix.
      result := resize (arg(arg'low(1), arg'low(2)),
                        result'length);
    elsif arg'length(1) = 2 then        -- 2x2 matrix
      -- return ad - bc
      result := resize ((arg(arg'low(1), arg'low(2)) *
                         arg(arg'high(1), arg'high(2))) -
                        (arg(arg'low(1), arg'high(2)) *
                         arg(arg'high(1), arg'low(2))),
                        result'length);
    else                                -- Go across the top row
      plus   := true;
      result := zero;
      for j in arg'low(2) to arg'high(2) loop
        reduced := exclude (arg, arg'low(1), j);
        prod    := arg (arg'low(1), j) * det (reduced);
        if plus then
          result := resize (result + prod,
                            result'length);
        else
          result := resize (result - prod,
                            result'length);
        end if;
        plus := not plus;
      end loop;  -- j
    end if;
    return result;
  end function det;

  -- purpose: cross product of two vectors
  function cross (
    l, r : signed_vector)
    return signed_vector is
    variable result : signed_vector (0 to l'length-1);
  begin
    if l'length /= r'length then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "Vectors do not match l(" & INTEGER'image(l'length) & ") /= r("&
        INTEGER'image(r'length) & ")"
        severity error;
    elsif l'length /= 3 then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "function only works on a vector length of 3, length given was "
        & INTEGER'image(l'length)
        severity error;
    else
      result(0) := resize (l(l'low+1)*r(r'low+2) - l(l'low+2)*r(r'low+1),
                           result(0)'length);
      result(1) := resize (l(l'low+2)*r(r'low+0) - l(l'low+0)*r(r'low+2),
                           result(1)'length);
      result(2) := resize (l(l'low+0)*r(r'low+1) - l(l'low+1)*r(r'low+0),
                           result(2)'length);
    end if;
    return result;
  end function cross;

  -- purpose: cross product of two matrices
  function cross (
    l, r : signed_matrix)
    return signed_matrix is
    variable a, b, c : signed_vector (0 to l'length(1)-1);      -- variables
    variable result  : signed_matrix (0 to l'length(1)-1, 0 to l'length(2)-1);
  begin
    if l'length(1) /= r'length(1) and l'length(2) /= r'length(2) then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "Matrices do not match l(" & INTEGER'image(l'length(1)) & "," &
        INTEGER'image(l'length(2)) & ") /= r("&
        INTEGER'image(r'length(1)) & "," & INTEGER'image(r'length(2)) & ")"
        severity error;
    elsif l'length(2) /= 3 then
      report fixed_matrix_pkg'instance_name & "Cross " &
        "function only works on a matrix length of 3, length given was ("
        & INTEGER'image(l'length(1)) & "," & INTEGER'image(l'length(2)) & ")"
        severity error;
    else
      for i in result'range(2) loop
        a := SubMatrix (l, l'low(1), i+l'low(2), a'length, 1);  -- column i
        b := SubMatrix (r, r'low(1), i+l'low(2), b'length, 1);
        c := cross (a, b);
        InsertColumn (c, result, 0, i);  -- Put result in column i
      end loop;
    end if;
    return result;
  end function cross;

  -- Kronecker product.
  function kron (
    l, r : signed_matrix)
    return signed_matrix is
    variable result : signed_matrix (0 to (l'length(1)*r'length(1))-1,
                                     0 to (l'length(2)*r'length(2))-1);
  begin
    for i in 0 to l'length(1)-1 loop
      for j in 0 to l'length(2)-1 loop
        for m in 0 to r'length(1)-1 loop
          for n in 0 to r'length(2)-1 loop
            result ((i*r'length(1))+m, (j*r'length(2))+n) :=
              resize (l(i, j) * r(m, n),
                      result ((i*r'length(1))+m, (j*r'length(2))+n)'length);
          end loop;  -- n
        end loop;  -- m
      end loop;  -- j
    end loop;  -- i
    return result;
  end function kron;

  -- purpose: Finds the determinant of a matrix
  -- Note that this one is recursive!
  -- http://people.richland.edu/james/lecture/m116/matrices/determinant.html
  function det (
    arg : signed_matrix)
    return SIGNED is
    variable i, j : INTEGER;            -- temp variables
    variable plus : BOOLEAN;            -- Used on the last sum
    variable reduced : signed_matrix (0 to arg'length(1)-2,
                                      0 to arg'length(2)-2);  -- reduced matrix
    variable result : SIGNED (arg(arg'low(1), arg'low(2))'range);
    variable prod   : SIGNED ((2*result'high) + 1 downto 0);
    constant zero   : SIGNED (result'range) := (others => '0');
  begin  -- determinant
    if isempty(arg) then
      result := zero;
    elsif arg'length(1) /= arg'length(2) then
      report fixed_matrix_pkg'instance_name & "determinant " &
        " Matrix is not square " & INTEGER'image(arg'length(1)) &
        " /= " & INTEGER'image(arg'length(2)) severity error;
      result := zero;
    elsif arg'length(1) = 1 then        -- 1x1 matrix.
      result := resize (arg(arg'low(1), arg'low(2)),
                        result'length);
    elsif arg'length(1) = 2 then        -- 2x2 matrix
      -- return ad - bc
      result := resize ((arg(arg'low(1), arg'low(2)) *
                         arg(arg'high(1), arg'high(2))) -
                        (arg(arg'low(1), arg'high(2)) *
                         arg(arg'high(1), arg'low(2))),
                        result'length);
    else                                -- Go across the top row
      plus   := true;
      result := zero;
      for j in arg'low(2) to arg'high(2) loop
        reduced := exclude (arg, arg'low(1), j);
        prod    := arg (arg'low(1), j) * det (reduced);
        if plus then
          result := resize (result + prod,
                            result'length);
        else
          result := resize (result - prod,
                            result'length);
        end if;
        plus := not plus;
      end loop;  -- j
    end if;
    return result;
  end function det;

  -- purpose: Inverts a matrix
  -- http://people.richland.edu/james/lecture/m116/matrices/determinant.html
  function inv (
    arg : sfixed_matrix)
    return sfixed_matrix is
    variable i, j : INTEGER;            -- temp variables
    variable plus : BOOLEAN;            -- Used on the last sum
    variable reduced : sfixed_matrix (0 to arg'length(1)-2,
                                      0 to arg'length(2)-2);  -- reduced matrix
    variable cofact : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);   -- minor matrix
    variable result : sfixed_matrix (0 to arg'length(2)-1,
                                     0 to arg'length(1)-1);
    variable deter : sfixed (arg(arg'low(1), arg'low(2))'range);
    variable prod  : sfixed (1-deter'low downto (-deter'high));  -- 1/x
    constant zero  : sfixed (deter'range) := (others => '0');    -- 0.0
  begin  -- invert
    if isempty(arg) then
      null;
    elsif arg'length(1) /= arg'length(2) then
      report fixed_matrix_pkg'instance_name & "invert " &
        " Matrix is not square " & INTEGER'image(arg'length(1)) &
        " /= " & INTEGER'image(arg'length(2)) severity error;
      result := zeros (result'length(1), result'length(2));
    elsif arg'length(1) = 1 then        -- 1x1 case
      if arg (arg'low(1), arg'low(2)) = zero then
        report fixed_matrix_pkg'instance_name & "invert " &
          " Matrix is not invertible, Determinant = 0"
          severity error;
        result (0, 0) := zero;
      else
        result (0, 0) := resize (reciprocal(arg(arg'low(1), arg'low(2))),
                                 result (0, 0)'high,
                                 result (0, 0)'low);
      end if;
    elsif arg'length(1) = 2 then        -- 2x2 case
      deter := det (arg);
      if deter = zero then
        report fixed_matrix_pkg'instance_name & "invert " &
          " Matrix is not invertible, Determinant = 0"
          severity error;
        result := zeros (2, 2);
      else
        prod := reciprocal (deter);
        result (0, 0) := resize (arg (arg'high(1), arg'high(2)) * prod,
                                 result (0, 0)'high,
                                 result (0, 0)'low);
        result (0, 1) := resize (-arg (arg'low(1), arg'high(2)) * prod,
                                 result (0, 1)'high,
                                 result (0, 1)'low);
        result (1, 0) := resize (-arg (arg'high(1), arg'low(2)) * prod,
                                 result (1, 0)'high,
                                 result (1, 0)'low);
        result (1, 1) := resize (arg (arg'low(1), arg'low(2)) * prod,
                                 result (1, 1)'high,
                                 result (1, 1)'low);
      end if;
    else
      -- reduce the matrix to a matrix of cofactors
      plus := true;
      for i in arg'low(1) to arg'high(1) loop
        for j in arg'low(2) to arg'high(2) loop
          reduced := exclude (arg, i, j);
          deter   := det (reduced);
          if plus then
            cofact (i-arg'low(1), j-arg'low(2)) := deter;
          else
            cofact (i-arg'low(1), j-arg'low(2)) :=
              resize (-deter,
                      cofact (i-arg'low(1), j-arg'low(2))'high,
                      cofact (i-arg'low(1), j-arg'low(2))'low);
          end if;
          plus := not plus;
        end loop;  -- j
      end loop;  -- i
      -- Find the determinant of the entire matrix.
      -- Since I already have a matrix of cofactors, I can just add it up.
      deter := zero;
      for j in arg'low(2) to arg'high(2) loop
        deter := resize (deter + (arg (arg'low(1), j) *
                                  cofact(0, j-arg'low(2))),
                         deter'high,
                         deter'low);
      end loop;  -- j
      if deter = zero then
        report fixed_matrix_pkg'instance_name & "invert " &
          " Matrix is not invertible, Determinant = 0"
          severity error;
        result := zeros (result'length(1), result'length(2));
      else
        -- multiply the transposed cofactors by 1/determinant
        result := reciprocal(deter) * transpose (cofact);
      end if;
    end if;
    return result;
  end function inv;

  -- Solve a linear equation
  -- This is done via the "lower triangle" method.
  function linsolve (
    l : sfixed_matrix;
    r : sfixed_vector)
    return sfixed_vector is
    -- Augmented matrix
    variable augmat : sfixed_matrix (0 to l'length(1)-1, 0 to l'length(2));
    variable result : sfixed_vector (0 to r'length-1);
    variable var    : sfixed (l(l'low(1), l'low(2))'range);
    variable varr   : sfixed (1-var'right downto -var'left);  -- 1/var
  begin
    if l'length(1) /= r'length then
      report fixed_matrix_pkg'instance_name & "linsolve " &
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
            if augmat (i, j) = 0 then
              report fixed_matrix_pkg'instance_name & "linsolve " &
                "Linear system has no solution" severity error;
              print_matrix (augmat);
              return r;
            end if;
            varr := reciprocal (augmat (i, j));
            for k in j to l'length(2) loop
              augmat (i, k) := resize (augmat (i, k) * varr,
                                       augmat (i, k)'high,
                                       augmat (i, k)'low);
            end loop;
          elsif i > j then
            -- subtract last diagonal row *-(i,j)
            var := augmat(i, j);
            for k in j to l'length(2) loop
              augmat (i, k) := resize (augmat (i, k) - (var * augmat (j, k)),
                                       augmat (i, k)'high,
                                       augmat (i, k)'low);
            end loop;
          end if;
        end loop;
      end loop;
      -- reverse the diagonal to solve
      result := SubMatrix (augmat, 0, augmat'high(2), result'length, 1);
      for m in result'high-1 downto 0 loop
        for n in m+1 to l'length(1) -1 loop
          result(m) := resize (result(m) - (augmat(m, n) * result(n)),
                               result(m)'high,
                               result(m)'low);
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
    arg           : sfixed_matrix;
    constant rval : sfixed := sfixed_one)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable max : sfixed (arg(arg'low(1), arg'low(2))'high+1 downto
                           arg(arg'low(1), arg'low(2))'low);
  begin
    if not isempty (arg) then
      max := abs(arg (arg'low(1), arg'low(2)));
      for i in arg'range(1) loop
        for j in arg'range(2) loop
          max := resize (maximum (max, abs (arg(i, j))),
                         max'high,
                         max'low);
        end loop;
      end loop;
      result := arg * (rval/max);
    end if;
    return result;
  end function normalize;

  -- Normalize a Vector
  function normalize (
    arg           : sfixed_vector;
    constant rval : sfixed := sfixed_one)
    return sfixed_vector is
    variable result : sfixed_vector (0 to arg'length-1);
    variable max : sfixed (arg(arg'low)'high+1 downto
                           arg(arg'low)'low);
  begin
    if not isempty (arg) then
      max := abs(arg (arg'low));
      for i in arg'range loop
        max := resize (maximum (max, abs (arg(i))),
                       max'high,
                       max'low);
      end loop;
      result := arg * (rval/max);
    end if;
    return result;
  end function normalize;

  -- Normalize a Matrix
  function normalize (
    arg           : ufixed_matrix;
    constant rval : ufixed := ufixed_one)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
    variable max : ufixed (arg(arg'low(1), arg'low(2))'range);
  begin
    if not isempty (arg) then
      max := arg (arg'low(1), arg'low(2));
      for i in arg'range(1) loop
        for j in arg'range(2) loop
          max := maximum (max, arg(i, j));
        end loop;
      end loop;
      result := arg * (rval/max);
    end if;
    return result;
  end function normalize;

  -- Normalize a Vector
  function normalize (
    arg           : ufixed_vector;
    constant rval : ufixed := ufixed_one)
    return ufixed_vector is
    variable result : ufixed_vector (0 to arg'length-1);
    variable max    : ufixed (arg(arg'low)'range);
  begin
    if not isempty (arg) then
      max := arg (arg'low);
      for i in arg'range loop
        max := maximum (max, arg(i));
      end loop;
      result := arg * (rval/max);
    end if;
    return result;
  end function normalize;

  -- Evaluate the polynomial
  function polyval (
    l, r : sfixed_vector)
    return sfixed_vector is
    variable result : sfixed_vector (r'range);
  begin
    if not (isempty (l) or isempty(r)) then
      for i in r'range loop
        result(i) := (others => '0');
        for j in l'range loop
          result(i) := resize (result(i) + (l(j) * (r(i)**j)),
                               result(i)'high,
                               result(i)'low);
        end loop;
      end loop;
    end if;
    return result;
  end function polyval;

  -----------------------------------------------------------------------------
  -- These functions allow you to do matrix and vector slicing
  -----------------------------------------------------------------------------
  -- returns an rows/columns matrix from position x,y in the input matrix
  function SubMatrix (
    arg                    : ufixed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to rows-1, 0 to columns-1);
  begin
    if arg'length(1)-x < rows or arg'length(2)-y < columns then
      report fixed_matrix_pkg'instance_name & "SubMatrix " &
        "Matrix size does not match, can not extract a (" &
        INTEGER'image(rows) & "," & INTEGER'image(columns) &
        ") matrix from a (" & INTEGER'image (arg'length(1)-x) & "," &
        INTEGER'image (arg'length(2)-y) & ") matrix"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (arg (x + i, y + j),
                                   result (i, j)'high,
                                   result (i, j)'low);
        end loop;
      end loop;
    end if;
    return result;
  end function SubMatrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : ufixed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return ufixed_vector is
    variable result1 : ufixed_vector (0 to rows-1);
    variable result2 : ufixed_vector (0 to columns-1);
  begin
    if rows > 1 then
      if arg'length(1)-x < rows then
        report fixed_matrix_pkg'instance_name & "SubMatrix " &
          "Vector length does not match " & INTEGER'image (arg'length(1)-x) &
          " /= " & INTEGER'image(rows)
          severity error;
      else
        for i in result1'range loop
          result1 (i) := resize (arg (x+i, y),
                                 result1 (i)'high,
                                 result1 (i)'low);
        end loop;
      end if;
      return result1;
    else
      if arg'length(2)-y < columns then
        report fixed_matrix_pkg'instance_name & "SubMatrix " &
          "Vector length does not match " & INTEGER'image (arg'length(2)-y) &
          " /= " & INTEGER'image(columns)
          severity error;
      else
        for i in result2'range loop
          result2 (i) := resize (arg (x, y+i),
                                 result2 (i)'high,
                                 result2 (i)'low);
        end loop;
      end if;
      return result2;
    end if;
  end function SubMatrix;

  -- Places the matrix "arg" at location X,Y in matrix "result"
  procedure BuildMatrix (
    arg           : in    ufixed_matrix;
    result        : inout ufixed_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report fixed_matrix_pkg'instance_name & "BuildMatrix " &
--        "arg input was an empty matrix"
--        severity error;
      return;
    elsif isempty(result) then
--      report fixed_matrix_pkg'instance_name & "BuildMatrix " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif (arg'length(1) > result'length(1)-(x-result'low(1))) or
      (arg'length(2) > result'length(2)-(y-result'low(2))) then
      report fixed_matrix_pkg'instance_name & "BuildMatrix " &
        "Dimensions of arg (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ") > result range (" &
        INTEGER'image(result'high(1)-(x-result'low(1))) & "," &
        INTEGER'image(result'high(2)-(y-result'low(2))) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length(1)-1 loop
        for j in 0 to arg'length(2)-1 loop
          result (x+i, y+j) := resize (arg (i+arg'low(1), j+arg'low(2)),
                                       result (x+i, y+j)'high,
                                       result (x+i, y+j)'low);
        end loop;
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    ufixed_vector;
    result        : inout ufixed_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "arg input was an empty vector"
--        severity error;
      return;
    elsif isempty(result) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif arg'length > result'length(2)-(y-result'low(2)) then
      report fixed_matrix_pkg'instance_name & "BuildMatrix " &
        "Dimension of arg(" & INTEGER'image(arg'length) &
        ") larger than result (" & INTEGER'image(x) & "," &
        INTEGER'image(result'length(2)-(y-result'low(2))) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x, y+i) := resize (arg (i+arg'low),
                                   result (x, y+i)'high,
                                   result (x, y+i)'low);
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    ufixed_vector;
    result        : inout ufixed_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report real_matrix_pkg'instance_name & "InsertColumn " &
--        "arg input was an empty vector"
--        severity error;
      return;
    elsif isempty(result) then
--      report real_matrix_pkg'instance_name & "InsertColumn " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif arg'length > result'length(1)-(x-result'low(1)) then
      report fixed_matrix_pkg'instance_name & "InsertColumn " &
        "Dimension of arg(" & INTEGER'image(arg'length) &
        ") larger than result (" &
        INTEGER'image(result'length(1)-(x-result'low(1))) & "," &
        INTEGER'image(y) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x+i, y) := resize (arg (i+arg'low),
                                   result (x+i, y)'high,
                                   result (x+i, y)'low);
      end loop;
    end if;
  end procedure InsertColumn;

  -- purpose: SubMatrix returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : ufixed_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return ufixed_matrix is             -- loop variables
    variable i, j, k, l : INTEGER;      -- loop variables
    variable result : ufixed_matrix (0 to arg'length(1)-2,
                                     0 to arg'length(2)-2);  -- SubMatrix
  begin  -- exclude
    if arg'length(1) < 3 then
      report fixed_matrix_pkg'instance_name & "exclude " &
        "arg is smaller than 3x3" severity error;
    else
      k := 0;
      l := 0;
      for i in arg'low(1) to arg'high(1) loop
        for j in arg'low(2) to arg'high(2) loop
          if not (i = row or j = column) then  -- exclude this row/column
            result (k, l) := resize (arg (i, j),
                                     result (k, l)'high,
                                     result (k, l)'low);
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

  -- returns an rows/columns matrix from position x,y in the input matrix
  function SubMatrix (
    arg                    : sfixed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to rows-1, 0 to columns-1);
  begin
    if arg'length(1)-x < rows or arg'length(2)-y < columns then
      report fixed_matrix_pkg'instance_name & "SubMatrix " &
        "Matrix size does not match, can not extract a (" &
        INTEGER'image(rows) & "," & INTEGER'image(columns) &
        ") matrix from a (" & INTEGER'image (arg'length(1)-x) & "," &
        INTEGER'image (arg'length(2)-y) & ") matrix"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (arg (x + i, y + j),
                                   result (i, j)'high,
                                   result (i, j)'low);
        end loop;
      end loop;
    end if;
    return result;
  end function SubMatrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : sfixed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return sfixed_vector is
    variable result1 : sfixed_vector (0 to rows-1);
    variable result2 : sfixed_vector (0 to columns-1);
  begin
    if rows > 1 then
      if arg'length(1)-x < rows then
        report fixed_matrix_pkg'instance_name & "SubMatrix " &
          "Vector length does not match " & INTEGER'image (arg'length(1)-x) &
          " /= " & INTEGER'image(rows)
          severity error;
      else
        for i in result1'range loop
          result1 (i) := resize (arg (x+i, y),
                                 result1 (i)'high,
                                 result1 (i)'low);
        end loop;
      end if;
      return result1;
    else
      if arg'length(2)-y < columns then
        report fixed_matrix_pkg'instance_name & "SubMatrix " &
          "Vector length does not match " & INTEGER'image (arg'length(2)-y) &
          " /= " & INTEGER'image(columns)
          severity error;
      else
        for i in result2'range loop
          result2 (i) := resize (arg (x, y+i),
                                 result2 (i)'high,
                                 result2 (i)'low);
        end loop;
      end if;
      return result2;
    end if;
  end function SubMatrix;

  -- Places the matrix "arg" at location X,Y in matrix "result"
  procedure BuildMatrix (
    arg           : in    sfixed_matrix;
    result        : inout sfixed_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "arg input was an empty matrix"
--        severity error;
      return;
    elsif isempty(result) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif (arg'length(1) > result'length(1)-(x-result'low(1))) or
      (arg'length(2) > result'length(2)-(y-result'low(2))) then
      report fixed_matrix_pkg'instance_name & "BuildMatrix " &
        "Dimensions of arg (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ") > result range (" &
        INTEGER'image(result'high(1)-(x-result'low(1))) & "," &
        INTEGER'image(result'high(2)-(y-result'low(2))) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length(1)-1 loop
        for j in 0 to arg'length(2)-1 loop
          result (x+i, y+j) := resize (arg (i+arg'low(1), j+arg'low(2)),
                                       result (x+i, y+j)'high,
                                       result (x+i, y+j)'low);
        end loop;
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    sfixed_vector;
    result        : inout sfixed_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "arg input was an empty vector"
--        severity error;
      return;
    elsif isempty(result) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif arg'length > result'length(2)-(y-result'low(2)) then
      report fixed_matrix_pkg'instance_name & "BuildMatrix " &
        "Dimension of arg(" & INTEGER'image(arg'length) &
        ") larger than result (" & INTEGER'image(x) & "," &
        INTEGER'image(result'length(2)-(y-result'low(2))) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x, y+i) := resize (arg (i+arg'low),
                                   result (x, y+i)'high,
                                   result (x, y+i)'low);
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    sfixed_vector;
    result        : inout sfixed_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report real_matrix_pkg'instance_name & "InsertColumn " &
--        "arg input was an empty vector"
--        severity error;
      return;
    elsif isempty(result) then
--      report real_matrix_pkg'instance_name & "InsertColumn " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif arg'length > result'length(1)-(x-result'low(1)) then
      report fixed_matrix_pkg'instance_name & "InsertColumn " &
        "Dimension of arg(" & INTEGER'image(arg'length) &
        ") larger than result (" &
        INTEGER'image(result'length(1)-(x-result'low(1))) & "," &
        INTEGER'image(y) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x+i, y) := resize (arg (i+arg'low),
                                   result (x+i, y)'high,
                                   result (x+i, y)'low);
      end loop;
    end if;
  end procedure InsertColumn;

  -- purpose: exclude returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : sfixed_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return sfixed_matrix is             -- loop variables
    variable i, j, k, l : INTEGER;      -- loop variables
    variable result : sfixed_matrix (0 to arg'length(1)-2,
                                     0 to arg'length(2)-2);  -- exclude
  begin  -- exclude
    if arg'length(1) < 3 then
      report fixed_matrix_pkg'instance_name & "exclude " &
        "arg is smaller than 3x3" severity error;
    else
      k := 0;
      l := 0;
      for i in arg'low(1) to arg'high(1) loop
        for j in arg'low(2) to arg'high(2) loop
          if not (i = row or j = column) then  -- exclude this row/column
            result (k, l) := resize (arg (i, j),
                                     result (k, l)'high,
                                     result (k, l)'low);
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

  -- returns an rows/columns matrix from position x,y in the input matrix
  function SubMatrix (
    arg                    : unsigned_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to rows-1, 0 to columns-1);
  begin
    if arg'length(1)-x < rows or arg'length(2)-y < columns then
      report fixed_matrix_pkg'instance_name & "SubMatrix " &
        "Matrix size does not match, can not extract a (" &
        INTEGER'image(rows) & "," & INTEGER'image(columns) &
        ") matrix from a (" & INTEGER'image (arg'length(1)-x) & "," &
        INTEGER'image (arg'length(2)-y) & ") matrix"
        severity error;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (arg (x + i, y + j),
                                   result (i, j)'length);
        end loop;
      end loop;
    end if;
    return result;
  end function SubMatrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : unsigned_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return unsigned_vector is
    variable result1 : unsigned_vector (0 to rows-1);
    variable result2 : unsigned_vector (0 to columns-1);
  begin
    if rows > 1 then
      if arg'length(1)-x < rows then
        report fixed_matrix_pkg'instance_name & "SubMatrix " &
          "Vector length does not match " & INTEGER'image (arg'length(1)-x) &
          " /= " & INTEGER'image(rows)
          severity error;
      else
        for i in result1'range loop
          result1 (i) := resize (arg (x+i, y),
                                 result1 (i)'length);
        end loop;
      end if;
      return result1;
    else
      if arg'length(2)-y < columns then
        report fixed_matrix_pkg'instance_name & "SubMatrix " &
          "Vector length does not match " & INTEGER'image (arg'length(2)-y) &
          " /= " & INTEGER'image(columns)
          severity error;
      else
        for i in result2'range loop
          result2 (i) := resize (arg (x, y+i),
                                 result2 (i)'length);
        end loop;
      end if;
      return result2;
    end if;
  end function SubMatrix;

  -- Places the matrix "arg" at location X,Y in matrix "result"
  procedure BuildMatrix (
    arg           : in    unsigned_matrix;
    result        : inout unsigned_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "arg input was an empty matrix"
--        severity error;
      return;
    elsif isempty(result) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif (arg'length(1) > result'length(1)-(x-result'low(1))) or
      (arg'length(2) > result'length(2)-(y-result'low(2))) then
      report fixed_matrix_pkg'instance_name & "BuildMatrix " &
        "Dimensions of arg (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ") > result range (" &
        INTEGER'image(result'high(1)-(x-result'low(1))) & "," &
        INTEGER'image(result'high(2)-(y-result'low(2))) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length(1)-1 loop
        for j in 0 to arg'length(2)-1 loop
          result (x+i, y+j) := resize (arg (i+arg'low(1), j+arg'low(2)),
                                       result (x+i, y+j)'length);
        end loop;
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    unsigned_vector;
    result        : inout unsigned_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "arg input was an empty vector"
--        severity error;
      return;
    elsif isempty(result) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif arg'length > result'length(2)-(y-result'low(2)) then
      report fixed_matrix_pkg'instance_name & "BuildMatrix " &
        "Dimension of arg(" & INTEGER'image(arg'length) &
        ") larger than result (" & INTEGER'image(x) & "," &
        INTEGER'image(result'length(2)-(y-result'low(2))) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x, y+i) := resize (arg (i+arg'low),
                                   result (x, y+i)'length);
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    unsigned_vector;
    result        : inout unsigned_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report real_matrix_pkg'instance_name & "InsertColumn " &
--        "arg input was an empty vector"
--        severity error;
      return;
    elsif isempty(result) then
--      report real_matrix_pkg'instance_name & "InsertColumn " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif arg'length > result'length(1)-(x-result'low(1)) then
      report fixed_matrix_pkg'instance_name & "InsertColumn " &
        "Dimension of arg(" & INTEGER'image(arg'length) &
        ") larger than result (" &
        INTEGER'image(result'length(1)-(x-result'low(1))) & "," &
        INTEGER'image(y) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x+i, y) := resize (arg (i+arg'low),
                                   result (x+i, y)'length);
      end loop;
    end if;
  end procedure InsertColumn;

  -- purpose: exclude returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : unsigned_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return unsigned_matrix is           -- loop variables
    variable i, j, k, l : INTEGER;      -- loop variables
    variable result : unsigned_matrix (0 to arg'length(1)-2,
                                       0 to arg'length(2)-2);  -- exclude
  begin  -- exclude
    if arg'length(1) < 3 then
      report fixed_matrix_pkg'instance_name & "exclude " &
        "arg is smaller than 3x3" severity error;
    else
      k := 0;
      l := 0;
      for i in arg'low(1) to arg'high(1) loop
        for j in arg'low(2) to arg'high(2) loop
          if not (i = row or j = column) then  -- exclude this row/column
            result (k, l) := resize (arg (i, j),
                                     result (k, l)'length);
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

  -- returns an rows/columns matrix from position x,y in the input matrix
  function SubMatrix (
    arg                    : signed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return signed_matrix is
    variable result : signed_matrix (0 to rows-1, 0 to columns-1);
  begin
    if arg'length(1)-x < rows or arg'length(2)-y < columns then
      report fixed_matrix_pkg'instance_name & "SubMatrix " &
        "Matrix size does not match, can not extract a (" &
        INTEGER'image(rows) & "," & INTEGER'image(columns) &
        ") matrix from a (" & INTEGER'image (arg'length(1)-x) & "," &
        INTEGER'image (arg'length(2)-y) & ") matrix"
        severity error;
      return result;
    else
      for i in result'range(1) loop
        for j in result'range(2) loop
          result (i, j) := resize (arg (x + i, y + j),
                                   result (i, j)'length);
        end loop;
      end loop;
      return result;
    end if;
  end function SubMatrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : signed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return signed_vector is
    variable result1 : signed_vector (0 to rows-1);
    variable result2 : signed_vector (0 to columns-1);
  begin
    if rows > 1 then
      if arg'length(1)-x < rows then
        report fixed_matrix_pkg'instance_name & "SubMatrix " &
          "Vector length does not match " & INTEGER'image (arg'length(1)-x) &
          " /= " & INTEGER'image(rows)
          severity error;
      else
        for i in result1'range loop
          result1 (i) := resize (arg (x+i, y),
                                 result1 (i)'length);
        end loop;
      end if;
      return result1;
    else
      if arg'length(2)-y < columns then
        report fixed_matrix_pkg'instance_name & "SubMatrix " &
          "Vector length does not match " & INTEGER'image (arg'length(2)-y) &
          " /= " & INTEGER'image(columns)
          severity error;
      else
        for i in result2'range loop
          result2 (i) := resize (arg (x, y+i),
                                 result2 (i)'length);
        end loop;
      end if;
      return result2;
    end if;
  end function SubMatrix;

  -- Places the matrix "arg" at location X,Y in matrix "result"
  procedure BuildMatrix (
    arg           : in    signed_matrix;
    result        : inout signed_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "arg input was an empty matrix"
--        severity error;
      return;
    elsif isempty(result) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif (arg'length(1) > result'length(1)-(x-result'low(1))) or
      (arg'length(2) > result'length(2)-(y-result'low(2))) then
      report fixed_matrix_pkg'instance_name & "BuildMatrix " &
        "Dimensions of arg (" & INTEGER'image(arg'length(1)) & "," &
        INTEGER'image(arg'length(2)) & ") > result range (" &
        INTEGER'image(result'high(1)-(x-result'low(1))) & "," &
        INTEGER'image(result'high(2)-(y-result'low(2))) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length(1)-1 loop
        for j in 0 to arg'length(2)-1 loop
          result (x+i, y+j) := resize (arg (i+arg'low(1), j+arg'low(2)),
                                       result (x+i, y+j)'length);
        end loop;
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    signed_vector;
    result        : inout signed_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "arg input was an empty vector"
--        severity error;
      return;
    elsif isempty(result) then
--      report real_matrix_pkg'instance_name & "BuildMatrix " &
--        "result input was an empty matrix"
--        severity error;
      return;
    elsif arg'length > result'length(2)-(y-result'low(2)) then
      report fixed_matrix_pkg'instance_name & "BuildMatrix " &
        "Dimension of arg(" & INTEGER'image(arg'length) &
        ") larger than result (" & INTEGER'image(x) & "," &
        INTEGER'image(result'length(2)-(y-result'low(2))) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x, y+i) := resize (arg (i+arg'low),
                                   result (x, y+i)'length);
      end loop;
    end if;
  end procedure BuildMatrix;

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    signed_vector;
    result        : inout signed_matrix;
    constant x, y : in    NATURAL) is   -- index into the matrix
  begin
    if isempty (arg) or isempty(result) then
      return;
    elsif arg'length > result'length(1)-(x-result'low(1)) then
      report fixed_matrix_pkg'instance_name & "InsertColumn " &
        "Dimension of arg(" & INTEGER'image(arg'length) &
        ") larger than result (" &
        INTEGER'image(result'length(1)-(x-result'low(1))) & "," &
        INTEGER'image(y) & ")"
        severity error;
      return;
    else
      for i in 0 to arg'length-1 loop
        result (x+i, y) := resize (arg (i+arg'low),
                                   result (x+i, y)'length);
      end loop;
    end if;
  end procedure InsertColumn;

  -- purpose: exclude returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : signed_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return signed_matrix is             -- loop variables
    variable i, j, k, l : INTEGER;      -- loop variables
    variable result : signed_matrix (0 to arg'length(1)-2,
                                     0 to arg'length(2)-2);  -- exclude
  begin  -- exclude
    if arg'length(1) < 3 then
      report fixed_matrix_pkg'instance_name & "exclude " &
        "arg is smaller than 3x3" severity error;
    else
      k := 0;
      l := 0;
      for i in arg'low(1) to arg'high(1) loop
        for j in arg'low(2) to arg'high(2) loop
          if not (i = row or j = column) then  -- exclude this row/column
            result (k, l) := resize (arg (i, j),
                                     result (k, l)'length);
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

  -----------------------------------------------------------------------------
  -- Conversion functions
  -- VHDL-2008
  -- When unconstrained arrays of unconstrained arrays becomes available:
  -- Modify the "result" to be of the correctly size type
  -----------------------------------------------------------------------------
  function to_ufixed (
    arg                     : unsigned_matrix;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := 0;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_ufixed (
          arg            => arg (i+ arg'low(1), j+arg'low(2)),
          left_index     => result(i, j)'high,
          right_index    => result(i, j)'low,
          overflow_style => overflow_style,
          round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function to_ufixed;

  function to_ufixed (
    arg                     : real_matrix;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := ufixed_matrix_low;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if arg (i+ arg'low, j+arg'low(2)) < 0.0 then
          result (i, j) := (others => '0');
        else
          result (i, j) := to_ufixed (
            arg            => arg (i+ arg'low(1), j+arg'low(2)),
            left_index     => result(i, j)'high,
            right_index    => result(i, j)'low,
            overflow_style => overflow_style,
            round_style    => round_style);
        end if;
      end loop;
    end loop;
    return result;
  end function to_ufixed;

  function to_ufixed (
    arg                     : integer_matrix;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := 0;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix is
    variable result : ufixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if arg (i+ arg'low, j+arg'low(2)) < 0 then
          result (i, j) := (others => '0');
        else
          result (i, j) := to_ufixed (
            arg            => arg (i+ arg'low(1), j+arg'low(2)),
            left_index     => result(i, j)'high,
            right_index    => result(i, j)'low,
            overflow_style => overflow_style,
            round_style    => round_style);
        end if;
      end loop;
    end loop;
    return result;
  end function to_ufixed;

  function to_ufixed (
    arg                     : unsigned_vector;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := 0;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector is
    variable result : ufixed_vector (0 to arg'length-1);
  begin
    for i in result'range(1) loop
      result (i) := to_ufixed (
        arg            => arg (i+ arg'low),
        left_index     => result(i)'high,
        right_index    => result(i)'low,
        overflow_style => overflow_style,
        round_style    => round_style);
    end loop;
    return result;
  end function to_ufixed;

  function to_ufixed (
    arg                     : real_vector;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := ufixed_matrix_low;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector is
    variable result : ufixed_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      if arg (i+ arg'low) < 0.0 then
        result (i) := (others => '0');
      else
        result (i) := to_ufixed (
          arg            => arg (i+ arg'low),
          left_index     => result(i)'high,
          right_index    => result(i)'low,
          overflow_style => overflow_style,
          round_style    => round_style);
      end if;
    end loop;
    return result;
  end function to_ufixed;

  function to_ufixed (
    arg                     : integer_vector;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := 0;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector is
    variable result : ufixed_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      if arg (i+arg'low) < 0 then
        result (i) := (others => '0');
      else
        result (i) := to_ufixed (
          arg            => arg (i+ arg'low),
          left_index     => result(i)'high,
          right_index    => result(i)'low,
          overflow_style => overflow_style,
          round_style    => round_style);
      end if;
    end loop;
    return result;
  end function to_ufixed;

  -----------------------------------------------------------------------------
  -- Signed fixed point
  -----------------------------------------------------------------------------

  function to_sfixed (
    arg                     : signed_matrix;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := 0;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_sfixed (
          arg            => arg (i+ arg'low(1), j+arg'low(2)),
          left_index     => result(i, j)'high,
          right_index    => result(i, j)'low,
          overflow_style => overflow_style,
          round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function to_sfixed;

  function to_sfixed (
    arg                     : real_matrix;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_sfixed (
          arg            => arg (i+ arg'low(1), j+arg'low(2)),
          left_index     => result(i, j)'high,
          right_index    => result(i, j)'low,
          overflow_style => overflow_style,
          round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function to_sfixed;

  function to_sfixed (
    arg                     : integer_matrix;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := 0;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_sfixed (
          arg            => arg (i+ arg'low(1), j+arg'low(2)),
          left_index     => result(i, j)'high,
          right_index    => result(i, j)'low,
          overflow_style => overflow_style,
          round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function to_sfixed;

  function to_sfixed (
    arg                     : ufixed_matrix;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix is
    variable result : sfixed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (
          arg            => to_sfixed (arg (i+ arg'low(1), j+arg'low(2))),
          left_index     => result(i, j)'high,
          right_index    => result(i, j)'low,
          overflow_style => overflow_style,
          round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function to_sfixed;

  function to_sfixed (
    arg                     : signed_vector;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := 0;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector is
    variable result : sfixed_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := to_sfixed (
        arg            => arg (i+ arg'low),
        left_index     => result(i)'high,
        right_index    => result(i)'low,
        overflow_style => overflow_style,
        round_style    => round_style);
    end loop;
    return result;
  end function to_sfixed;

  function to_sfixed (
    arg                     : real_vector;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector is
    variable result : sfixed_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := to_sfixed (
        arg            => arg (i+ arg'low),
        left_index     => result(i)'high,
        right_index    => result(i)'low,
        overflow_style => overflow_style,
        round_style    => round_style);
    end loop;
    return result;
  end function to_sfixed;

  function to_sfixed (
    arg                     : integer_vector;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := 0;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector is
    variable result : sfixed_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := to_sfixed (
        arg            => arg (i+ arg'low),
        left_index     => result(i)'high,
        right_index    => result(i)'low,
        overflow_style => overflow_style,
        round_style    => round_style);
    end loop;
    return result;
  end function to_sfixed;

  function to_sfixed (
    arg                     : ufixed_vector;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;  -- right index
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector is
    variable result : sfixed_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := resize (
        arg            => to_sfixed (arg (i+ arg'low)),
        left_index     => result(i)'high,
        right_index    => result(i)'low,
        overflow_style => overflow_style,
        round_style    => round_style);
    end loop;
    return result;
  end function to_sfixed;

  -----------------------------------------------------------------------------
  -- to_unsigned
  -----------------------------------------------------------------------------
  function to_unsigned (
    arg                     : ufixed_matrix;
    constant size           : NATURAL                   := unsigned_matrix_high+1;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length(1)-1,
                                       0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_unsigned (
          arg            => arg (i+ arg'low(1), j+arg'low(2)),
          size           => result(i, j)'length,
          overflow_style => overflow_style,
          round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function to_unsigned;

  function to_unsigned (
    arg           : integer_matrix;
    constant size : NATURAL := unsigned_matrix_high+1)
    return unsigned_matrix is
    variable result : unsigned_matrix (0 to arg'length(1)-1,
                                       0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        if arg (i+arg'low(1), j+arg'low(2)) < 0 then
          result (i, j) := (others => '0');
        else
          result (i, j) := to_unsigned (
            arg  => arg (i+ arg'low(1), j+arg'low(2)),
            size => result(i, j)'length);
        end if;
      end loop;
    end loop;
    return result;
  end function to_unsigned;

  function to_unsigned (
    arg                     : ufixed_vector;
    constant size           : NATURAL                   := unsigned_matrix_high+1;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return unsigned_vector is
    variable result : unsigned_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := to_unsigned (
        arg            => arg (i+ arg'low),
        size           => result(i)'length,
        overflow_style => overflow_style,
        round_style    => round_style);
    end loop;
    return result;
  end function to_unsigned;

  function to_unsigned (
    arg           : integer_vector;
    constant size : NATURAL := unsigned_matrix_high+1)
    return unsigned_vector is
    variable result : unsigned_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      if arg(i + arg'low) < 0 then
        result (i) := (others => '0');
      else
        result (i) := to_unsigned (
          arg  => arg (i+ arg'low),
          size => result(i)'length);
      end if;
    end loop;
    return result;
  end function to_unsigned;

  -----------------------------------------------------------------------------
  -- to_signed
  -----------------------------------------------------------------------------
  function to_signed (
    arg                     : sfixed_matrix;
    constant size           : NATURAL                   := signed_matrix_high +1;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_signed (
          arg            => arg (i+ arg'low(1), j+arg'low(2)),
          size           => result(i, j)'length,
          overflow_style => overflow_style,
          round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function to_signed;

  function to_signed (
    arg           : integer_matrix;
    constant size : NATURAL := signed_matrix_high+1)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_signed (
          arg  => arg (i+ arg'low(1), j+arg'low(2)),
          size => result(i, j)'length);
      end loop;
    end loop;
    return result;
  end function to_signed;

  function to_signed (
    arg           : unsigned_matrix;
    constant size : NATURAL := signed_matrix_high+1)
    return signed_matrix is
    variable result : signed_matrix (0 to arg'length(1)-1,
                                     0 to arg'length(2)-1);
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (
          arg      => SIGNED ('0' & arg (i+ arg'low(1), j+arg'low(2))),
          new_size => result(i, j)'length);
      end loop;
    end loop;
    return result;
  end function to_signed;

  function to_signed (
    arg                     : sfixed_vector;
    constant size           : NATURAL                   := signed_matrix_high+1;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return signed_vector is
    variable result : signed_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := to_signed (
        arg            => arg (i+ arg'low),
        size           => result(i)'length,
        overflow_style => overflow_style,
        round_style    => round_style);
    end loop;
    return result;
  end function to_signed;

  function to_signed (
    arg           : integer_vector;
    constant size : NATURAL := signed_matrix_high+1)
    return signed_vector is
    variable result : signed_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := to_signed (
        arg  => arg (i+ arg'low),
        size => result(i)'length);
    end loop;
    return result;
  end function to_signed;

  function to_signed (
    arg           : unsigned_vector;
    constant size : NATURAL := signed_matrix_high+1)
    return signed_vector is
    variable result : signed_vector (0 to arg'length-1);
  begin
    for i in result'range loop
      result (i) := resize(
        arg      => SIGNED ('0' & arg (i+ arg'low)),
        new_size => result(i)'length);
    end loop;
    return result;
  end function to_signed;

  -----------------------------------------------------------------------------
  -- to_real
  -----------------------------------------------------------------------------
  function to_real (
    arg : ufixed_matrix)
    return real_matrix is
    variable result : real_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_real (arg (i, j));
      end loop;
    end loop;
    return result;
  end function to_real;

  function to_real (
    arg : sfixed_matrix)
    return real_matrix is
    variable result : real_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_real (arg (i, j));
      end loop;
    end loop;
    return result;
  end function to_real;

  function to_real (
    arg : ufixed_vector)
    return real_vector is
    variable result : real_vector (arg'range);
  begin
    for i in result'range loop
      result (i) := to_real (arg (i));
    end loop;
    return result;
  end function to_real;

  function to_real (
    arg : sfixed_vector)
    return real_vector is
    variable result : real_vector (arg'range);
  begin
    for i in result'range loop
      result (i) := to_real (arg (i));
    end loop;
    return result;
  end function to_real;

  function to_integer (
    arg : unsigned_matrix)
    return integer_matrix is
    variable result : integer_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_integer (arg (i, j));
      end loop;
    end loop;
    return result;
  end function to_integer;

  function to_integer (
    arg : signed_matrix)
    return integer_matrix is
    variable result : integer_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := to_integer (arg (i, j));
      end loop;
    end loop;
    return result;
  end function to_integer;

  function to_integer (
    arg : unsigned_vector)
    return integer_vector is
    variable result : integer_vector (arg'range);
  begin
    for i in result'range loop
      result (i) := to_integer (arg (i));
    end loop;
    return result;
  end function to_integer;

  function to_integer (
    arg : signed_vector)
    return integer_vector is
    variable result : integer_vector (arg'range);
  begin
    for i in result'range loop
      result (i) := to_integer (arg (i));
    end loop;
    return result;
  end function to_integer;

  -- These guys are dummies until we get unconstrained arrays of unconstrained
  -- arrays
  function resize (
    arg                     : ufixed_matrix;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix is
    variable result : ufixed_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (
          arg            => arg (i, j),
          left_index     => left_index,
          right_index    => right_index,
          overflow_style => overflow_style,
          round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function resize;

  function resize (
    arg                     : sfixed_matrix;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix is
    variable result : sfixed_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (
          arg            => arg (i, j),
          left_index     => left_index,
          right_index    => right_index,
          overflow_style => overflow_style,
          round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function resize;

  function resize (
    arg               : unsigned_matrix;
    constant new_size : POSITIVE := unsigned_matrix_high)
    return unsigned_matrix is
    variable result : unsigned_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (
          arg      => arg (i, j),
          new_size => new_size);
      end loop;
    end loop;
    return result;
  end function resize;

  function resize (
    arg               : signed_matrix;
    constant new_size : POSITIVE := signed_matrix_high)
    return signed_matrix is
    variable result : signed_matrix (arg'range(1), arg'range(2));
  begin
    for i in result'range(1) loop
      for j in result'range(2) loop
        result (i, j) := resize (
          arg      => arg (i, j),
          new_size => new_size);
      end loop;
    end loop;
    return result;
  end function resize;

  function resize (
    arg                     : ufixed_vector;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector is
    variable result : ufixed_vector (arg'range);
  begin
    for i in result'range loop
      result (i) := resize (
        arg            => arg (i),
        left_index     => left_index,
        right_index    => right_index,
        overflow_style => overflow_style,
        round_style    => round_style);
    end loop;
    return result;
  end function resize;

  function resize (
    arg                     : sfixed_vector;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector is
    variable result : sfixed_vector (arg'range);
  begin
    for i in result'range loop
      result (i) := resize (
        arg            => arg (i),
        left_index     => left_index,
        right_index    => right_index,
        overflow_style => overflow_style,
        round_style    => round_style);
    end loop;
    return result;
  end function resize;

  function resize (
    arg               : unsigned_vector;
    constant new_size : POSITIVE := unsigned_matrix_high)
    return unsigned_vector is
    variable result : unsigned_vector (arg'range);
  begin
    for i in result'range loop
      result (i) := resize (
        arg      => arg (i),
        new_size => new_size);
    end loop;
    return result;
  end function resize;

  function resize (
    arg               : signed_vector;
    constant new_size : POSITIVE := signed_matrix_high)
    return signed_vector is
    variable result : signed_vector (arg'range);
  begin
    for i in result'range loop
      result (i) := resize (
        arg      => arg (i),
        new_size => new_size);
    end loop;
    return result;
  end function resize;

  -- Rounds to a given precision.  "places" is the number of bits to round to.
  -- (named xprecision to not interfere with "precision")
  function xprecision (
    arg                     : sfixed;
    constant places         : NATURAL                   := -sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed is
    variable argr   : sfixed (arg'high downto -places);  -- rounded
    variable result : sfixed (arg'range);
  begin
    argr := resize (arg            => arg,
                    left_index     => arg'high,
                    right_index    => -places,
                    overflow_style => overflow_style,
                    round_style    => round_style);
    result := resize (argr,
                      arg'high, arg'low);
    return result;
  end function xprecision;

  function xprecision (
    arg                     : ufixed;
    constant places         : NATURAL                   := -ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed is
    variable argr   : ufixed (arg'high downto -places);  -- rounded
    variable result : ufixed (arg'range);
  begin
    argr := resize (arg            => arg,
                    left_index     => arg'high,
                    right_index    => -places,
                    overflow_style => overflow_style,
                    round_style    => round_style);
    result := resize (argr,
                      arg'high, arg'low);
    return result;
  end function xprecision;

  function precision (
    arg                     : sfixed_vector;
    constant places         : NATURAL                   := -sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector is
    variable result : sfixed_vector (arg'range);
  begin
    for i in arg'range loop
      result(i) := xprecision (arg            => arg(i),
                               places         => places,
                               overflow_style => overflow_style,
                               round_style    => round_style);
    end loop;
    return result;
  end function precision;

  function precision (
    arg                     : sfixed_matrix;
    constant places         : NATURAL                   := -sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix is
    variable result : sfixed_matrix (arg'range(1), arg'range(2));
  begin
    for i in arg'range(1) loop
      for j in arg'range(2) loop
        result(i, j) := xprecision (arg            => arg(i, j),
                                    places         => places,
                                    overflow_style => overflow_style,
                                    round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function precision;

  function precision (
    arg                     : ufixed_vector;
    constant places         : NATURAL                   := -ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector is
    variable result : ufixed_vector (arg'range);
  begin
    for i in arg'range loop
      result(i) := xprecision (arg            => arg(i),
                               places         => places,
                               overflow_style => overflow_style,
                               round_style    => round_style);
    end loop;
    return result;
  end function precision;

  function precision (
    arg                     : ufixed_matrix;
    constant places         : NATURAL                   := -ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix is
    variable result : ufixed_matrix (arg'range(1), arg'range(2));
  begin
    for i in arg'range(1) loop
      for j in arg'range(2) loop
        result(i, j) := xprecision (arg            => arg(i, j),
                                    places         => places,
                                    overflow_style => overflow_style,
                                    round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function precision;

  -- rounding routines (named xround to not interfere with "round")
  function xround (
    arg                     : sfixed;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed is
    variable argr   : sfixed (maximum (arg'high, 1) downto 0);  -- rounded
    variable result : sfixed (arg'range);
  begin
    argr := resize (arg            => arg,
                    left_index     => argr'high,
                    right_index    => 0,
                    overflow_style => overflow_style,
                    round_style    => round_style);
    result := resize (arg            => argr,
                      left_index     => arg'high,
                      right_index    => arg'low,
                      overflow_style => overflow_style,
                      round_style    => round_style);
    return result;
  end function xround;

  function xround (
    arg                     : ufixed;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed is
    variable argr   : ufixed (maximum (arg'high, 0) downto 0);  -- rounded
    variable result : ufixed (arg'range);
  begin
    argr := resize (arg            => arg,
                    left_index     => argr'high,
                    right_index    => 0,
                    overflow_style => overflow_style,
                    round_style    => round_style);
    result := resize (arg            => argr,
                      left_index     => arg'high,
                      right_index    => arg'low,
                      overflow_style => overflow_style,
                      round_style    => round_style);
    return result;
  end function xround;

  function round (
    arg                     : sfixed_vector;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector is
    variable result : sfixed_vector (arg'range);
  begin
    for i in arg'range loop
      result(i) := xround (arg            => arg(i),
                           overflow_style => overflow_style,
                           round_style    => round_style);
    end loop;
    return result;
  end function round;

  function round (
    arg                     : sfixed_matrix;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix is
    variable result : sfixed_matrix (arg'range(1), arg'range(2));
  begin
    for i in arg'range(1) loop
      for j in arg'range(2) loop
        result(i, j) := xround (arg            => arg(i, j),
                                overflow_style => overflow_style,
                                round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function round;

  function round (
    arg                     : ufixed_vector;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector is
    variable result : ufixed_vector (arg'range);
  begin
    for i in arg'range loop
      result(i) := xround (arg            => arg(i),
                           overflow_style => overflow_style,
                           round_style    => round_style);
    end loop;
    return result;
  end function round;

  function round (
    arg                     : ufixed_matrix;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix is
    variable result : ufixed_matrix (arg'range(1), arg'range(2));
  begin
    for i in arg'range(1) loop
      for j in arg'range(2) loop
        result(i, j) := xround (arg            => arg(i, j),
                                overflow_style => overflow_style,
                                round_style    => round_style);
      end loop;
    end loop;
    return result;
  end function round;

  -----------------------------------------------------------------------------
  -- Overloads
  -----------------------------------------------------------------------------

  -- sfixed, overloaded with Signed, Integer, Real, and ufixed.
  -- There is intentionally no overload between sfixed and unsigned.
  -- Please convert unsigned to either ufixed or signed before doing an
  -- operation with sfixed.
  function "*" (
    l : sfixed_matrix;
    r : signed_matrix)
    return sfixed_matrix is
  begin
    return l * to_sfixed (r, r(r'low(1), r'low(2))'high, 0);
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : real_matrix)
    return sfixed_matrix is
  begin
    return l * to_sfixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : integer_matrix)
    return sfixed_matrix is
  begin
    return l * to_sfixed (r, l(l'low(1), l'low(2))'high, 0);
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : ufixed_matrix)
    return sfixed_matrix is
  begin
    return l * to_sfixed (r, r(r'low(1), r'low(2))'high+1, r(r'low(1), r'low(2))'low);
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : signed_vector)
    return sfixed_matrix is
  begin
    return l * to_sfixed (r, r(r'low)'high);
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : real_vector)
    return sfixed_matrix is
  begin
    return l * to_sfixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : integer_vector)
    return sfixed_matrix is
  begin
    return l * to_sfixed (r, l(l'low(1), l'low(2))'high, 0);
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : ufixed_vector)
    return sfixed_matrix is
  begin
    return l * to_sfixed (r, r(r'low)'high+1, r(r'low)'low);
  end function "*";

  function "*" (
    l : signed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high) * r;
  end function "*";

  function "*" (
    l : real_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low) * r;
  end function "*";

  function "*" (
    l : integer_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high, 0) * r;
  end function "*";

  function "*" (
    l : ufixed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, l(l'low(1), l'low(2))'high+1, l(l'low(1), l'low(2))'low) * r;
  end function "*";

  function "*" (
    l : signed_vector;
    r : sfixed_matrix)
    return sfixed_vector is
  begin
    return to_sfixed(l, l(l'low)'high) * r;
  end function "*";

  function "*" (
    l : real_vector;
    r : sfixed_matrix)
    return sfixed_vector is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low) * r;
  end function "*";

  function "*" (
    l : integer_vector;
    r : sfixed_matrix)
    return sfixed_vector is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high, 0) * r;
  end function "*";

  function "*" (
    l : ufixed_vector;
    r : sfixed_matrix)
    return sfixed_vector is
  begin
    return to_sfixed(l, l(l'low)'high+1, l(l'low)'low) * r;
  end function "*";

  function "*" (
    l : SIGNED;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l) * r;
  end function "*";

  function "*" (
    l : INTEGER;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed (l, r(r'low(1), r'low(2))'high, 0) * r;
  end function "*";

  function "*" (
    l : REAL;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed (l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low) * r;
  end function "*";

  function "*" (
    l : ufixed;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed (l) * r;
  end function "*";

  function "*" (
    l : SIGNED;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed(l) * r;
  end function "*";

  function "*" (
    l : INTEGER;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed (l, r(r'low)'high, 0) * r;
  end function "*";

  function "*" (
    l : REAL;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed (l, r(r'low)'high, r(r'low)'low) * r;
  end function "*";

  function "*" (
    l : ufixed;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed (l) * r;
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : SIGNED)
    return sfixed_matrix is
  begin
    return to_sfixed(r) * l;
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : INTEGER)
    return sfixed_matrix is
  begin
    return to_sfixed (r, l(l'low(1), l'low(2))'high, 0) * l;
  end function "*";
  
  function "*" (
    l : sfixed_matrix;
    r : REAL)
    return sfixed_matrix is
  begin
    return to_sfixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low) * l;
  end function "*";

  function "*" (
    l : sfixed_matrix;
    r : ufixed)
    return sfixed_matrix is
  begin
    return to_sfixed (r) * l;
  end function "*";

  function "*" (
    l : sfixed_vector;
    r : SIGNED)
    return sfixed_vector is
  begin
    return to_sfixed(r) * l;
  end function "*";

  function "*" (
    l : sfixed_vector;
    r : INTEGER)
    return sfixed_vector is
  begin
    return to_sfixed (r, l(l'low)'high, 0) * l;
  end function "*";
  
  function "*" (
    l : sfixed_vector;
    r : REAL)
    return sfixed_vector is
  begin
    return to_sfixed (r, l(l'low)'high, l(l'low)'low) * l;
  end function "*";

  function "*" (
    l : sfixed_vector;
    r : ufixed)
    return sfixed_vector is
  begin
    return to_sfixed (r) * l;
  end function "*";

  function "+" (
    l : sfixed_matrix;
    r : signed_matrix)
    return sfixed_matrix is
  begin
    return l + to_sfixed (r, r(r'low(1), r'low(2))'high, 0);
  end function "+";

  function "+" (
    l : sfixed_matrix;
    r : integer_matrix)
    return sfixed_matrix is
  begin
    return l + to_sfixed (r, l(l'low(1), l'low(2))'high, 0);
  end function "+";

  function "+" (
    l : sfixed_matrix;
    r : real_matrix)
    return sfixed_matrix is
  begin
    return l + to_sfixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function "+";

  function "+" (
    l : sfixed_matrix;
    r : ufixed_matrix)
    return sfixed_matrix is
  begin
    return l + to_sfixed (r, r(r'low(1), r'low(2))'high+1, r(r'low(1), r'low(2))'low);
  end function "+";

  function "+" (
    l : signed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, l(l'low(1), l'low(2))'high, 0) + r;
  end function "+";

  function "+" (
    l : integer_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high+1, 0) + r;
  end function "+";

  function "+" (
    l : real_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high+1, r(r'low(1), r'low(2))'low) + r;
  end function "+";

  function "+" (
    l : ufixed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, l(l'low(1), l'low(2))'high+1, l(l'low(1), l'low(2))'low) + r;
  end function "+";

  function "+" (
    l : sfixed_vector;
    r : signed_vector)
    return sfixed_vector is
  begin
    return l + to_sfixed (r, r(r'low)'high, 0);
  end function "+";

  function "+" (
    l : sfixed_vector;
    r : integer_vector)
    return sfixed_vector is
  begin
    return l + to_sfixed (r, l(l'low)'high, l(l'low)'low);
  end function "+";

  function "+" (
    l : sfixed_vector;
    r : real_vector)
    return sfixed_vector is
  begin
    return l + to_sfixed (r, l(l'low)'high, l(l'low)'low);
  end function "+";

  function "+" (
    l : sfixed_vector;
    r : ufixed_vector)
    return sfixed_vector is
  begin
    return l + to_sfixed (r, r(r'low)'high+1, r(r'low)'low);
  end function "+";

  function "+" (
    l : signed_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed(l, l(l'low)'high, 0) + r;
  end function "+";

  function "+" (
    l : integer_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed(l, r(r'low)'high, 0) + r;
  end function "+";

  function "+" (
    l : real_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed(l, r(r'low)'high, r(r'low)'low) + r;
  end function "+";

  function "+" (
    l : ufixed_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed(l, l(l'low)'high+1, l(l'low)'low) + r;
  end function "+";

  function "-" (
    l : sfixed_matrix;
    r : signed_matrix)
    return sfixed_matrix is
  begin
    return l - to_sfixed (r, r(r'low(1), r'low(2))'high, 0);
  end function "-";

  function "-" (
    l : sfixed_matrix;
    r : integer_matrix)
    return sfixed_matrix is
  begin
    return l - to_sfixed (r, l(l'low(1), l'low(2))'high, 0);
  end function "-";

  function "-" (
    l : sfixed_matrix;
    r : real_matrix)
    return sfixed_matrix is
  begin
    return l - to_sfixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function "-";

  function "-" (
    l : sfixed_matrix;
    r : ufixed_matrix)
    return sfixed_matrix is
  begin
    return l - to_sfixed (r, r(r'low(1), r'low(2))'high+1, r(r'low(1), r'low(2))'low);
  end function "-";

  function "-" (
    l : signed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, l(l'low(1), l'low(2))'high, 0) - r;
  end function "-";

  function "-" (
    l : integer_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high, 0) - r;
  end function "-";

  function "-" (
    l : real_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low) - r;
  end function "-";

  function "-" (
    l : ufixed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, l(l'low(1), l'low(2))'high+1, l(l'low(1), l'low(2))'low) - r;
  end function "-";

  function "-" (
    l : sfixed_vector;
    r : signed_vector)
    return sfixed_vector is
  begin
    return l - to_sfixed (r, r(r'low)'high, 0);
  end function "-";

  function "-" (
    l : sfixed_vector;
    r : integer_vector)
    return sfixed_vector is
  begin
    return l - to_sfixed (r, l(l'low)'high, 0);
  end function "-";

  function "-" (
    l : sfixed_vector;
    r : real_vector)
    return sfixed_vector is
  begin
    return l - to_sfixed (r, l(l'low)'high, l(l'low)'low);
  end function "-";

  function "-" (
    l : sfixed_vector;
    r : ufixed_vector)
    return sfixed_vector is
  begin
    return l - to_sfixed (r, r(r'low)'high+1, r(r'low)'low);
  end function "-";

  function "-" (
    l : signed_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed(l, l(l'low)'high, 0) - r;
  end function "-";

  function "-" (
    l : integer_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed(l, r(r'low)'high, 0) - r;
  end function "-";

  function "-" (
    l : real_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed(l, r(r'low)'high, r(r'low)'low) - r;
  end function "-";

  function "-" (
    l : ufixed_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return to_sfixed(l, l(l'low)'high+1, l(l'low)'low) - r;
  end function "-";
  
  function "/" (
    l : sfixed_matrix;
    r : signed_matrix)
    return sfixed_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function "/" (
    l : sfixed_matrix;
    r : integer_matrix)
    return sfixed_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function "/" (
    l : sfixed_matrix;
    r : real_matrix)
    return sfixed_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function "/" (
    l : sfixed_matrix;
    r : ufixed_matrix)
    return sfixed_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function "/" (
    l : signed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function "/" (
    l : integer_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function "/" (
    l : real_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function "/" (
    l : ufixed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return mrdivide (l, r);
  end function "/";

  function "/" (
    l : sfixed_matrix;
    r : SIGNED)
    return sfixed_matrix is
  begin
    return l / to_sfixed (r);
  end function "/";

  function "/" (
    l : sfixed_matrix;
    r : INTEGER)
    return sfixed_matrix is
  begin
    return l / to_sfixed (r, l(l'low(1), l'low(2))'high, 0);
  end function "/";

  function "/" (
    l : sfixed_matrix;
    r : REAL)
    return sfixed_matrix is
  begin
    return l / to_sfixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function "/";

  function "/" (
    l : sfixed_matrix;
    r : ufixed)
    return sfixed_matrix is
  begin
    return l / to_sfixed (r);
  end function "/";

  function times (
    l : sfixed_matrix;
    r : signed_matrix)
    return sfixed_matrix is
  begin
    return times (l, to_sfixed (r, r(r'low(1), r'low(2))'high, 0));
  end function times;

  function times (
    l : sfixed_matrix;
    r : integer_matrix)
    return sfixed_matrix is
  begin
    return times (l, to_sfixed (r, l(l'low(1), l'low(2))'high, 0));
  end function times;

  function times (
    l : sfixed_matrix;
    r : real_matrix)
    return sfixed_matrix is
  begin
    return times (l, to_sfixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low));
  end function times;

  function times (
    l : sfixed_matrix;
    r : ufixed_matrix)
    return sfixed_matrix is
  begin
    return times (l, to_sfixed (r, r(r'low(1), r'low(2))'high+1, r(r'low(1), r'low(2))'low));
  end function times;

  function times (
    l : signed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return times (to_sfixed(l, l(l'low(1), l'low(2))'high, 0), r);
  end function times;

  function times (
    l : integer_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return times (to_sfixed(l, r(r'low(1), r'low(2))'high, 0), r);
  end function times;

  function times (
    l : real_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return times (to_sfixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low), r);
  end function times;

  function times (
    l : ufixed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return times (to_sfixed(l, l(l'low(1), l'low(2))'high+1, l(l'low(1), l'low(2))'low), r);
  end function times;

  function times (
    l : sfixed_vector;
    r : signed_vector)
    return sfixed_vector is
  begin
    return times (l, to_sfixed (r, r(r'low)'high, 0));
  end function times;

  function times (
    l : sfixed_vector;
    r : integer_vector)
    return sfixed_vector is
  begin
    return times (l, to_sfixed (r, l(l'low)'high, 0));
  end function times;

  function times (
    l : sfixed_vector;
    r : real_vector)
    return sfixed_vector is
  begin
    return times (l, to_sfixed (r, l(l'low)'high, l(l'low)'low));
  end function times;

  function times (
    l : sfixed_vector;
    r : ufixed_vector)
    return sfixed_vector is
  begin
    return times (l, to_sfixed (r, r(r'low)'high+1, r(r'low)'low));
  end function times;

  function times (
    l : signed_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return times (to_sfixed(l, l(l'low)'high, 0), r);
  end function times;

  function times (
    l : integer_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return times (to_sfixed(l, r(r'low)'high, 0), r);
  end function times;

  function times (
    l : real_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return times (to_sfixed(l, r(r'low)'high, r(r'low)'low), r);
  end function times;

  function times (
    l : ufixed_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return times (to_sfixed(l, l(l'low)'high+1, l(l'low)'low), r);
  end function times;
  
  function rdivide (
    l : sfixed_matrix;
    r : signed_matrix)
    return sfixed_matrix is
  begin
    return rdivide (l, to_sfixed(r, r(r'low(1), r'low(2))'high, 0));
  end function rdivide;

  function rdivide (
    l : sfixed_matrix;
    r : integer_matrix)
    return sfixed_matrix is
  begin
    return rdivide (l, to_sfixed(r, l(l'low(1), l'low(2))'high, 0));
  end function rdivide;

  function rdivide (
    l : sfixed_matrix;
    r : real_matrix)
    return sfixed_matrix is
  begin
    return rdivide (l, to_sfixed(r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low));
  end function rdivide;

  function rdivide (
    l : sfixed_matrix;
    r : ufixed_matrix)
    return sfixed_matrix is
  begin
    return rdivide (l, to_sfixed(r, r(r'low(1), r'low(2))'high+1, r(r'low(1), r'low(2))'low));
  end function rdivide;

  function rdivide (
    l : signed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return rdivide (to_sfixed(l, l(l'low(1), l'low(2))'high, 0), r);
  end function rdivide;

  function rdivide (
    l : integer_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return rdivide (to_sfixed(l, r(r'low(1), r'low(2))'high, 0), r);
  end function rdivide;

  function rdivide (
    l : real_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return rdivide (to_sfixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low), r);
  end function rdivide;

  function rdivide (
    l : ufixed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return rdivide (to_sfixed(l, l(l'low(1), l'low(2))'high+1, l(l'low(1), l'low(2))'low), r);
  end function rdivide;

  function rdivide (
    l : sfixed_vector;
    r : signed_vector)
    return sfixed_vector is
  begin
    return rdivide (l, to_sfixed (r, r(r'low)'high, 0));
  end function rdivide;

  function rdivide (
    l : sfixed_vector;
    r : integer_vector)
    return sfixed_vector is
  begin
    return rdivide (l, to_sfixed (r, l(l'low)'high, 0));
  end function rdivide;

  function rdivide (
    l : sfixed_vector;
    r : real_vector)
    return sfixed_vector is
  begin
    return rdivide (l, to_sfixed (r, l(l'low)'high, l(l'low)'low));
  end function rdivide;

  function rdivide (
    l : sfixed_vector;
    r : ufixed_vector)
    return sfixed_vector is
  begin
    return rdivide (l, to_sfixed (r, r(r'low)'high+1, r(r'low)'low));
  end function rdivide;

  function rdivide (
    l : signed_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return rdivide (to_sfixed(l, l(l'low)'high, 0), r);
  end function rdivide;

  function rdivide (
    l : integer_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return rdivide (to_sfixed(l, r(r'low)'high, 0), r);
  end function rdivide;

  function rdivide (
    l : real_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return rdivide (to_sfixed(l, r(r'low)'high, r(r'low)'low), r);
  end function rdivide;

  function rdivide (
    l : ufixed_vector;
    r : sfixed_vector)
    return sfixed_vector is
  begin
    return rdivide (to_sfixed(l, l(l'low)'high+1, l(l'low)'low), r);
  end function rdivide;

  function mrdivide (
    l : sfixed_matrix;
    r : signed_matrix)
    return sfixed_matrix is
  begin
    return l * inv(to_sfixed(r, r(r'low(1), r'low(2))'high, 0));
  end function mrdivide;

  function mrdivide (
    l : sfixed_matrix;
    r : integer_matrix)
    return sfixed_matrix is
  begin
    return l * inv(to_sfixed(r, l(l'low(1), l'low(2))'high, 0));
  end function mrdivide;

  function mrdivide (
    l : sfixed_matrix;
    r : real_matrix)
    return sfixed_matrix is
  begin
    return l * inv(to_sfixed(r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low));
  end function mrdivide;

  function mrdivide (
    l : sfixed_matrix;
    r : ufixed_matrix)
    return sfixed_matrix is
  begin
    return l * inv(to_sfixed(r, r(r'low(1), r'low(2))'high+1, r(r'low(1), r'low(2))'low));
  end function mrdivide;

  function mrdivide (
    l : signed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, l(l'low(1), l'low(2))'high, 0) * inv(r);
  end function mrdivide;

  function mrdivide (
    l : integer_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high, 0) * inv(r);
  end function mrdivide;

  function mrdivide (
    l : real_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low) * inv(r);
  end function mrdivide;

  function mrdivide (
    l : ufixed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return to_sfixed(l, l(l'low(1), l'low(2))'high+1, l(l'low(1), l'low(2))'low) * inv(r);
  end function mrdivide;

  function mldivide (
    l : sfixed_matrix;
    r : signed_matrix)
    return sfixed_matrix is
  begin
    return inv(l) * to_sfixed(r, r(r'low(1), r'low(2))'high, 0);
  end function mldivide;

  function mldivide (
    l : sfixed_matrix;
    r : integer_matrix)
    return sfixed_matrix is
  begin
    return inv(l) * to_sfixed(r, l(l'low(1), l'low(2))'high, 0);
  end function mldivide;

  function mldivide (
    l : sfixed_matrix;
    r : real_matrix)
    return sfixed_matrix is
  begin
    return inv(l) * to_sfixed(r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function mldivide;

  function mldivide (
    l : sfixed_matrix;
    r : ufixed_matrix)
    return sfixed_matrix is
  begin
    return inv(l) * to_sfixed(r, r(r'low(1), r'low(2))'high+1, r(r'low(1), r'low(2))'low);
  end function mldivide;

  function mldivide (
    l : signed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return inv(to_sfixed(l, l(l'low(1), l'low(2))'high, 0)) * r;
  end function mldivide;

  function mldivide (
    l : integer_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return inv(to_sfixed(l, r(r'low(1), r'low(2))'high, 0)) * r;
  end function mldivide;

  function mldivide (
    l : real_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return inv(to_sfixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low)) * r;
  end function mldivide;

  function mldivide (
    l : ufixed_matrix;
    r : sfixed_matrix)
    return sfixed_matrix is
  begin
    return inv(to_sfixed(l, l(l'low(1), l'low(2))'high+1, l(l'low(1), l'low(2))'low)) * r;
  end function mldivide;

  -- ufixed, overloaded for unsigned, real, and integer
  function "*" (
    l : ufixed_matrix;
    r : unsigned_matrix)
    return ufixed_matrix is
  begin
    return l * to_ufixed (r, r(r'low(1), r'low(2))'high, 0);
  end function "*";

  function "*" (
    l : ufixed_matrix;
    r : real_matrix)
    return ufixed_matrix is
  begin
    return l * to_ufixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function "*";

  function "*" (
    l : ufixed_matrix;
    r : integer_matrix)
    return ufixed_matrix is
  begin
    return l * to_ufixed (r, l(l'low(1), l'low(2))'high, 0);
  end function "*";

  function "*" (
    l : ufixed_matrix;
    r : unsigned_vector)
    return ufixed_matrix is
  begin
    return l * to_ufixed (r, r(r'low)'high, 0);
  end function "*";

  function "*" (
    l : ufixed_matrix;
    r : real_vector)
    return ufixed_matrix is
  begin
    return l * to_ufixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function "*";

  function "*" (
    l : ufixed_matrix;
    r : integer_vector)
    return ufixed_matrix is
  begin
    return l * to_ufixed (r, l(l'low(1), l'low(2))'high, 0);
  end function "*";

  function "*" (
    l : unsigned_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed(l, l(l'low(1), l'low(2))'high, 0) * r;
  end function "*";

  function "*" (
    l : real_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low) * r;
  end function "*";

  function "*" (
    l : integer_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed(l, r(r'low(1), r'low(2))'high, 0) * r;
  end function "*";

  function "*" (
    l : unsigned_vector;
    r : ufixed_matrix)
    return ufixed_vector is
  begin
    return to_ufixed(l, l(l'low)'high, 0) * r;
  end function "*";

  function "*" (
    l : real_vector;
    r : ufixed_matrix)
    return ufixed_vector is
  begin
    return to_ufixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low) * r;
  end function "*";

  function "*" (
    l : integer_vector;
    r : ufixed_matrix)
    return ufixed_vector is
  begin
    return to_ufixed(l, r(r'low(1), r'low(2))'high, 0) * r;
  end function "*";

  function "*" (
    l : UNSIGNED;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed(l) * r;
  end function "*";

  function "*" (
    l : INTEGER;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed (l, r(r'low(1), r'low(2))'high, 0) * r;
  end function "*";

  function "*" (
    l : REAL;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed (l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low) * r;
  end function "*";

  function "*" (
    l : UNSIGNED;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return to_ufixed(l) * r;
  end function "*";

  function "*" (
    l : INTEGER;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return to_ufixed (l, r(r'low)'high, 0) * r;
  end function "*";

  function "*" (
    l : REAL;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return to_ufixed (l, r(r'low)'high, r(r'low)'low) * r;
  end function "*";

  function "*" (
    l : ufixed_matrix;
    r : UNSIGNED)
    return ufixed_matrix is
  begin
    return to_ufixed(r) * l;
  end function "*";

  function "*" (
    l : ufixed_matrix;
    r : INTEGER)
    return ufixed_matrix is
  begin
    return to_ufixed (r, l(l'low(1), l'low(2))'high, 0) * l;
  end function "*";
  
  function "*" (
    l : ufixed_matrix;
    r : REAL)
    return ufixed_matrix is
  begin
    return to_ufixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low) * l;
  end function "*";

  function "*" (
    l : ufixed_vector;
    r : UNSIGNED)
    return ufixed_vector is
  begin
    return to_ufixed(r) * l;
  end function "*";

  function "*" (
    l : ufixed_vector;
    r : INTEGER)
    return ufixed_vector is
  begin
    return to_ufixed (r, l(l'low)'high, 0) * l;
  end function "*";
  
  function "*" (
    l : ufixed_vector;
    r : REAL)
    return ufixed_vector is
  begin
    return to_ufixed (r, l(l'low)'high, l(l'low)'low) * l;
  end function "*";

  function "/" (
    l : ufixed_matrix;
    r : UNSIGNED)
    return ufixed_matrix is
  begin
    return l / to_ufixed (r);
  end function "/";

  function "/" (
    l : ufixed_matrix;
    r : INTEGER)
    return ufixed_matrix is
  begin
    return l / to_ufixed (r, l(l'low(1), l'low(2))'high, 0);
  end function "/";

  function "/" (
    l : ufixed_matrix;
    r : REAL)
    return ufixed_matrix is
  begin
    return l / to_ufixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function "/";

  function "+" (
    l : ufixed_matrix;
    r : unsigned_matrix)
    return ufixed_matrix is
  begin
    return l + to_ufixed (r, r(r'low(1), r'low(2))'high, 0);
  end function "+";

  function "+" (
    l : ufixed_matrix;
    r : integer_matrix)
    return ufixed_matrix is
  begin
    return l + to_ufixed (r, l(l'low(1), l'low(2))'high, 0);
  end function "+";

  function "+" (
    l : ufixed_matrix;
    r : real_matrix)
    return ufixed_matrix is
  begin
    return l + to_ufixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function "+";

  function "+" (
    l : unsigned_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed(l, l(l'low(1), l'low(2))'high, 0) + r;
  end function "+";

  function "+" (
    l : integer_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed(l, r(r'low(1), r'low(2))'high, 0) + r;
  end function "+";

  function "+" (
    l : real_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low) + r;
  end function "+";

  function "+" (
    l : ufixed_vector;
    r : unsigned_vector)
    return ufixed_vector is
  begin
    return l + to_ufixed (r, r(r'low)'high, 0);
  end function "+";

  function "+" (
    l : ufixed_vector;
    r : integer_vector)
    return ufixed_vector is
  begin
    return l + to_ufixed (r, l(l'low)'high, 0);
  end function "+";

  function "+" (
    l : ufixed_vector;
    r : real_vector)
    return ufixed_vector is
  begin
    return l + to_ufixed (r, l(l'low)'high, l(l'low)'low);
  end function "+";

  function "+" (
    l : unsigned_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return to_ufixed(l, l(l'low)'high, 0) + r;
  end function "+";

  function "+" (
    l : integer_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return to_ufixed(l, r(r'low)'high, 0) + r;
  end function "+";

  function "+" (
    l : real_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return to_ufixed(l, r(r'low)'high, r(r'low)'low) + r;
  end function "+";

  function "-" (
    l : ufixed_matrix;
    r : unsigned_matrix)
    return ufixed_matrix is
  begin
    return l - to_ufixed (r, r(r'low(1), r'low(2))'high, 0);
  end function "-";

  function "-" (
    l : ufixed_matrix;
    r : integer_matrix)
    return ufixed_matrix is
  begin
    return l - to_ufixed (r, l(l'low(1), l'low(2))'high, 0);
  end function "-";

  function "-" (
    l : ufixed_matrix;
    r : real_matrix)
    return ufixed_matrix is
  begin
    return l - to_ufixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low);
  end function "-";

  function "-" (
    l : unsigned_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed(l, l(l'low(1), l'low(2))'high, 0) - r;
  end function "-";

  function "-" (
    l : integer_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed(l, r(r'low(1), r'low(2))'high, 0) - r;
  end function "-";

  function "-" (
    l : real_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return to_ufixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low) - r;
  end function "-";

  function "-" (
    l : ufixed_vector;
    r : unsigned_vector)
    return ufixed_vector is
  begin
    return l - to_ufixed (r, r(r'low)'high, 0);
  end function "-";

  function "-" (
    l : ufixed_vector;
    r : integer_vector)
    return ufixed_vector is
  begin
    return l - to_ufixed (r, l(l'low)'high, 0);
  end function "-";

  function "-" (
    l : ufixed_vector;
    r : real_vector)
    return ufixed_vector is
  begin
    return l - to_ufixed (r, l(l'low)'high, l(l'low)'low);
  end function "-";

  function "-" (
    l : unsigned_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return to_ufixed(l, l(l'low)'high, 0) - r;
  end function "-";

  function "-" (
    l : integer_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return to_ufixed(l, r(r'low)'high, 0) - r;
  end function "-";

  function "-" (
    l : real_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return to_ufixed(l, r(r'low)'high, r(r'low)'low) - r;
  end function "-";

  function times (
    l : ufixed_matrix;
    r : unsigned_matrix)
    return ufixed_matrix is
  begin
    return times (l, to_ufixed (r, r(r'low(1), r'low(2))'high, 0));
  end function times;

  function times (
    l : ufixed_matrix;
    r : integer_matrix)
    return ufixed_matrix is
  begin
    return times (l, to_ufixed (r, l(l'low(1), l'low(2))'high, 0));
  end function times;

  function times (
    l : ufixed_matrix;
    r : real_matrix)
    return ufixed_matrix is
  begin
    return times (l, to_ufixed (r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low));
  end function times;

  function times (
    l : unsigned_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return times (to_ufixed(l, l(l'low(1), l'low(2))'high, 0), r);
  end function times;

  function times (
    l : integer_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return times (to_ufixed(l, r(r'low(1), r'low(2))'high, 0), r);
  end function times;

  function times (
    l : real_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return times (to_ufixed(l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low), r);
  end function times;

  function times (
    l : ufixed_vector;
    r : unsigned_vector)
    return ufixed_vector is
  begin
    return times (l, to_ufixed (r, r(r'low)'high, 0));
  end function times;

  function times (
    l : ufixed_vector;
    r : integer_vector)
    return ufixed_vector is
  begin
    return times (l, to_ufixed (r, l(l'low)'high, 0));
  end function times;

  function times (
    l : ufixed_vector;
    r : real_vector)
    return ufixed_vector is
  begin
    return times (l, to_ufixed (r, l(l'low)'high, l(l'low)'low));
  end function times;

  function times (
    l : unsigned_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return times (to_ufixed(l, l(l'low)'high, 0), r);
  end function times;

  function times (
    l : integer_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return times (to_ufixed(l, r(r'low)'high, 0), r);
  end function times;

  function times (
    l : real_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return times (to_ufixed(l, r(r'low)'high, r(r'low)'low), r);
  end function times;

  function rdivide (
    l : ufixed_matrix;
    r : unsigned_matrix)
    return ufixed_matrix is
  begin
    return rdivide (l, to_ufixed(r, r(r'low(1), r'low(2))'high, 0));
  end function rdivide;

  function rdivide (
    l : ufixed_matrix;
    r : integer_matrix)
    return ufixed_matrix is
  begin
    return rdivide (l, to_ufixed(r, l(l'low(1), l'low(2))'high, 0));
  end function rdivide;

  function rdivide (
    l : ufixed_matrix;
    r : real_matrix)
    return ufixed_matrix is
  begin
    return rdivide (l, to_ufixed(r, l(l'low(1), l'low(2))'high, l(l'low(1), l'low(2))'low));
  end function rdivide;

  function rdivide (
    l : unsigned_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return rdivide (to_ufixed (l, l(l'low(1), l'low(2))'high, 0), r);
  end function rdivide;

  function rdivide (
    l : integer_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return rdivide (to_ufixed (l, r(r'low(1), r'low(2))'high, 0), r);
  end function rdivide;

  function rdivide (
    l : real_matrix;
    r : ufixed_matrix)
    return ufixed_matrix is
  begin
    return rdivide (to_ufixed (l, r(r'low(1), r'low(2))'high, r(r'low(1), r'low(2))'low), r);
  end function rdivide;

  function rdivide (
    l : ufixed_vector;
    r : unsigned_vector)
    return ufixed_vector is
  begin
    return rdivide (l, to_ufixed(r, r(r'low)'high, 0));
  end function rdivide;

  function rdivide (
    l : ufixed_vector;
    r : integer_vector)
    return ufixed_vector is
  begin
    return rdivide (l, to_ufixed(r, l(l'low)'high, 0));
  end function rdivide;

  function rdivide (
    l : ufixed_vector;
    r : real_vector)
    return ufixed_vector is
  begin
    return rdivide (l, to_ufixed(r, l(l'low)'high, l(l'low)'low));
  end function rdivide;

  function rdivide (
    l : unsigned_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return rdivide (to_ufixed (l, l(l'low)'high, 0), r);
  end function rdivide;

  function rdivide (
    l : integer_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return rdivide (to_ufixed (l, r(r'low)'high, 0), r);
  end function rdivide;

  function rdivide (
    l : real_vector;
    r : ufixed_vector)
    return ufixed_vector is
  begin
    return rdivide (to_ufixed (l, r(r'low)'high, r(r'low)'low), r);
  end function rdivide;

  -- Signed - overloaded for INTEGER, Unsigned

  function "*" (
    l : signed_matrix;
    r : integer_matrix)
    return signed_matrix is
  begin
    return l * to_signed (r, l(l'low(1), l'low(2))'length);
  end function "*";

  function "*" (
    l : signed_matrix;
    r : unsigned_matrix)
    return signed_matrix is
  begin
    return l * to_signed (r, r(r'low(1), r'low(2))'length+1);
  end function "*";

  function "*" (
    l : integer_matrix;
    r : signed_matrix)
    return signed_matrix is
  begin
    return to_signed (l, r(r'low(1), r'low(2))'length) * r;
  end function "*";

  function "*" (
    l : unsigned_matrix;
    r : signed_matrix)
    return signed_matrix is
  begin
    return to_signed (l, l(l'low(1), l'low(2))'length+1) * r;
  end function "*";

  function "*" (
    l : signed_matrix;
    r : integer_vector)
    return signed_matrix is
  begin
    return l * to_signed (r, l(l'low(1), l'low(2))'length);
  end function "*";

  function "*" (
    l : signed_matrix;
    r : unsigned_vector)
    return signed_matrix is
  begin
    return l * to_signed (r, r(r'low)'length+1);
  end function "*";

  function "*" (
    l : integer_matrix;
    r : signed_vector)
    return signed_matrix is
  begin
    return to_signed (l, r(r'low)'length) * r;
  end function "*";

  function "*" (
    l : unsigned_matrix;
    r : signed_vector)
    return signed_matrix is
  begin
    return to_signed (l, l(l'low(1), l'low(2))'length+1) * r;
  end function "*";

  function "*" (
    l : signed_vector;
    r : integer_matrix)
    return signed_vector is
  begin
    return l * to_signed (r, l(l'low)'length);
  end function "*";

  function "*" (
    l : signed_vector;
    r : unsigned_matrix)
    return signed_vector is
  begin
    return l * to_signed (r, r(r'low(1), r'low(2))'length+1);
  end function "*";

  function "*" (
    l : integer_vector;
    r : signed_matrix)
    return signed_vector is
  begin
    return to_signed (l, r(r'low(1), r'low(2))'length) * r;
  end function "*";

  function "*" (
    l : unsigned_vector;
    r : signed_matrix)
    return signed_vector is
  begin
    return to_signed (l, l(l'low)'length+1) * r;
  end function "*";

  function "*" (
    l : INTEGER;
    r : signed_matrix)
    return signed_matrix is
  begin
    return to_signed (l, r(r'low(1), r'low(2))'length) * r;
  end function "*";

  function "*" (
    l : UNSIGNED;
    r : signed_matrix)
    return signed_matrix is
  begin
    return SIGNED ('0' & l) * r;
  end function "*";

  function "*" (
    l : signed_matrix;
    r : INTEGER)
    return signed_matrix is
  begin
    return l * to_signed (r, l(l'low(1), l'low(2))'length);
  end function "*";

  function "*" (
    l : signed_matrix;
    r : UNSIGNED)
    return signed_matrix is
  begin
    return l * SIGNED ('0' & r);
  end function "*";

  function "*" (
    l : INTEGER;
    r : signed_vector)
    return signed_vector is
  begin
    return to_signed (l, r(r'low)'length) * r;
  end function "*";

  function "*" (
    l : UNSIGNED;
    r : signed_vector)
    return signed_vector is
  begin
    return SIGNED ('0' & l) * r;
  end function "*";

  function "*" (
    l : signed_vector;
    r : INTEGER)
    return signed_vector is
  begin
    return l * to_signed (r, l(l'low)'length);
  end function "*";

  function "*" (
    l : signed_vector;
    r : UNSIGNED)
    return signed_vector is
  begin
    return l * SIGNED ('0' & r);
  end function "*";

  function "+" (
    l : signed_matrix;
    r : integer_matrix)
    return signed_matrix is
  begin
    return l + to_signed (r, l(l'low(1), l'low(2))'length);
  end function "+";

  function "+" (
    l : signed_matrix;
    r : unsigned_matrix)
    return signed_matrix is
  begin
    return l + to_signed (r, r(r'low(1), r'low(2))'length+1);
  end function "+";

  function "+" (
    l : integer_matrix;
    r : signed_matrix)
    return signed_matrix is
  begin
    return to_signed (l, r(r'low(1), r'low(2))'length) + r;
  end function "+";

  function "+" (
    l : unsigned_matrix;
    r : signed_matrix)
    return signed_matrix is
  begin
    return to_signed (l, l(l'low(1), l'low(2))'length+1) + r;
  end function "+";

  function "+" (
    l : signed_vector;
    r : integer_vector)
    return signed_vector is
  begin
    return l + to_signed (r, l(l'low)'length);
  end function "+";

  function "+" (
    l : signed_vector;
    r : unsigned_vector)
    return signed_vector is
  begin
    return l + to_signed (r, r(r'low)'length+1);
  end function "+";

  function "+" (
    l : integer_vector;
    r : signed_vector)
    return signed_vector is
  begin
    return to_signed (l, r(r'low)'length) + r;
  end function "+";

  function "+" (
    l : unsigned_vector;
    r : signed_vector)
    return signed_vector is
  begin
    return to_signed (l, l(l'low)'length+1) + r;
  end function "+";

  function "-" (
    l : signed_matrix;
    r : integer_matrix)
    return signed_matrix is
  begin
    return l - to_signed (r, l(l'low(1), l'low(2))'length);
  end function "-";

  function "-" (
    l : signed_matrix;
    r : unsigned_matrix)
    return signed_matrix is
  begin
    return l - to_signed (r, r(r'low(1), r'low(2))'length+1);
  end function "-";

  function "-" (
    l : integer_matrix;
    r : signed_matrix)
    return signed_matrix is
  begin
    return to_signed (l, r(r'low(1), r'low(2))'length) - r;
  end function "-";

  function "-" (
    l : unsigned_matrix;
    r : signed_matrix)
    return signed_matrix is
  begin
    return to_signed (l, l(l'low(1), l'low(2))'length+1) - r;
  end function "-";

  function "-" (
    l : signed_vector;
    r : integer_vector)
    return signed_vector is
  begin
    return l - to_signed (r, l(l'low)'length);
  end function "-";

  function "-" (
    l : signed_vector;
    r : unsigned_vector)
    return signed_vector is
  begin
    return l - to_signed (r, r(r'low)'length+1);
  end function "-";

  function "-" (
    l : integer_vector;
    r : signed_vector)
    return signed_vector is
  begin
    return to_signed (l, r(r'low)'length) - r;
  end function "-";

  function "-" (
    l : unsigned_vector;
    r : signed_vector)
    return signed_vector is
  begin
    return to_signed (l, l(l'low)'length+1) - r;
  end function "-";

  function times (
    l : signed_matrix;
    r : integer_matrix)
    return signed_matrix is
  begin
    return times (l, to_signed (r, l(l'low(1), l'low(2))'length));
  end function times;

  function times (
    l : signed_matrix;
    r : unsigned_matrix)
    return signed_matrix is
  begin
    return times (l, to_signed (r, r(r'low(1), r'low(2))'length+1));
  end function times;

  function times (
    l : integer_matrix;
    r : signed_matrix)
    return signed_matrix is
  begin
    return times (to_signed (l, r(r'low(1), r'low(2))'length), r);
  end function times;

  function times (
    l : unsigned_matrix;
    r : signed_matrix)
    return signed_matrix is
  begin
    return times (to_signed (l, l(l'low(1), l'low(2))'length+1), r);
  end function times;

  function times (
    l : signed_vector;
    r : integer_vector)
    return signed_vector is
  begin
    return times (l, to_signed (r, l(l'low)'length));
  end function times;

  function times (
    l : signed_vector;
    r : unsigned_vector)
    return signed_vector is
  begin
    return times (l, to_signed (r, r(r'low)'length+1));
  end function times;

  function times (
    l : integer_vector;
    r : signed_vector)
    return signed_vector is
  begin
    return times (to_signed (l, r(r'low)'length), r);
  end function times;

  function times (
    l : unsigned_vector;
    r : signed_vector)
    return signed_vector is
  begin
    return times (to_signed (l, l(l'low)'length+1), r);
  end function times;


  -- unsigned - overload for INTEGER
  function "*" (
    l : unsigned_matrix;
    r : integer_matrix)
    return unsigned_matrix is
  begin
    return l * to_unsigned (r, l(l'low(1), l'low(2))'length);
  end function "*";

  function "*" (
    l : integer_matrix;
    r : unsigned_matrix)
    return unsigned_matrix is
  begin
    return to_unsigned (l, r(r'low(1), r'low(2))'length) * r;
  end function "*";

  function "*" (
    l : unsigned_matrix;
    r : integer_vector)
    return unsigned_matrix is
  begin
    return l * to_unsigned (r, l(l'low(1), l'low(2))'length);
  end function "*";

  function "*" (
    l : integer_matrix;
    r : unsigned_vector)
    return unsigned_matrix is
  begin
    return to_unsigned (l, r(r'low)'length) * r;
  end function "*";

  function "*" (
    l : unsigned_vector;
    r : integer_matrix)
    return unsigned_vector is
  begin
    return l * to_unsigned (r, l(l'low)'length);
  end function "*";

  function "*" (
    l : integer_vector;
    r : unsigned_matrix)
    return unsigned_vector is
  begin
    return to_unsigned (l, r(r'low(1), r'low(2))'length) * r;
  end function "*";

  function "*" (
    l : INTEGER;
    r : unsigned_matrix)
    return unsigned_matrix is
  begin
    return to_unsigned (l, r(r'low(1), r'low(2))'length) * r;
  end function "*";

  function "*" (
    l : unsigned_matrix;
    r : INTEGER)
    return unsigned_matrix is
  begin
    return l * to_unsigned (r, l(l'low(1), l'low(2))'length);
  end function "*";

  function "*" (
    l : INTEGER;
    r : unsigned_vector)
    return unsigned_vector is
  begin
    return to_unsigned (l, r(r'low)'length) * r;
  end function "*";

  function "*" (
    l : unsigned_vector;
    r : INTEGER)
    return unsigned_vector is
  begin
    return l * to_unsigned (r, l(l'low)'length);
  end function "*";

  function "+" (
    l : unsigned_matrix;
    r : integer_matrix)
    return unsigned_matrix is
  begin
    return l + to_unsigned (r, l(l'low(1), l'low(2))'length);
  end function "+";

  function "+" (
    l : integer_matrix;
    r : unsigned_matrix)
    return unsigned_matrix is
  begin
    return to_unsigned (l, r(r'low(1), r'low(2))'length) + r;
  end function "+";

  function "+" (
    l : unsigned_vector;
    r : integer_vector)
    return unsigned_vector is
  begin
    return l + to_unsigned (r, l(l'low)'length);
  end function "+";

  function "+" (
    l : integer_vector;
    r : unsigned_vector)
    return unsigned_vector is
  begin
    return to_unsigned (l, r(r'low)'length) + r;
  end function "+";

  function "-" (
    l : unsigned_matrix;
    r : integer_matrix)
    return unsigned_matrix is
  begin
    return l - to_unsigned (r, l(l'low(1), l'low(2))'length);
  end function "-";

  function "-" (
    l : integer_matrix;
    r : unsigned_matrix)
    return unsigned_matrix is
  begin
    return to_unsigned (l, r(r'low(1), r'low(2))'length) - r;
  end function "-";

  function "-" (
    l : unsigned_vector;
    r : integer_vector)
    return unsigned_vector is
  begin
    return l - to_unsigned (r, l(l'low)'length);
  end function "-";

  function "-" (
    l : integer_vector;
    r : unsigned_vector)
    return unsigned_vector is
  begin
    return to_unsigned (l, r(r'low)'length) - r;
  end function "-";

  function times (
    l : unsigned_matrix;
    r : integer_matrix)
    return unsigned_matrix is
  begin
    return times (l, to_unsigned (r, l(l'low(1), l'low(2))'length));
  end function times;

  function times (
    l : integer_matrix;
    r : unsigned_matrix)
    return unsigned_matrix is
  begin
    return times (to_unsigned (l, r(r'low(1), r'low(2))'length), r);
  end function times;

  function times (
    l : unsigned_vector;
    r : integer_vector)
    return unsigned_vector is
  begin
    return times (l, to_unsigned (r, l(l'low)'length));
  end function times;

  function times (
    l : integer_vector;
    r : unsigned_vector)
    return unsigned_vector is
  begin
    return times (to_unsigned (l, r(r'low)'length), r);
  end function times;

  -----------------------------------------------------------------------------
  -- Textio section
  -----------------------------------------------------------------------------
-- rtl_synthesis off
  alias SWRITE is WRITE [LINE, STRING, SIDE, WIDTH];

  function to_string (
    value : ufixed_vector)
    return STRING is
    variable L : LINE;
  begin
    for i in value'range loop
      write (L, to_string (value(i)));
      swrite (L, " ");
    end loop;  -- i
    return L.all;
  end function to_string;

  function to_string (
    value : ufixed_matrix)
    return STRING is
    variable L : LINE;                  -- output line
  begin
    for i in value'range(1) loop
      for j in value'range(2) loop
        write (L, to_string (value (i, j)));
        swrite (L, " ");
      end loop;  -- j
      if i /= value'high(1) then
        write (L, CR);
      end if;
    end loop;  -- i
    return L.all;
  end function to_string;

  -- Read and Write functions
  constant NBSP : CHARACTER := CHARACTER'val(160);  -- space character
  -- purpose: Skips white space or punctuation
  procedure skip_whitespace_or_pc (
    L : inout LINE) is
    variable readOk : BOOLEAN;
    variable c      : CHARACTER;
  begin
    while L /= null and L.all'length /= 0 loop
      if (L.all(1) = ' ' or L.all(1) = NBSP or L.all(1) = HT or L.all(1) = CR
          or L.all(1) = '(' or L.all(1) = ')' or L.all(1) = ',') then
        read (l, c, readOk);
      else
        exit;
      end if;
    end loop;
  end procedure skip_whitespace_or_pc;

  -- ufixed
  procedure write (
    L     : inout LINE;
    VALUE : in    ufixed_vector) is
  begin
    for i in value'range loop
      write (L, to_string (value(i)));
      swrite (L, " ");
    end loop;  -- i
  end procedure write;
  
  procedure write (
    L     : inout LINE;
    VALUE : in    ufixed_matrix) is
  begin
    for i in value'range(1) loop
      for j in value'range(2) loop
        write (L, to_string (value (i, j)));
        swrite (L, " ");
      end loop;  -- j
      if i /= value'high(1) then
        write (L, CR);
      end if;
    end loop;  -- i
  end procedure write;

  procedure READ(
    L     : inout LINE;
    VALUE : out   ufixed_vector) is
  begin
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i));
    end loop;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   ufixed_matrix) is
  begin
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j));
      end loop;
    end loop;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   ufixed_vector;
    GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i), isgood);
      wasgood := isgood and wasgood;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   ufixed_matrix;
    GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j), isgood);
        wasgood := isgood and wasgood;
      end loop;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  -- sfixed
  procedure write (
    L     : inout LINE;
    VALUE : in    sfixed_vector) is
  begin
    for i in value'range loop
      write (L, to_string (value(i)));
      swrite (L, " ");
    end loop;  -- i
  end procedure write;
  
  procedure write (
    L     : inout LINE;
    VALUE : in    sfixed_matrix) is
  begin
    for i in value'range(1) loop
      for j in value'range(2) loop
        write (L, to_string (value (i, j)));
        swrite (L, " ");
      end loop;  -- j
      if i /= value'high(1) then
        write (L, CR);
      end if;
    end loop;  -- i
  end procedure write;

  procedure READ(
    L     : inout LINE;
    VALUE : out   sfixed_vector) is
  begin
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i));
    end loop;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   sfixed_matrix) is
  begin
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j));
      end loop;
    end loop;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   sfixed_vector;
    GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i), isgood);
      wasgood := isgood and wasgood;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   sfixed_matrix;
    GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j), isgood);
        wasgood := isgood and wasgood;
      end loop;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  -- unsigned
  procedure write (
    L     : inout LINE;
    VALUE : in    unsigned_vector) is
  begin
    for i in value'range loop
      write (L, to_string (value(i)));
      swrite (L, " ");
    end loop;  -- i
  end procedure write;
  
  procedure write (
    L     : inout LINE;
    VALUE : in    unsigned_matrix) is
  begin
    for i in value'range(1) loop
      for j in value'range(2) loop
        write (L, to_string (value (i, j)));
        swrite (L, " ");
      end loop;  -- j
      if i /= value'high(1) then
        write (L, CR);
      end if;
    end loop;  -- i  
  end procedure write;

  procedure READ(
    L     : inout LINE;
    VALUE : out   unsigned_vector) is
  begin
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i));
    end loop;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   unsigned_matrix) is
  begin
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j));
      end loop;
    end loop;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   unsigned_vector;
    GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i), isgood);
      wasgood := isgood and wasgood;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   unsigned_matrix;
    GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j), isgood);
        wasgood := isgood and wasgood;
      end loop;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  -- signed
  procedure write (
    L     : inout LINE;
    VALUE : in    signed_vector) is
  begin
    for i in value'range loop
      write (L, to_string (value(i)));
      swrite (L, " ");
    end loop;  -- i
  end procedure write;
  
  procedure write (
    L     : inout LINE;
    VALUE : in    signed_matrix) is
  begin
    for i in value'range(1) loop
      for j in value'range(2) loop
        write (L, to_string (value (i, j)));
        swrite (L, " ");
      end loop;  -- j
      if i /= value'high(1) then
        write (L, CR);
      end if;
    end loop;  -- i 
  end procedure write;

  procedure READ(
    L     : inout LINE;
    VALUE : out   signed_vector) is
  begin
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i));
    end loop;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   signed_matrix) is
  begin
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j));
      end loop;
    end loop;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   signed_vector;
    GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range loop
      skip_whitespace_or_pc(l);
      READ (L, VALUE(i), isgood);
      wasgood := isgood and wasgood;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  procedure READ(
    L     : inout LINE;
    VALUE : out   signed_matrix;
    GOOD  : out   BOOLEAN) is
    variable isgood, wasgood : BOOLEAN;
  begin
    wasgood := true;
    for i in VALUE'range(1) loop
      for j in VALUE'range(2) loop
        skip_whitespace_or_pc(l);
        READ (L, VALUE(i, j), isgood);
        wasgood := isgood and wasgood;
      end loop;
    end loop;
    GOOD := wasgood;
  end procedure READ;

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in ufixed_matrix;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin  -- print_matrix
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
        write (L, to_string (arg (i, j)) &
               " (" & REAL'image (to_real(arg (i, j))) & ") ");
      end loop;  -- j
      writeline (output, L);
    end loop;  -- i
  end procedure print_matrix;

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in ufixed_vector;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin  -- print_vector
    for i in arg'range loop
      if index then
        write (L, STRING'("(" & INTEGER'image(i) & ") = "));
      end if;
      write (L, to_string (arg (i)) &
             " (" & REAL'image (to_real(arg (i))) & ") ");
    end loop;  -- i
    writeline (output, L);
  end procedure print_vector;

  function to_string (
    value : sfixed_vector)
    return STRING is
    variable L : LINE;
  begin
    for i in value'range loop
      write (L, to_string (value(i)));
      swrite (L, " ");
    end loop;  -- i
    return L.all;
  end function to_string;

  function to_string (
    value : sfixed_matrix)
    return STRING is
    variable L : LINE;                  -- output line
  begin
    for i in value'range(1) loop
      for j in value'range(2) loop
        write (L, to_string (value (i, j)));
        swrite (L, " ");
      end loop;  -- j
      if i /= value'high(1) then
        write (L, CR);
      end if;
    end loop;  -- i
    return L.all;
  end function to_string;


  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in sfixed_matrix;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin  -- print_matrix
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
        write (L, to_string (arg (i, j)) &
               " (" & REAL'image (to_real(arg (i, j))) & ") ");
      end loop;  -- j
      writeline (output, L);
    end loop;  -- i
  end procedure print_matrix;

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in sfixed_vector;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin  -- print_vector
    for i in arg'range loop
      if index then
        write (L, STRING'("(" & INTEGER'image(i) & ") = "));
      end if;
      write (L, to_string (arg (i)) &
             " (" & REAL'image (to_real(arg (i))) & ") ");
    end loop;  -- i
    writeline (output, L);
  end procedure print_vector;

  function to_string (
    value : unsigned_vector)
    return STRING is
    variable L : LINE;
  begin
    for i in value'range loop
      write (L, to_string (value(i)));
      swrite (L, " ");
    end loop;  -- i
    return L.all;
  end function to_string;

  function to_string (
    value : unsigned_matrix)
    return STRING is
    variable L : LINE;                  -- output line
  begin
    for i in value'range(1) loop
      for j in value'range(2) loop
        write (L, to_string (value (i, j)));
        swrite (L, " ");
      end loop;  -- j
      if i /= value'high(1) then
        write (L, CR);
      end if;
    end loop;  -- i
    return L.all;
  end function to_string;

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in unsigned_matrix;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin  -- print_matrix
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
        write (L, to_string (arg (i, j)) &
               " (" & INTEGER'image (to_integer(arg (i, j))) & ") ");
      end loop;  -- j
      writeline (output, L);
    end loop;  -- i
  end procedure print_matrix;

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in unsigned_vector;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin  -- print_vector
    for i in arg'range loop
      if index then
        write (L, STRING'("(" & INTEGER'image(i) & ") = "));
      end if;
      write (L, to_string (arg (i)) &
             " (" & INTEGER'image (to_integer(arg (i))) & ") ");
    end loop;  -- i
    writeline (output, L);
  end procedure print_vector;

  function to_string (
    value : signed_vector)
    return STRING is
    variable L : LINE;
  begin
    for i in value'range loop
      write (L, to_string (value(i)));
      swrite (L, " ");
    end loop;  -- i
    return L.all;
  end function to_string;

  function to_string (
    value : signed_matrix)
    return STRING is
    variable L : LINE;                  -- output line
  begin
    for i in value'range(1) loop
      for j in value'range(2) loop
        write (L, to_string (value (i, j)));
        swrite (L, " ");
      end loop;  -- j
      if i /= value'high(1) then
        write (L, CR);
      end if;
    end loop;  -- i
    return L.all;
  end function to_string;

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in signed_matrix;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin  -- print_matrix
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
        write (L, to_string (arg (i, j)) &
               " (" & INTEGER'image (to_integer(arg (i, j))) & ") ");
      end loop;  -- j
      writeline (output, L);
    end loop;  -- i
  end procedure print_matrix;

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in signed_vector;
    index : in BOOLEAN := false) is
    variable L : LINE;                  -- output line
  begin  -- print_vector
    for i in arg'range loop
      if index then
        write (L, STRING'("(" & INTEGER'image(i) & ") = "));
      end if;
      write (L, to_string (arg (i)) &
             " (" & INTEGER'image (to_integer(arg (i))) & ") ");
    end loop;  -- i
    writeline (output, L);
  end procedure print_vector;
-- rtl_synthesis on

end package body fixed_matrix_pkg;
