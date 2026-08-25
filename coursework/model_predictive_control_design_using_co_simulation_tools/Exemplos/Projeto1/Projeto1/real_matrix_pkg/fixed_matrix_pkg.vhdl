-------------------------------------------------------------------------------
-- Title      : Matrix Math package for synthesizable types
-- Project    : IEEE 1076.1-201x
-------------------------------------------------------------------------------
-- File       : fixed_matrix_pkg.vhdl
-- Author     : David Bishop  <dbishop@vhdl.org>
-- Company    : 
-- Created    : 2010-04-15
-- Last update: 2011-02-04
-- Platform   : 
-- Standard   : VHDL'2008
-------------------------------------------------------------------------------
-- Description: Matrix math package for types ufixed, sfixed, unsigned, signed
-------------------------------------------------------------------------------
-- Copyright (c) 2011
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2010-04-15  1.0      l435385 Created
-------------------------------------------------------------------------------

use std.textio.all;
library ieee;
--%VHDL2008% library ieee_proposed;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use work.real_matrix_pkg.all;

-------------------------------------------------------------------------------
-- Package generics
-- To use package generics with the package, uncomment the following code
-- package fixed_matrix_pkg is NEW.fixed_generic_matrix_pkg
--   generic map (
--     ufixed_high   => 15;
--     ufixed_low    => -16;
--     sfixed_high   => 15;
--     sfixed_low    => -16;
--     unsigned_high => 15;
--     signed_high   => 15;
--     no_warning    => false;
--     fixed_pkg     => IEEE.fixed_pkg
-- );
--
-- Place it in a new file.
-- replace "fixed_matrix_pkg" with "fixed_generic_matrix_pkg" in this
-- file and in the body. and uncomment the "--VHDL2008" comments,
-- and remove the key work "constant" from the generic clause.
-------------------------------------------------------------------------------

package fixed_matrix_pkg is
--VHDL2008  generic (
  constant ufixed_matrix_high   : INTEGER := 15;
  constant ufixed_matrix_low    : INTEGER := -16;
  constant sfixed_matrix_high   : INTEGER := 15;
  constant sfixed_matrix_low    : INTEGER := -16;
  constant unsigned_matrix_high : NATURAL := 15;
  constant signed_matrix_high   : NATURAL := 15;
  constant no_warning           : BOOLEAN := false;
--VHDL2008    package fixed_pkg is new IEEE.fixed_generic_pkg
--VHDL2008                           generic map (<>) );

  -- %%% Because you can't have an unconstrained array of unconstrained arrays
  -- you have to define the width of the base type.   All of the functions
  -- will assume a variable width.  VHDL-2008 fixes this restriction.
  subtype ufixedr is UNRESOLVED_ufixed (ufixed_matrix_high downto ufixed_matrix_low);
  subtype sfixedr is UNRESOLVED_sfixed (sfixed_matrix_high downto sfixed_matrix_low);
--VHDL2008  subtype unsignedr is UNRESOLVED_UNSIGNED (unsigned_high downto 0);
--VHDL2008  subtype signedr is UNRESOLVED_SIGNED (signed_high downto 0);
  subtype unsignedr is UNSIGNED (unsigned_matrix_high downto 0);  -- Delete
  subtype signedr is SIGNED (signed_matrix_high downto 0);        -- Delete

  -- Define the base types
  type ufixed_matrix is array (NATURAL range <>, NATURAL range <>) of ufixedr;
  type ufixed_vector is array (NATURAL range <>) of ufixedr;
  type sfixed_matrix is array (NATURAL range <>, NATURAL range <>) of sfixedr;
  type sfixed_vector is array (NATURAL range <>) of sfixedr;
  type unsigned_matrix is array (NATURAL range <>, NATURAL range <>) of unsignedr;
  type unsigned_vector is array (NATURAL range <>) of unsignedr;
  type signed_matrix is array (NATURAL range <>, NATURAL range <>) of signedr;
  type signed_vector is array (NATURAL range <>) of signedr;

  constant ufixed_one : ufixed (1 downto 0) := "01";  -- 1.0
  constant sfixed_one : sfixed (1 downto 0) := "01";  -- 1.0
  -----------------------------------------------------------------------------
  -- operators
  -----------------------------------------------------------------------------

  function "*" (l, r : ufixed_matrix) return ufixed_matrix;
  function "*" (l    : ufixed_matrix; r : ufixed_vector) return ufixed_matrix;
  function "*" (l    : ufixed_vector; r : ufixed_matrix) return ufixed_vector;
  function "*" (l    : ufixed; r : ufixed_matrix) return ufixed_matrix;
  function "*" (l    : ufixed_matrix; r : ufixed) return ufixed_matrix;
  function "*" (l    : ufixed; r : ufixed_vector) return ufixed_vector;
  function "*" (l    : ufixed_vector; r : ufixed) return ufixed_vector;

  function "*" (l, r : sfixed_matrix) return sfixed_matrix;
  function "*" (l    : sfixed_matrix; r : sfixed_vector) return sfixed_matrix;
  function "*" (l    : sfixed_vector; r : sfixed_matrix) return sfixed_vector;
  function "*" (l    : sfixed; r : sfixed_matrix) return sfixed_matrix;
  function "*" (l    : sfixed_matrix; r : sfixed) return sfixed_matrix;
  function "*" (l    : sfixed; r : sfixed_vector) return sfixed_vector;
  function "*" (l    : sfixed_vector; r : sfixed) return sfixed_vector;

  function "*" (l, r : unsigned_matrix) return unsigned_matrix;
  function "*" (l    : unsigned_matrix; r : unsigned_vector) return unsigned_matrix;
  function "*" (l    : unsigned_vector; r : unsigned_matrix) return unsigned_vector;
  function "*" (l    : UNSIGNED; r : unsigned_matrix) return unsigned_matrix;
  function "*" (l    : unsigned_matrix; r : UNSIGNED) return unsigned_matrix;
  function "*" (l    : UNSIGNED; r : unsigned_vector) return unsigned_vector;
  function "*" (l    : unsigned_vector; r : UNSIGNED) return unsigned_vector;

  function "*" (l, r : signed_matrix) return signed_matrix;
  function "*" (l    : signed_matrix; r : signed_vector) return signed_matrix;
  function "*" (l    : signed_vector; r : signed_matrix) return signed_vector;
  function "*" (l    : SIGNED; r : signed_matrix) return signed_matrix;
  function "*" (l    : signed_matrix; r : SIGNED) return signed_matrix;
  function "*" (l    : SIGNED; r : signed_vector) return signed_vector;
  function "*" (l    : signed_vector; r : SIGNED) return signed_vector;

  function "/" (l : ufixed_matrix; r : ufixed) return ufixed_matrix;
  function "/" (l : ufixed_vector; r : ufixed) return ufixed_vector;
  function "/" (l : sfixed_matrix; r : sfixed) return sfixed_matrix;
  function "/" (l : sfixed_vector; r : sfixed) return sfixed_vector;

  function "+" (l, r : ufixed_matrix) return ufixed_matrix;
  function "+" (l, r : ufixed_vector) return ufixed_vector;
  function "+" (l, r : sfixed_matrix) return sfixed_matrix;
  function "+" (l, r : sfixed_vector) return sfixed_vector;
  function "+" (l, r : unsigned_matrix) return unsigned_matrix;
  function "+" (l, r : unsigned_vector) return unsigned_vector;
  function "+" (l, r : signed_matrix) return signed_matrix;
  function "+" (l, r : signed_vector) return signed_vector;

  function "-" (l, r : ufixed_matrix) return ufixed_matrix;
  function "-" (l, r : ufixed_vector) return ufixed_vector;
  function "-" (l, r : sfixed_matrix) return sfixed_matrix;
  function "-" (l, r : sfixed_vector) return sfixed_vector;
  function "-" (l, r : unsigned_matrix) return unsigned_matrix;
  function "-" (l, r : unsigned_vector) return unsigned_vector;
  function "-" (l, r : signed_matrix) return signed_matrix;
  function "-" (l, r : signed_vector) return signed_vector;

  function "-" (arg : sfixed_matrix) return sfixed_matrix;
  function "-" (arg : sfixed_vector) return sfixed_vector;
  function "-" (arg : signed_matrix) return signed_matrix;
  function "-" (arg : signed_vector) return signed_vector;

  -- Absolute value
  function "abs" (arg : sfixed_matrix) return sfixed_matrix;
  function "abs" (arg : sfixed_vector) return sfixed_vector;
  function "abs" (arg : signed_matrix) return signed_matrix;
  function "abs" (arg : signed_vector) return signed_vector;

  -- Matlab .* operator
  function times (l, r : ufixed_matrix) return ufixed_matrix;
  function times (l, r : ufixed_vector) return ufixed_vector;
  function times (l, r : sfixed_matrix) return sfixed_matrix;
  function times (l, r : sfixed_vector) return sfixed_vector;
  function times (l, r : unsigned_matrix) return unsigned_matrix;
  function times (l, r : unsigned_vector) return unsigned_vector;
  function times (l, r : signed_matrix) return signed_matrix;
  function times (l, r : signed_vector) return signed_vector;

  -- Matlab ./ operator
  function rdivide (l, r : ufixed_matrix) return ufixed_matrix;
  function rdivide (l, r : ufixed_vector) return ufixed_vector;
  function rdivide (l, r : sfixed_matrix) return sfixed_matrix;
  function rdivide (l, r : sfixed_vector) return sfixed_vector;

  -- Matlab / operator (calls mrdivide)
  function "/" (l, r      : sfixed_matrix) return sfixed_matrix;
  function mrdivide (l, r : sfixed_matrix) return sfixed_matrix;

  -- Matlab \ operator
  function mldivide (l, r : sfixed_matrix) return sfixed_matrix;

  -- Raise a matrix to a power ^ operator
  -- %%% These two functions belong in "fixed_generic_pkg", and not here.
  function "**" (arg : ufixed; pow : INTEGER) return ufixed;
  function "**" (arg : sfixed; pow : INTEGER) return sfixed;
  function "**" (arg : ufixed_matrix; pow : NATURAL) return ufixed_matrix;
  function "**" (arg : sfixed_matrix; pow : INTEGER) return sfixed_matrix;
  function "**" (arg : unsigned_matrix; pow : NATURAL) return unsigned_matrix;
  function "**" (arg : signed_matrix; pow : NATURAL) return signed_matrix;

  -----------------------------------------------------------------------------
  -- Compare functions
  -----------------------------------------------------------------------------
  function "=" (l : ufixed_matrix; r : ufixed_vector) return BOOLEAN;
  function "=" (l : ufixed_vector; r : ufixed_matrix) return BOOLEAN;
  function "=" (l : sfixed_matrix; r : sfixed_vector) return BOOLEAN;
  function "=" (l : sfixed_vector; r : sfixed_matrix) return BOOLEAN;
  function "=" (l : unsigned_matrix; r : unsigned_vector) return BOOLEAN;
  function "=" (l : unsigned_vector; r : unsigned_matrix) return BOOLEAN;
  function "=" (l : signed_matrix; r : signed_vector) return BOOLEAN;
  function "=" (l : signed_vector; r : signed_matrix) return BOOLEAN;

  function "/=" (l : ufixed_matrix; r : ufixed_vector) return BOOLEAN;
  function "/=" (l : ufixed_vector; r : ufixed_matrix) return BOOLEAN;
  function "/=" (l : sfixed_matrix; r : sfixed_vector) return BOOLEAN;
  function "/=" (l : sfixed_vector; r : sfixed_matrix) return BOOLEAN;
  function "/=" (l : unsigned_matrix; r : unsigned_vector) return BOOLEAN;
  function "/=" (l : unsigned_vector; r : unsigned_matrix) return BOOLEAN;
  function "/=" (l : signed_matrix; r : signed_vector) return BOOLEAN;
  function "/=" (l : signed_vector; r : signed_matrix) return BOOLEAN;

  -----------------------------------------------------------------------------
  -- Algorithmic functions
  -----------------------------------------------------------------------------
  -- Sum the diagonal
  function trace (arg : ufixed_matrix) return ufixed;
  function trace (arg : sfixed_matrix) return sfixed;
  function trace (arg : unsigned_matrix) return UNSIGNED;
  function trace (arg : signed_matrix) return SIGNED;

  -- Sum a vector
  function sum (arg : ufixed_vector) return ufixed;
  function sum (arg : sfixed_vector) return sfixed;
  function sum (arg : unsigned_vector) return UNSIGNED;
  function sum (arg : signed_vector) return SIGNED;

  -- Sum a matrix and returns a vector
  function sum (
    arg          : ufixed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return ufixed_vector;
  function sum (
    arg          : sfixed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return sfixed_vector;
  function sum (
    arg          : unsigned_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return unsigned_vector;
  function sum (
    arg          : signed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return signed_vector;

  -- multiply a vector
  function prod (arg : ufixed_vector) return ufixed;

  -- multiply a matrix and returns a vector
  function prod (
    arg          : ufixed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return ufixed_vector;

  -- purpose: Dot product of two vectors
  function dot (l, r : ufixed_vector) return ufixed;

  -- multiply a vector
  function prod (arg : sfixed_vector) return sfixed;

  -- multiply a matrix and returns a vector
  function prod (
    arg          : sfixed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return sfixed_vector;

  -- purpose: Dot product of two vectors
  function dot (l, r : sfixed_vector) return sfixed;

  -- multiply a vector
  function prod (arg : unsigned_vector) return UNSIGNED;

  -- multiply a matrix and returns a vector
  function prod (
    arg          : unsigned_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return unsigned_vector;

  -- purpose: Dot product of two vectors
  function dot (l, r : unsigned_vector) return UNSIGNED;

  -- multiply a vector
  function prod (arg : signed_vector) return SIGNED;

  -- multiply a matrix and returns a vector
  function prod (
    arg          : signed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return signed_vector;

  -- purpose: Dot product of two vectors
  function dot (l, r : signed_vector) return SIGNED;

  -- Kronecker product.
  function kron (l, r : ufixed_matrix) return ufixed_matrix;

  -- purpose: cross product
  function cross (l, r : sfixed_matrix) return sfixed_matrix;
  function cross (l, r : sfixed_vector) return sfixed_vector;

  -- Kronecker product.
  function kron (l, r : sfixed_matrix) return sfixed_matrix;

  -- purpose: Finds the determinant of a matrix
  function det (arg : sfixed_matrix) return sfixed;

  -- purpose: cross product
  function cross (l, r : unsigned_matrix) return unsigned_matrix;
  function cross (l, r : unsigned_vector) return unsigned_vector;

  -- Kronecker product.
  function kron (l, r : unsigned_matrix) return unsigned_matrix;

  -- purpose: Finds the determinant of a matrix
  function det (arg : unsigned_matrix) return UNSIGNED;

  -- purpose: cross product
  function cross (l, r : signed_matrix) return signed_matrix;
  function cross (l, r : signed_vector) return signed_vector;

  -- Kronecker product.
  function kron (l, r : signed_matrix) return signed_matrix;

  -- purpose: Finds the determinant of a matrix
  function det (arg : signed_matrix) return SIGNED;

  -- purpose: Inverts a matrix
  function inv (arg : sfixed_matrix) return sfixed_matrix;

  -- Solve a linear equation
  function linsolve (l : sfixed_matrix; r : sfixed_vector)
    return sfixed_vector;

  -- Normalize a Matrix
  function normalize (
    arg           : ufixed_matrix;
    constant rval : ufixed := ufixed_one)
    return ufixed_matrix;
  function normalize (
    arg           : ufixed_vector;
    constant rval : ufixed := ufixed_one)
    return ufixed_vector;
  function normalize (
    arg           : sfixed_matrix;
    constant rval : sfixed := sfixed_one)
    return sfixed_matrix;
  function normalize (
    arg           : sfixed_vector;
    constant rval : sfixed := sfixed_one)
    return sfixed_vector;

  -- Evaluate the polynomial
  function polyval (l, r : sfixed_vector) return sfixed_vector;

  -----------------------------------------------------------------------------
  -- These functions manipulate the data in a matrix non mathematically
  -----------------------------------------------------------------------------

  -- Returns true if this is a null matrix
  function isempty (arg : ufixed_matrix) return BOOLEAN;
  function isempty (arg : ufixed_vector) return BOOLEAN;
  function isempty (arg : sfixed_matrix) return BOOLEAN;
  function isempty (arg : sfixed_vector) return BOOLEAN;
  function isempty (arg : unsigned_matrix) return BOOLEAN;
  function isempty (arg : unsigned_vector) return BOOLEAN;
  function isempty (arg : signed_matrix) return BOOLEAN;
  function isempty (arg : signed_vector) return BOOLEAN;

  -- purpose: Transpose a matrix (Similar to Matlab A' syntax)
  function transpose (arg : ufixed_matrix) return ufixed_matrix;
  function transpose (arg : ufixed_vector) return ufixed_matrix;
  function transpose (arg : ufixed_matrix) return ufixed_vector;
  function transpose (arg : sfixed_matrix) return sfixed_matrix;
  function transpose (arg : sfixed_vector) return sfixed_matrix;
  function transpose (arg : sfixed_matrix) return sfixed_vector;
  function transpose (arg : unsigned_matrix) return unsigned_matrix;
  function transpose (arg : unsigned_vector) return unsigned_matrix;
  function transpose (arg : unsigned_matrix) return unsigned_vector;
  function transpose (arg : signed_matrix) return signed_matrix;
  function transpose (arg : signed_vector) return signed_matrix;
  function transpose (arg : signed_matrix) return signed_vector;

  -- purpose: returns a matrix of zeros
  function zeros (rows, columns : NATURAL) return ufixed_matrix;
  function zeros (rows, columns : NATURAL) return ufixed_vector;
  function zeros (rows, columns : NATURAL) return sfixed_matrix;
  function zeros (rows, columns : NATURAL) return sfixed_vector;
  function zeros (rows, columns : NATURAL) return unsigned_matrix;
  function zeros (rows, columns : NATURAL) return unsigned_vector;
  function zeros (rows, columns : NATURAL) return signed_matrix;
  function zeros (rows, columns : NATURAL) return signed_vector;

  -- purpose: returns a matrix of ones
  function ones (rows, columns : NATURAL) return ufixed_matrix;
  function ones (rows, columns : NATURAL) return ufixed_vector;
  function ones (rows, columns : NATURAL) return sfixed_matrix;
  function ones (rows, columns : NATURAL) return sfixed_vector;
  function ones (rows, columns : NATURAL) return unsigned_matrix;
  function ones (rows, columns : NATURAL) return unsigned_vector;
  function ones (rows, columns : NATURAL) return signed_matrix;
  function ones (rows, columns : NATURAL) return signed_vector;

  -- purpose: Returns an identity matrix
  function eye (rows, columns : NATURAL) return ufixed_matrix;
  function eye (rows, columns : NATURAL) return sfixed_matrix;
  function eye (rows, columns : NATURAL) return unsigned_matrix;
  function eye (rows, columns : NATURAL) return signed_matrix;

  -- Puts two matrices together to form one
  function cat (
    dim  : POSITIVE;                    -- 1 = y, 2 = x
    l, r : ufixed_matrix)
    return ufixed_matrix;
  function horzcat (l, r : ufixed_matrix) return ufixed_matrix;
  function vertcat (l, r : ufixed_matrix) return ufixed_matrix;

  -- Rotate a matrix
  function flipdim (
    arg          : ufixed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return ufixed_matrix;
  function fliplr (arg : ufixed_matrix) return ufixed_matrix;
  function flipup (arg : ufixed_matrix) return ufixed_matrix;
  function fliplr (arg : ufixed_vector) return ufixed_vector;
  function rot90 (
    arg          : ufixed_matrix;
    constant dim : INTEGER := 1)        -- 1 = y, 2 = x
    return ufixed_matrix;

  -- Puts two matrices together to form one
  function cat (
    dim  : POSITIVE;                    -- 1 = y, 2 = x
    l, r : sfixed_matrix)
    return sfixed_matrix;
  function horzcat (l, r : sfixed_matrix) return sfixed_matrix;
  function vertcat (l, r : sfixed_matrix) return sfixed_matrix;

  -- Rotate a matrix
  function flipdim (
    arg          : sfixed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return sfixed_matrix;
  function fliplr (arg : sfixed_matrix) return sfixed_matrix;
  function flipup (arg : sfixed_matrix) return sfixed_matrix;
  function fliplr (arg : sfixed_vector) return sfixed_vector;
  function rot90 (
    arg          : sfixed_matrix;
    constant dim : INTEGER := 1)        -- 1 = y, 2 = x
    return sfixed_matrix;

  -- Puts two matrices together to form one
  function cat (
    dim  : POSITIVE;                    -- 1 = y, 2 = x
    l, r : unsigned_matrix)
    return unsigned_matrix;
  function horzcat (l, r : unsigned_matrix) return unsigned_matrix;
  function vertcat (l, r : unsigned_matrix) return unsigned_matrix;

  -- Rotate a matrix
  function flipdim (
    arg          : unsigned_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return unsigned_matrix;
  function fliplr (arg : unsigned_matrix) return unsigned_matrix;
  function flipup (arg : unsigned_matrix) return unsigned_matrix;
  function fliplr (arg : unsigned_vector) return unsigned_vector;
  function rot90 (
    arg          : unsigned_matrix;
    constant dim : INTEGER := 1)        -- 1 = y, 2 = x
    return unsigned_matrix;

  -- Puts two matrices together to form one
  function cat (
    dim  : POSITIVE;                    -- 1 = y, 2 = x
    l, r : signed_matrix)
    return signed_matrix;
  function horzcat (l, r : signed_matrix) return signed_matrix;
  function vertcat (l, r : signed_matrix) return signed_matrix;

  -- Rotate a matrix
  function flipdim (
    arg          : signed_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return signed_matrix;
  function fliplr (arg : signed_matrix) return signed_matrix;
  function flipup (arg : signed_matrix) return signed_matrix;
  function fliplr (arg : signed_vector) return signed_vector;
  function rot90 (
    arg          : signed_matrix;
    constant dim : INTEGER := 1)        -- 1 = y, 2 = x
    return signed_matrix;

  -- Uses the elements of the input matrix to create one of a new shape
  function reshape (
    arg           : ufixed_matrix;
    rows, columns : POSITIVE)
    return ufixed_matrix;

  function reshape (
    arg           : ufixed_vector;
    rows, columns : POSITIVE)
    return ufixed_matrix;

  function reshape (
    arg           : ufixed_matrix;
    rows, columns : POSITIVE)
    return ufixed_vector;

  -- Uses the elements of the input matrix to create one of a new shape
  function reshape (
    arg           : sfixed_matrix;
    rows, columns : POSITIVE)
    return sfixed_matrix;

  function reshape (
    arg           : sfixed_vector;
    rows, columns : POSITIVE)
    return sfixed_matrix;

  function reshape (
    arg           : sfixed_matrix;
    rows, columns : POSITIVE)
    return sfixed_vector;

  -- Uses the elements of the input matrix to create one of a new shape
  function reshape (
    arg           : unsigned_matrix;
    rows, columns : POSITIVE)
    return unsigned_matrix;

  function reshape (
    arg           : unsigned_vector;
    rows, columns : POSITIVE)
    return unsigned_matrix;

  function reshape (
    arg           : unsigned_matrix;
    rows, columns : POSITIVE)
    return unsigned_vector;

  -- Uses the elements of the input matrix to create one of a new shape
  function reshape (
    arg           : signed_matrix;
    rows, columns : POSITIVE)
    return signed_matrix;

  function reshape (
    arg           : signed_vector;
    rows, columns : POSITIVE)
    return signed_matrix;

  function reshape (
    arg           : signed_matrix;
    rows, columns : POSITIVE)
    return signed_vector;

  -- returns the size of a matrix
  function size (arg     : ufixed_matrix) return integer_vector;
  -- True if matrix is one dimensional
  function isvector (arg : ufixed_matrix) return BOOLEAN;
  -- True if a 1/1 matrix
  function isscalar (arg : ufixed_matrix) return BOOLEAN;
  -- returns the number of elements in a matrix
  function numel (arg    : ufixed_matrix) return INTEGER;

  -- returns the size of a matrix
  function size (arg     : sfixed_matrix) return integer_vector;
  -- True if matrix is one dimensional
  function isvector (arg : sfixed_matrix) return BOOLEAN;
  -- True if a 1/1 matrix
  function isscalar (arg : sfixed_matrix) return BOOLEAN;
  -- returns the number of elements in a matrix
  function numel (arg    : sfixed_matrix) return INTEGER;

  -- returns the size of a matrix
  function size (arg     : unsigned_matrix) return integer_vector;
  -- True if matrix is one dimensional
  function isvector (arg : unsigned_matrix) return BOOLEAN;
  -- True if a 1/1 matrix
  function isscalar (arg : unsigned_matrix) return BOOLEAN;
  -- returns the number of elements in a matrix
  function numel (arg    : unsigned_matrix) return INTEGER;

  -- returns the size of a matrix
  function size (arg     : signed_matrix) return integer_vector;
  -- True if matrix is one dimensional
  function isvector (arg : signed_matrix) return BOOLEAN;
  -- True if a 1/1 matrix
  function isscalar (arg : signed_matrix) return BOOLEAN;
  -- returns the number of elements in a matrix
  function numel (arg    : signed_matrix) return INTEGER;

  -- Return the diagonal of a matrix
  function diag (arg : ufixed_matrix) return ufixed_vector;
  function diag (arg : sfixed_matrix) return sfixed_vector;
  function diag (arg : unsigned_matrix) return unsigned_vector;
  function diag (arg : signed_matrix) return signed_vector;

  -- Return the diagonal of a matrix
  function diag (arg : ufixed_vector) return ufixed_matrix;
  function diag (arg : sfixed_vector) return sfixed_matrix;
  function diag (arg : unsigned_vector) return unsigned_matrix;
  function diag (arg : signed_vector) return signed_matrix;

  -- Return the matrix of a diagonal
  function blkdiag (arg   : ufixed_vector) return ufixed_matrix;
  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  function blockdiag (arg : ufixed_matrix; rep : POSITIVE) return ufixed_matrix;
  -- Return the lower triangle of a matrix
  function tril (arg      : ufixed_matrix) return ufixed_matrix;
  -- Return the upper triangle of a matrix
  function triu (arg      : ufixed_matrix) return ufixed_matrix;

  -- Return the matrix of a diagonal
  function blkdiag (arg   : sfixed_vector) return sfixed_matrix;
  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  function blockdiag (arg : sfixed_matrix; rep : POSITIVE) return sfixed_matrix;
  -- Return the lower triangle of a matrix
  function tril (arg      : sfixed_matrix) return sfixed_matrix;
  -- Return the upper triangle of a matrix
  function triu (arg      : sfixed_matrix) return sfixed_matrix;

  -- Return the matrix of a diagonal
  function blkdiag (arg   : unsigned_vector) return unsigned_matrix;
  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  function blockdiag (arg : unsigned_matrix; rep : POSITIVE) return unsigned_matrix;
  -- Return the lower triangle of a matrix
  function tril (arg      : unsigned_matrix) return unsigned_matrix;
  -- Return the upper triangle of a matrix
  function triu (arg      : unsigned_matrix) return unsigned_matrix;

  -- Return the matrix of a diagonal
  function blkdiag (arg   : signed_vector) return signed_matrix;
  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  function blockdiag (arg : signed_matrix; rep : POSITIVE) return signed_matrix;
  -- Return the lower triangle of a matrix
  function tril (arg      : signed_matrix) return signed_matrix;
  -- Return the upper triangle of a matrix
  function triu (arg      : signed_matrix) return signed_matrix;

  -- Creates a matrix set to the value "val"
  function repmat (
    arg                    : ufixed;
    constant rows, columns : NATURAL)
    return ufixed_matrix;
  function repmat (
    arg                    : ufixed;
    constant rows, columns : NATURAL)
    return ufixed_vector;
  function repmat (
    arg                    : sfixed;
    constant rows, columns : NATURAL)
    return sfixed_matrix;
  function repmat (
    arg                    : sfixed;
    constant rows, columns : NATURAL)
    return sfixed_vector;
  function repmat (
    arg                    : UNSIGNED;
    constant rows, columns : NATURAL)
    return unsigned_matrix;
  function repmat (
    arg                    : UNSIGNED;
    constant rows, columns : NATURAL)
    return unsigned_vector;
  function repmat (
    arg                    : SIGNED;
    constant rows, columns : NATURAL)
    return signed_matrix;
  function repmat (
    arg                    : SIGNED;
    constant rows, columns : NATURAL)
    return signed_vector;
  -----------------------------------------------------------------------------
  -- These functions allow you to do matrix and vector slicing
  -----------------------------------------------------------------------------
  -- returns an rows/columns matrix from position x,y in the input matrix
  function SubMatrix (
    arg                    : ufixed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return ufixed_matrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : ufixed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return ufixed_vector;

  -- Places the matrix "arg" at location X,Y in matrix "result"
  procedure BuildMatrix (
    arg           : in    ufixed_matrix;
    result        : inout ufixed_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    ufixed_vector;
    result        : inout ufixed_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    ufixed_vector;
    result        : inout ufixed_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- purpose: SubMatrix returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : ufixed_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return ufixed_matrix;

  -- returns an rows/columns matrix from position x,y in the input matrix
  function SubMatrix (
    arg                    : sfixed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return sfixed_matrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : sfixed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return sfixed_vector;

  -- Places the matrix "arg" at location X,Y in matrix "result"
  procedure BuildMatrix (
    arg           : in    sfixed_matrix;
    result        : inout sfixed_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    sfixed_vector;
    result        : inout sfixed_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    sfixed_vector;
    result        : inout sfixed_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- purpose: SubMatrix returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : sfixed_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return sfixed_matrix;

  -- returns an rows/columns matrix from position x,y in the input matrix
  function SubMatrix (
    arg                    : unsigned_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return unsigned_matrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : unsigned_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return unsigned_vector;

  -- Places the matrix "arg" at location X,Y in matrix "result"
  procedure BuildMatrix (
    arg           : in    unsigned_matrix;
    result        : inout unsigned_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    unsigned_vector;
    result        : inout unsigned_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    unsigned_vector;
    result        : inout unsigned_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- purpose: SubMatrix returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : unsigned_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return unsigned_matrix;

  -- returns an rows/columns matrix from position x,y in the input matrix
  function SubMatrix (
    arg                    : signed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return signed_matrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : signed_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)   -- rows and columns in new matrix
    return signed_vector;

  -- Places the matrix "arg" at location X,Y in matrix "result"
  procedure BuildMatrix (
    arg           : in    signed_matrix;
    result        : inout signed_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    signed_vector;
    result        : inout signed_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    signed_vector;
    result        : inout signed_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- purpose: SubMatrix returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : signed_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return signed_matrix;

  -----------------------------------------------------------------------------
  -- Conversion functions
  -----------------------------------------------------------------------------
  function to_ufixed (
    arg                     : unsigned_matrix;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := 0;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix;
  
  function to_ufixed (
    arg                     : real_matrix;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix;
  
  function to_ufixed (
    arg                     : integer_matrix;  -- integer
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := 0;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix;
  
  function to_ufixed (
    arg                     : unsigned_vector;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := 0;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector;
  
  function to_ufixed (
    arg                     : real_vector;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector;

  function to_ufixed (
    arg                     : integer_vector;  -- integer
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := 0;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector;

  function to_sfixed (
    arg                     : signed_matrix;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := 0;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix;
  
  function to_sfixed (
    arg                     : real_matrix;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix;

  function to_sfixed (
    arg                     : integer_matrix;  -- integer
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := 0;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix;
  
  function to_sfixed (
    arg                     : ufixed_matrix;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix;

  function to_sfixed (
    arg                     : signed_vector;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := 0;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector;

  function to_sfixed (
    arg                     : real_vector;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector;

  function to_sfixed (
    arg                     : integer_vector;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := 0;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector;

  function to_sfixed (
    arg                     : ufixed_vector;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector;

  function to_unsigned (
    arg                     : ufixed_matrix;
    constant size           : NATURAL                   := unsigned_matrix_high+1;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return unsigned_matrix;

  function to_unsigned (
    arg           : integer_matrix;
    constant size : NATURAL := unsigned_matrix_high+1)
    return unsigned_matrix;

  function to_unsigned (
    arg                     : ufixed_vector;
    constant size           : NATURAL                   := unsigned_matrix_high+1;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return unsigned_vector;

  function to_unsigned (
    arg           : integer_vector;
    constant size : NATURAL := unsigned_matrix_high+1)
    return unsigned_vector;

  function to_signed (
    arg                     : sfixed_matrix;
    constant size           : NATURAL                   := signed_matrix_high+1;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return signed_matrix;

  function to_signed (
    arg           : integer_matrix;
    constant size : NATURAL := signed_matrix_high+1)
    return signed_matrix;

  function to_signed (
    arg           : unsigned_matrix;
    constant size : NATURAL := signed_matrix_high+1)
    return signed_matrix;

  function to_signed (
    arg                     : sfixed_vector;
    constant size           : NATURAL                   := signed_matrix_high+1;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return signed_vector;

  function to_signed (
    arg           : integer_vector;
    constant size : NATURAL := signed_matrix_high+1)
    return signed_vector;

  function to_signed (
    arg           : unsigned_vector;
    constant size : NATURAL := signed_matrix_high+1)
    return signed_vector;

  function to_real (arg : ufixed_matrix) return real_matrix;
  function to_real (arg : sfixed_matrix) return real_matrix;
  function to_real (arg : ufixed_vector) return real_vector;
  function to_real (arg : sfixed_vector) return real_vector;

  function to_integer (arg : unsigned_matrix) return integer_matrix;
  function to_integer (arg : signed_matrix) return integer_matrix;
  function to_integer (arg : unsigned_vector) return integer_vector;
  function to_integer (arg : signed_vector) return integer_vector;

  -- These functions will be needed when you can do unconstrained arrays
  -- of unconstrained arrays
  function resize (
    arg                     : ufixed_matrix;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix;

  function resize (
    arg                     : sfixed_matrix;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix;

  function resize (
    arg               : unsigned_matrix;
    constant new_size : POSITIVE := unsigned_matrix_high)
    return unsigned_matrix;

  function resize (
    arg               : signed_matrix;
    constant new_size : POSITIVE := signed_matrix_high)
    return signed_matrix;

  function resize (
    arg                     : ufixed_vector;
    constant left_index     : INTEGER                   := ufixed_matrix_high;
    constant right_index    : INTEGER                   := ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector;

  function resize (
    arg                     : sfixed_vector;
    constant left_index     : INTEGER                   := sfixed_matrix_high;
    constant right_index    : INTEGER                   := sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector;

  function resize (
    arg               : unsigned_vector;
    constant new_size : POSITIVE := unsigned_matrix_high)
    return unsigned_vector;

  function resize (
    arg               : signed_vector;
    constant new_size : POSITIVE := signed_matrix_high)
    return signed_vector;

  -- Rounds to a given precision.  "places" is the number of bits to round to.
  function xprecision (
    arg                     : sfixed;
    constant places         : NATURAL                   := -sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed;

  function xprecision (
    arg                     : ufixed;
    constant places         : NATURAL                   := -ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed;

  function precision (
    arg                     : sfixed_vector;
    constant places         : NATURAL                   := -sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector;

  function precision (
    arg                     : sfixed_matrix;
    constant places         : NATURAL                   := -sfixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix;

  function precision (
    arg                     : ufixed_vector;
    constant places         : NATURAL                   := -ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector;

  function precision (
    arg                     : ufixed_matrix;
    constant places         : NATURAL                   := -ufixed_matrix_low;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix;

  -- rounding routines (named xround to not interfere with "round")
  function xround (
    arg                     : sfixed;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed;

  function xround (
    arg                     : ufixed;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed;

  function round (
    arg                     : sfixed_vector;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_vector;

  function round (
    arg                     : sfixed_matrix;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return sfixed_matrix;

  function round (
    arg                     : ufixed_vector;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_vector;

  function round (
    arg                     : ufixed_matrix;
    constant overflow_style : fixed_overflow_style_type := fixed_overflow_style;
    constant round_style    : fixed_round_style_type    := fixed_round_style)
    return ufixed_matrix;

  -----------------------------------------------------------------------------
  -- Overloads
  -----------------------------------------------------------------------------
  function "*" (l : sfixed_matrix; r : signed_matrix) return sfixed_matrix;
  function "*" (l : sfixed_matrix; r : real_matrix) return sfixed_matrix;
  function "*" (l : sfixed_matrix; r : integer_matrix) return sfixed_matrix;
  function "*" (l : sfixed_matrix; r : ufixed_matrix) return sfixed_matrix;
  function "*" (l : sfixed_matrix; r : signed_vector) return sfixed_matrix;
  function "*" (l : sfixed_matrix; r : real_vector) return sfixed_matrix;
  function "*" (l : sfixed_matrix; r : integer_vector) return sfixed_matrix;
  function "*" (l : sfixed_matrix; r : ufixed_vector) return sfixed_matrix;
  function "*" (l : signed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "*" (l : real_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "*" (l : integer_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "*" (l : signed_vector; r : sfixed_matrix) return sfixed_vector;
  function "*" (l : real_vector; r : sfixed_matrix) return sfixed_vector;
  function "*" (l : integer_vector; r : sfixed_matrix) return sfixed_vector;
  function "*" (l : ufixed_vector; r : sfixed_matrix) return sfixed_vector;
  function "*" (l : SIGNED; r : sfixed_matrix) return sfixed_matrix;
  function "*" (l : INTEGER; r : sfixed_matrix) return sfixed_matrix;
  function "*" (l : REAL; r : sfixed_matrix) return sfixed_matrix;
  function "*" (l : ufixed; r : sfixed_matrix) return sfixed_matrix;
  function "*" (l : SIGNED; r : sfixed_vector) return sfixed_vector;
  function "*" (l : INTEGER; r : sfixed_vector) return sfixed_vector;
  function "*" (l : REAL; r : sfixed_vector) return sfixed_vector;
  function "*" (l : ufixed; r : sfixed_vector) return sfixed_vector;
  function "*" (l : sfixed_matrix; r : SIGNED) return sfixed_matrix;
  function "*" (l : sfixed_matrix; r : INTEGER) return sfixed_matrix;
  function "*" (l : sfixed_matrix; r : REAL) return sfixed_matrix;
  function "*" (l : sfixed_matrix; r : ufixed) return sfixed_matrix;
  function "*" (l : sfixed_vector; r : SIGNED) return sfixed_vector;
  function "*" (l : sfixed_vector; r : INTEGER) return sfixed_vector;
  function "*" (l : sfixed_vector; r : REAL) return sfixed_vector;
  function "*" (l : sfixed_vector; r : ufixed) return sfixed_vector;
  function "/" (l : sfixed_matrix; r : signed_matrix) return sfixed_matrix;
  function "/" (l : sfixed_matrix; r : integer_matrix) return sfixed_matrix;
  function "/" (l : sfixed_matrix; r : real_matrix) return sfixed_matrix;
  function "/" (l : sfixed_matrix; r : ufixed_matrix) return sfixed_matrix;
  function "/" (l : signed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "/" (l : integer_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "/" (l : real_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "/" (l : ufixed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "/" (l : sfixed_matrix; r : SIGNED) return sfixed_matrix;
  function "/" (l : sfixed_matrix; r : INTEGER) return sfixed_matrix;
  function "/" (l : sfixed_matrix; r : REAL) return sfixed_matrix;
  function "/" (l : sfixed_matrix; r : ufixed) return sfixed_matrix;
  function "+" (l : sfixed_matrix; r : signed_matrix) return sfixed_matrix;
  function "+" (l : sfixed_matrix; r : integer_matrix) return sfixed_matrix;
  function "+" (l : sfixed_matrix; r : real_matrix) return sfixed_matrix;
  function "+" (l : sfixed_matrix; r : ufixed_matrix) return sfixed_matrix;
  function "+" (l : signed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "+" (l : integer_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "+" (l : real_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "+" (l : ufixed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "+" (l : sfixed_vector; r : signed_vector) return sfixed_vector;
  function "+" (l : sfixed_vector; r : integer_vector) return sfixed_vector;
  function "+" (l : sfixed_vector; r : real_vector) return sfixed_vector;
  function "+" (l : sfixed_vector; r : ufixed_vector) return sfixed_vector;
  function "+" (l : signed_vector; r : sfixed_vector) return sfixed_vector;
  function "+" (l : integer_vector; r : sfixed_vector) return sfixed_vector;
  function "+" (l : real_vector; r : sfixed_vector) return sfixed_vector;
  function "+" (l : ufixed_vector; r : sfixed_vector) return sfixed_vector;
  function "-" (l : sfixed_matrix; r : signed_matrix) return sfixed_matrix;
  function "-" (l : sfixed_matrix; r : integer_matrix) return sfixed_matrix;
  function "-" (l : sfixed_matrix; r : real_matrix) return sfixed_matrix;
  function "-" (l : sfixed_matrix; r : ufixed_matrix) return sfixed_matrix;
  function "-" (l : signed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "-" (l : integer_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "-" (l : real_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "-" (l : ufixed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function "-" (l : sfixed_vector; r : signed_vector) return sfixed_vector;
  function "-" (l : sfixed_vector; r : integer_vector) return sfixed_vector;
  function "-" (l : sfixed_vector; r : real_vector) return sfixed_vector;
  function "-" (l : sfixed_vector; r : ufixed_vector) return sfixed_vector;
  function "-" (l : signed_vector; r : sfixed_vector) return sfixed_vector;
  function "-" (l : integer_vector; r : sfixed_vector) return sfixed_vector;
  function "-" (l : real_vector; r : sfixed_vector) return sfixed_vector;
  function "-" (l : ufixed_vector; r : sfixed_vector) return sfixed_vector;

  function times (l : sfixed_matrix; r : signed_matrix) return sfixed_matrix;
  function times (l : sfixed_matrix; r : integer_matrix) return sfixed_matrix;
  function times (l : sfixed_matrix; r : real_matrix) return sfixed_matrix;
  function times (l : sfixed_matrix; r : ufixed_matrix) return sfixed_matrix;
  function times (l : signed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function times (l : integer_matrix; r : sfixed_matrix) return sfixed_matrix;
  function times (l : real_matrix; r : sfixed_matrix) return sfixed_matrix;
  function times (l : ufixed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function times (l : sfixed_vector; r : signed_vector) return sfixed_vector;
  function times (l : sfixed_vector; r : integer_vector) return sfixed_vector;
  function times (l : sfixed_vector; r : real_vector) return sfixed_vector;
  function times (l : sfixed_vector; r : ufixed_vector) return sfixed_vector;
  function times (l : signed_vector; r : sfixed_vector) return sfixed_vector;
  function times (l : integer_vector; r : sfixed_vector) return sfixed_vector;
  function times (l : real_vector; r : sfixed_vector) return sfixed_vector;
  function times (l : ufixed_vector; r : sfixed_vector) return sfixed_vector;

  function rdivide (l  : sfixed_matrix; r : signed_matrix) return sfixed_matrix;
  function rdivide (l  : sfixed_matrix; r : integer_matrix) return sfixed_matrix;
  function rdivide (l  : sfixed_matrix; r : real_matrix) return sfixed_matrix;
  function rdivide (l  : sfixed_matrix; r : ufixed_matrix) return sfixed_matrix;
  function rdivide (l  : signed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function rdivide (l  : integer_matrix; r : sfixed_matrix) return sfixed_matrix;
  function rdivide (l  : real_matrix; r : sfixed_matrix) return sfixed_matrix;
  function rdivide (l  : ufixed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function rdivide (l  : sfixed_vector; r : signed_vector) return sfixed_vector;
  function rdivide (l  : sfixed_vector; r : integer_vector) return sfixed_vector;
  function rdivide (l  : sfixed_vector; r : real_vector) return sfixed_vector;
  function rdivide (l  : sfixed_vector; r : ufixed_vector) return sfixed_vector;
  function rdivide (l  : signed_vector; r : sfixed_vector) return sfixed_vector;
  function rdivide (l  : integer_vector; r : sfixed_vector) return sfixed_vector;
  function rdivide (l  : real_vector; r : sfixed_vector) return sfixed_vector;
  function rdivide (l  : ufixed_vector; r : sfixed_vector) return sfixed_vector;
  function mrdivide (l : sfixed_matrix; r : signed_matrix) return sfixed_matrix;
  function mrdivide (l : sfixed_matrix; r : integer_matrix) return sfixed_matrix;
  function mrdivide (l : sfixed_matrix; r : real_matrix) return sfixed_matrix;
  function mrdivide (l : sfixed_matrix; r : ufixed_matrix) return sfixed_matrix;
  function mrdivide (l : signed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function mrdivide (l : integer_matrix; r : sfixed_matrix) return sfixed_matrix;
  function mrdivide (l : real_matrix; r : sfixed_matrix) return sfixed_matrix;
  function mrdivide (l : ufixed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function mldivide (l : sfixed_matrix; r : signed_matrix) return sfixed_matrix;
  function mldivide (l : sfixed_matrix; r : integer_matrix) return sfixed_matrix;
  function mldivide (l : sfixed_matrix; r : real_matrix) return sfixed_matrix;
  function mldivide (l : sfixed_matrix; r : ufixed_matrix) return sfixed_matrix;
  function mldivide (l : signed_matrix; r : sfixed_matrix) return sfixed_matrix;
  function mldivide (l : integer_matrix; r : sfixed_matrix) return sfixed_matrix;
  function mldivide (l : real_matrix; r : sfixed_matrix) return sfixed_matrix;
  function mldivide (l : ufixed_matrix; r : sfixed_matrix) return sfixed_matrix;

--  function "/" (l, r : signed_matrix) return sfixed_matrix;
--  function "/" (l, r : unsigned_matrix) return sfixed_matrix;
--  function "/" (l, r : ufixed_matrix) return sfixed_matrix;

--  function "/" (l : signed_matrix; r : SIGNED) return sfixed_matrix;
--  function "/" (l : signed_vector; r : SIGNED) return sfixed_matrix;

--  function rdivide (l, r : signed_matrix) return sfixed_matrix;
--  function mldivide (l, r : ufixed_matrix) return sfixed_matrix;
--  function mldivide (l, r : unsigned_matrix) return sfixed_matrix;
--  function mrdivide (l, r : signed_matrix) return sfixed_matrix;

--  function inv (arg : unsigned_matrix) return sfixed_matrix;
--  function inv (arg : signed_matrix) return sfixed_matrix;
--  function inv (arg : ufixed_matrix) return sfixed_matrix;

  -- ufixed overloads
  function "*" (l : ufixed_matrix; r : unsigned_matrix) return ufixed_matrix;
  function "*" (l : ufixed_matrix; r : real_matrix) return ufixed_matrix;
  function "*" (l : ufixed_matrix; r : integer_matrix) return ufixed_matrix;
  function "*" (l : ufixed_matrix; r : unsigned_vector) return ufixed_matrix;
  function "*" (l : ufixed_matrix; r : real_vector) return ufixed_matrix;
  function "*" (l : ufixed_matrix; r : integer_vector) return ufixed_matrix;
  function "*" (l : unsigned_matrix; r : ufixed_matrix) return ufixed_matrix;
  function "*" (l : real_matrix; r : ufixed_matrix) return ufixed_matrix;
  function "*" (l : integer_matrix; r : ufixed_matrix) return ufixed_matrix;
  function "*" (l : unsigned_vector; r : ufixed_matrix) return ufixed_vector;
  function "*" (l : real_vector; r : ufixed_matrix) return ufixed_vector;
  function "*" (l : integer_vector; r : ufixed_matrix) return ufixed_vector;
  function "*" (l : UNSIGNED; r : ufixed_matrix) return ufixed_matrix;
  function "*" (l : INTEGER; r : ufixed_matrix) return ufixed_matrix;
  function "*" (l : REAL; r : ufixed_matrix) return ufixed_matrix;
  function "*" (l : UNSIGNED; r : ufixed_vector) return ufixed_vector;
  function "*" (l : INTEGER; r : ufixed_vector) return ufixed_vector;
  function "*" (l : REAL; r : ufixed_vector) return ufixed_vector;
  function "*" (l : ufixed_matrix; r : UNSIGNED) return ufixed_matrix;
  function "*" (l : ufixed_matrix; r : INTEGER) return ufixed_matrix;
  function "*" (l : ufixed_matrix; r : REAL) return ufixed_matrix;
  function "/" (l : ufixed_matrix; r : UNSIGNED) return ufixed_matrix;
  function "/" (l : ufixed_matrix; r : INTEGER) return ufixed_matrix;
  function "/" (l : ufixed_matrix; r : REAL) return ufixed_matrix;
  function "+" (l : ufixed_matrix; r : unsigned_matrix) return ufixed_matrix;
  function "+" (l : ufixed_matrix; r : integer_matrix) return ufixed_matrix;
  function "+" (l : ufixed_matrix; r : real_matrix) return ufixed_matrix;
  function "+" (l : unsigned_matrix; r : ufixed_matrix) return ufixed_matrix;
  function "+" (l : integer_matrix; r : ufixed_matrix) return ufixed_matrix;
  function "+" (l : real_matrix; r : ufixed_matrix) return ufixed_matrix;
  function "+" (l : ufixed_vector; r : unsigned_vector) return ufixed_vector;
  function "+" (l : ufixed_vector; r : integer_vector) return ufixed_vector;
  function "+" (l : ufixed_vector; r : real_vector) return ufixed_vector;
  function "+" (l : unsigned_vector; r : ufixed_vector) return ufixed_vector;
  function "+" (l : integer_vector; r : ufixed_vector) return ufixed_vector;
  function "+" (l : real_vector; r : ufixed_vector) return ufixed_vector;
  function "-" (l : ufixed_matrix; r : unsigned_matrix) return ufixed_matrix;
  function "-" (l : ufixed_matrix; r : integer_matrix) return ufixed_matrix;
  function "-" (l : ufixed_matrix; r : real_matrix) return ufixed_matrix;
  function "-" (l : unsigned_matrix; r : ufixed_matrix) return ufixed_matrix;
  function "-" (l : integer_matrix; r : ufixed_matrix) return ufixed_matrix;
  function "-" (l : real_matrix; r : ufixed_matrix) return ufixed_matrix;
  function "-" (l : ufixed_vector; r : unsigned_vector) return ufixed_vector;
  function "-" (l : ufixed_vector; r : integer_vector) return ufixed_vector;
  function "-" (l : ufixed_vector; r : real_vector) return ufixed_vector;
  function "-" (l : unsigned_vector; r : ufixed_vector) return ufixed_vector;
  function "-" (l : integer_vector; r : ufixed_vector) return ufixed_vector;
  function "-" (l : real_vector; r : ufixed_vector) return ufixed_vector;

  function times (l : ufixed_matrix; r : unsigned_matrix) return ufixed_matrix;
  function times (l : ufixed_matrix; r : integer_matrix) return ufixed_matrix;
  function times (l : ufixed_matrix; r : real_matrix) return ufixed_matrix;
  function times (l : unsigned_matrix; r : ufixed_matrix) return ufixed_matrix;
  function times (l : integer_matrix; r : ufixed_matrix) return ufixed_matrix;
  function times (l : real_matrix; r : ufixed_matrix) return ufixed_matrix;
  function times (l : ufixed_vector; r : unsigned_vector) return ufixed_vector;
  function times (l : ufixed_vector; r : integer_vector) return ufixed_vector;
  function times (l : ufixed_vector; r : real_vector) return ufixed_vector;
  function times (l : unsigned_vector; r : ufixed_vector) return ufixed_vector;
  function times (l : integer_vector; r : ufixed_vector) return ufixed_vector;
  function times (l : real_vector; r : ufixed_vector) return ufixed_vector;

  function rdivide (l : ufixed_matrix; r : unsigned_matrix) return ufixed_matrix;
  function rdivide (l : ufixed_matrix; r : integer_matrix) return ufixed_matrix;
  function rdivide (l : ufixed_matrix; r : real_matrix) return ufixed_matrix;
  function rdivide (l : unsigned_matrix; r : ufixed_matrix) return ufixed_matrix;
  function rdivide (l : integer_matrix; r : ufixed_matrix) return ufixed_matrix;
  function rdivide (l : real_matrix; r : ufixed_matrix) return ufixed_matrix;
  function rdivide (l : ufixed_vector; r : unsigned_vector) return ufixed_vector;
  function rdivide (l : ufixed_vector; r : integer_vector) return ufixed_vector;
  function rdivide (l : ufixed_vector; r : real_vector) return ufixed_vector;
  function rdivide (l : unsigned_vector; r : ufixed_vector) return ufixed_vector;
  function rdivide (l : integer_vector; r : ufixed_vector) return ufixed_vector;
  function rdivide (l : real_vector; r : ufixed_vector) return ufixed_vector;

  -- signed overloads
  function "*" (l : signed_matrix; r : integer_matrix) return signed_matrix;
  function "*" (l : signed_matrix; r : unsigned_matrix) return signed_matrix;
  function "*" (l : integer_matrix; r : signed_matrix) return signed_matrix;
  function "*" (l : unsigned_matrix; r : signed_matrix) return signed_matrix;
  function "*" (l : signed_matrix; r : integer_vector) return signed_matrix;
  function "*" (l : signed_matrix; r : unsigned_vector) return signed_matrix;
  function "*" (l : integer_matrix; r : signed_vector) return signed_matrix;
  function "*" (l : unsigned_matrix; r : signed_vector) return signed_matrix;
  function "*" (l : signed_vector; r : integer_matrix) return signed_vector;
  function "*" (l : signed_vector; r : unsigned_matrix) return signed_vector;
  function "*" (l : integer_vector; r : signed_matrix) return signed_vector;
  function "*" (l : unsigned_vector; r : signed_matrix) return signed_vector;
  function "*" (l : INTEGER; r : signed_matrix) return signed_matrix;
  function "*" (l : UNSIGNED; r : signed_matrix) return signed_matrix;
  function "*" (l : signed_matrix; r : INTEGER) return signed_matrix;
  function "*" (l : signed_matrix; r : UNSIGNED) return signed_matrix;
  function "*" (l : INTEGER; r : signed_vector) return signed_vector;
  function "*" (l : UNSIGNED; r : signed_vector) return signed_vector;
  function "*" (l : signed_vector; r : INTEGER) return signed_vector;
  function "*" (l : signed_vector; r : UNSIGNED) return signed_vector;
  function "+" (l : signed_matrix; r : integer_matrix) return signed_matrix;
  function "+" (l : signed_matrix; r : unsigned_matrix) return signed_matrix;
  function "+" (l : integer_matrix; r : signed_matrix) return signed_matrix;
  function "+" (l : unsigned_matrix; r : signed_matrix) return signed_matrix;
  function "+" (l : signed_vector; r : integer_vector) return signed_vector;
  function "+" (l : signed_vector; r : unsigned_vector) return signed_vector;
  function "+" (l : integer_vector; r : signed_vector) return signed_vector;
  function "+" (l : unsigned_vector; r : signed_vector) return signed_vector;
  function "-" (l : signed_matrix; r : integer_matrix) return signed_matrix;
  function "-" (l : signed_matrix; r : unsigned_matrix) return signed_matrix;
  function "-" (l : integer_matrix; r : signed_matrix) return signed_matrix;
  function "-" (l : unsigned_matrix; r : signed_matrix) return signed_matrix;
  function "-" (l : signed_vector; r : integer_vector) return signed_vector;
  function "-" (l : signed_vector; r : unsigned_vector) return signed_vector;
  function "-" (l : integer_vector; r : signed_vector) return signed_vector;
  function "-" (l : unsigned_vector; r : signed_vector) return signed_vector;

  function times (l : signed_matrix; r : integer_matrix) return signed_matrix;
  function times (l : signed_matrix; r : unsigned_matrix) return signed_matrix;
  function times (l : integer_matrix; r : signed_matrix) return signed_matrix;
  function times (l : unsigned_matrix; r : signed_matrix) return signed_matrix;
  function times (l : signed_vector; r : integer_vector) return signed_vector;
  function times (l : signed_vector; r : unsigned_vector) return signed_vector;
  function times (l : integer_vector; r : signed_vector) return signed_vector;
  function times (l : unsigned_vector; r : signed_vector) return signed_vector;

  -- unsigned overloads
  function "*" (l : unsigned_matrix; r : integer_matrix) return unsigned_matrix;
  function "*" (l : integer_matrix; r : unsigned_matrix) return unsigned_matrix;
  function "*" (l : unsigned_matrix; r : integer_vector) return unsigned_matrix;
  function "*" (l : integer_matrix; r : unsigned_vector) return unsigned_matrix;
  function "*" (l : unsigned_vector; r : integer_matrix) return unsigned_vector;
  function "*" (l : integer_vector; r : unsigned_matrix) return unsigned_vector;
  function "*" (l : INTEGER; r : unsigned_matrix) return unsigned_matrix;
  function "*" (l : unsigned_matrix; r : INTEGER) return unsigned_matrix;
  function "*" (l : INTEGER; r : unsigned_vector) return unsigned_vector;
  function "*" (l : unsigned_vector; r : INTEGER) return unsigned_vector;
  function "+" (l : unsigned_matrix; r : integer_matrix) return unsigned_matrix;
  function "+" (l : integer_matrix; r : unsigned_matrix) return unsigned_matrix;
  function "+" (l : unsigned_vector; r : integer_vector) return unsigned_vector;
  function "+" (l : integer_vector; r : unsigned_vector) return unsigned_vector;
  function "-" (l : unsigned_matrix; r : integer_matrix) return unsigned_matrix;
  function "-" (l : integer_matrix; r : unsigned_matrix) return unsigned_matrix;
  function "-" (l : unsigned_vector; r : integer_vector) return unsigned_vector;
  function "-" (l : integer_vector; r : unsigned_vector) return unsigned_vector;

  function times (l : unsigned_matrix; r : integer_matrix) return unsigned_matrix;
  function times (l : integer_matrix; r : unsigned_matrix) return unsigned_matrix;
  function times (l : unsigned_vector; r : integer_vector) return unsigned_vector;
  function times (l : integer_vector; r : unsigned_vector) return unsigned_vector;

  -----------------------------------------------------------------------------
  -- TextIO functions
  -----------------------------------------------------------------------------
-- rtl_synthesis off

  function to_string (value : ufixed_vector) return STRING;
  function to_string (value : ufixed_matrix) return STRING;
  function to_string (value : sfixed_vector) return STRING;
  function to_string (value : sfixed_matrix) return STRING;
  function to_string (value : unsigned_vector) return STRING;
  function to_string (value : unsigned_matrix) return STRING;
  function to_string (value : signed_vector) return STRING;
  function to_string (value : signed_matrix) return STRING;

  procedure write (
    L     : inout LINE;
    VALUE : in    ufixed_vector);
  procedure write (
    L     : inout LINE;
    VALUE : in    ufixed_matrix);
  procedure READ(
    L     : inout LINE;
    VALUE : out   ufixed_vector);
  procedure READ(
    L     : inout LINE;
    VALUE : out   ufixed_matrix);
  procedure READ(
    L     : inout LINE;
    VALUE : out   ufixed_vector;
    GOOD  : out   BOOLEAN);
  procedure READ(
    L     : inout LINE;
    VALUE : out   ufixed_matrix;
    GOOD  : out   BOOLEAN);

  procedure write (
    L     : inout LINE;
    VALUE : in    sfixed_vector);
  procedure write (
    L     : inout LINE;
    VALUE : in    sfixed_matrix);
  procedure READ(
    L     : inout LINE;
    VALUE : out   sfixed_vector);
  procedure READ(
    L     : inout LINE;
    VALUE : out   sfixed_matrix);
  procedure READ(
    L     : inout LINE;
    VALUE : out   sfixed_vector;
    GOOD  : out   BOOLEAN);
  procedure READ(
    L     : inout LINE;
    VALUE : out   sfixed_matrix;
    GOOD  : out   BOOLEAN);

  procedure write (
    L     : inout LINE;
    VALUE : in    unsigned_vector);
  procedure write (
    L     : inout LINE;
    VALUE : in    unsigned_matrix);
  procedure READ(
    L     : inout LINE;
    VALUE : out   unsigned_vector);
  procedure READ(
    L     : inout LINE;
    VALUE : out   unsigned_matrix);
  procedure READ(
    L     : inout LINE;
    VALUE : out   unsigned_vector;
    GOOD  : out   BOOLEAN);
  procedure READ(
    L     : inout LINE;
    VALUE : out   unsigned_matrix;
    GOOD  : out   BOOLEAN);

  procedure write (
    L     : inout LINE;
    VALUE : in    signed_vector);
  procedure write (
    L     : inout LINE;
    VALUE : in    signed_matrix);
  procedure READ(
    L     : inout LINE;
    VALUE : out   signed_vector);
  procedure READ(
    L     : inout LINE;
    VALUE : out   signed_matrix);
  procedure READ(
    L     : inout LINE;
    VALUE : out   signed_vector;
    GOOD  : out   BOOLEAN);
  procedure READ(
    L     : inout LINE;
    VALUE : out   signed_matrix;
    GOOD  : out   BOOLEAN);

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in ufixed_matrix;
    index : in BOOLEAN := false);

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in ufixed_vector;
    index : in BOOLEAN := false);

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in sfixed_matrix;
    index : in BOOLEAN := false);

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in sfixed_vector;
    index : in BOOLEAN := false);

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in unsigned_matrix;
    index : in BOOLEAN := false);

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in unsigned_vector;
    index : in BOOLEAN := false);

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in signed_matrix;
    index : in BOOLEAN := false);

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in signed_vector;
    index : in BOOLEAN := false);

-- rtl_synthesis on

end package fixed_matrix_pkg;
