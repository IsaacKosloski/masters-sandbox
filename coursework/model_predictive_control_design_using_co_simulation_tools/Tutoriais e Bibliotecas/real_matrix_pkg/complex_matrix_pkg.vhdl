-------------------------------------------------------------------------------
-- Title      : Matrix Math package for type COMPLEX
-- Project    : 
-------------------------------------------------------------------------------
-- File       : complex_matrix_pkg.vhdl
-- Author     : David Bishop  <dbishop@vhdl.org>
-- Company    : 
-- Created    : 2010-08-26
-- Last update: 2011-01-20
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: Matrix math package for type REAL
-------------------------------------------------------------------------------
-- Copyright (c) 2010 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2010-08-26  1.0      l435385 Created
-------------------------------------------------------------------------------

--
use std.textio.all;
library ieee;
use ieee.math_complex.all;
use work.real_matrix_pkg.all;

package complex_matrix_pkg is

  -- Define arrays of vectors
  type complex_vector is array (NATURAL range <>) of complex;
  type complex_polar_vector is array (NATURAL range <>) of complex_polar;

  -- Define the complex matrix types
  type complex_matrix is array (NATURAL range <>, NATURAL range <>) of complex;
  type complex_polar_matrix is array (NATURAL range <>, NATURAL range <>) of complex_polar;

  -----------------------------------------------------------------------------
  -- Conversion functions
  -----------------------------------------------------------------------------

  -- Converts a real to a complex
  function CMPLX (arg : real_matrix) return complex_matrix;
  function CMPLX (arg : real_vector) return complex_vector;

  -- Convert 2 complex matrices (one real, one imaginary) to complex_matrix
  function CMPLX (X, Y : real_matrix) return complex_matrix;
  function CMPLX (X, Y : real_vector) return complex_vector;

  -- Converts a complex_matrix to a complex_polar_matrix
  function COMPLEX_TO_POLAR (arg : complex_matrix) return complex_polar_matrix;
  function COMPLEX_TO_POLAR (arg : complex_vector) return complex_polar_vector;

  -- Convert a complex_polar_matrix to a complex_matrix
  function POLAR_TO_COMPLEX (arg : complex_polar_matrix) return complex_matrix;
  function POLAR_TO_COMPLEX (arg : complex_polar_vector) return complex_vector;

  -- Converts a complex_matrix to a real_matrix
  function "abs" (arg : complex_matrix) return real_matrix;
  function "abs" (arg : complex_vector) return real_vector;
  function "abs" (arg : complex_polar_matrix) return real_matrix;
  function "abs" (arg : complex_polar_vector) return real_vector;

  -----------------------------------------------------------------------------
  -- Arithmetic functions
  -----------------------------------------------------------------------------

  -- Returns the complex conjugate of the input
  function CONJ (arg : complex_matrix) return complex_matrix;
  function CONJ (arg : complex_vector) return complex_vector;
  function CONJ (arg : complex_polar_matrix) return complex_polar_matrix;
  function CONJ (arg : complex_polar_vector) return complex_polar_vector;

  -- Addition
  function "+" (l, r : complex_matrix) return complex_matrix;
  function "+" (l, r : complex_vector) return complex_vector;
  function "+" (l    : complex_matrix; r : real_matrix) return complex_matrix;
  function "+" (l    : complex_vector; r : real_vector) return complex_vector;
  function "+" (l    : real_matrix; r : complex_matrix) return complex_matrix;
  function "+" (l    : real_vector; r : complex_vector) return complex_vector;
  function "+" (l, r : complex_polar_matrix) return complex_polar_matrix;
  function "+" (l, r : complex_polar_vector) return complex_polar_vector;
  function "+" (l    : complex_polar_matrix; r : real_matrix) return complex_polar_matrix;
  function "+" (l    : complex_polar_vector; r : real_vector) return complex_polar_vector;
  function "+" (l    : real_matrix; r : complex_polar_matrix) return complex_polar_matrix;
  function "+" (l    : real_vector; r : complex_polar_vector) return complex_polar_vector;

  -- Returns unary minus of input
  function "-" (arg : complex_matrix) return complex_matrix;
  function "-" (arg : complex_vector) return complex_vector;
  function "-" (arg : complex_polar_matrix) return complex_polar_matrix;
  function "-" (arg : complex_polar_vector) return complex_polar_vector;

  -- Subtraction
  function "-" (l, r : complex_matrix) return complex_matrix;
  function "-" (l, r : complex_vector) return complex_vector;
  function "-" (l    : complex_matrix; r : real_matrix) return complex_matrix;
  function "-" (l    : complex_vector; r : real_vector) return complex_vector;
  function "-" (l    : real_matrix; r : complex_matrix) return complex_matrix;
  function "-" (l    : real_vector; r : complex_vector) return complex_vector;
  function "-" (l, r : complex_polar_matrix) return complex_polar_matrix;
  function "-" (l, r : complex_polar_vector) return complex_polar_vector;
  function "-" (l    : complex_polar_matrix; r : real_matrix) return complex_polar_matrix;
  function "-" (l    : complex_polar_vector; r : real_vector) return complex_polar_vector;
  function "-" (l    : real_matrix; r : complex_polar_matrix) return complex_polar_matrix;
  function "-" (l    : real_vector; r : complex_polar_vector) return complex_polar_vector;

  -- Multiply
  function "*" (l, r : complex_matrix) return complex_matrix;
  function "*" (l    : complex_matrix; r : real_matrix) return complex_matrix;
  function "*" (l    : real_matrix; r : complex_matrix) return complex_matrix;

  function "*" (l : complex_matrix; r : complex_vector) return complex_matrix;
  function "*" (l : complex_matrix; r : real_vector) return complex_matrix;
  function "*" (l : real_matrix; r : complex_vector) return complex_matrix;

  function "*" (l : complex_vector; r : complex_matrix) return complex_vector;
  function "*" (l : real_vector; r : complex_matrix) return complex_vector;
  function "*" (l : complex_vector; r : real_matrix) return complex_vector;

  function "*" (l : complex_matrix; r : COMPLEX) return complex_matrix;
  function "*" (l : COMPLEX; r : complex_matrix) return complex_matrix;
  function "*" (l : complex_vector; r : COMPLEX) return complex_vector;
  function "*" (l : COMPLEX; r : complex_vector) return complex_vector;

  function "*" (l : complex_matrix; r : REAL) return complex_matrix;
  function "*" (l : REAL; r : complex_matrix) return complex_matrix;
  function "*" (l : complex_vector; r : REAL) return complex_vector;
  function "*" (l : REAL; r : complex_vector) return complex_vector;


  function "*" (l, r : complex_polar_matrix) return complex_polar_matrix;
  function "*" (l    : complex_polar_matrix; r : real_matrix) return complex_polar_matrix;
  function "*" (l    : real_matrix; r : complex_polar_matrix) return complex_polar_matrix;

  function "*" (l : complex_polar_matrix; r : complex_polar_vector) return complex_polar_matrix;
  function "*" (l : complex_polar_matrix; r : real_vector) return complex_polar_matrix;
  function "*" (l : real_matrix; r : complex_polar_vector) return complex_polar_matrix;

  function "*" (l : complex_polar_vector; r : complex_polar_matrix) return complex_polar_vector;
  function "*" (l : real_vector; r : complex_polar_matrix) return complex_polar_vector;
  function "*" (l : complex_polar_vector; r : real_matrix) return complex_polar_vector;

  function "*" (l : complex_polar_matrix; r : COMPLEX_POLAR) return complex_polar_matrix;
  function "*" (l : COMPLEX_POLAR; r : complex_polar_matrix) return complex_polar_matrix;
  function "*" (l : complex_polar_vector; r : COMPLEX_POLAR) return complex_polar_vector;
  function "*" (l : COMPLEX_POLAR; r : complex_polar_vector) return complex_polar_vector;
  function "*" (l : complex_polar_matrix; r : REAL) return complex_polar_matrix;
  function "*" (l : REAL; r : complex_polar_matrix) return complex_polar_matrix;
  function "*" (l : complex_polar_vector; r : REAL) return complex_polar_vector;
  function "*" (l : REAL; r : complex_polar_vector) return complex_polar_vector;

  -- Division
  function "/" (l : complex_matrix; r : COMPLEX) return complex_matrix;
  function "/" (l : complex_vector; r : COMPLEX) return complex_vector;
  function "/" (l : complex_polar_matrix; r : COMPLEX_POLAR) return complex_polar_matrix;
  function "/" (l : complex_polar_vector; r : COMPLEX_POLAR) return complex_polar_vector;
  function "/" (l : complex_matrix; r : REAL) return complex_matrix;
  function "/" (l : complex_vector; r : REAL) return complex_vector;
  function "/" (l : complex_polar_matrix; r : REAL) return complex_polar_matrix;
  function "/" (l : complex_polar_vector; r : REAL) return complex_polar_vector;

  -- Matlab .* operator
  function times (l, r : complex_matrix) return complex_matrix;
  function times (l    : complex_matrix; r : real_matrix) return complex_matrix;
  function times (l    : real_matrix; r : complex_matrix) return complex_matrix;
  function times (l, r : complex_vector) return complex_vector;
  function times (l    : complex_vector; r : real_vector) return complex_vector;
  function times (l    : real_vector; r : complex_vector) return complex_vector;
  function times (l, r : complex_polar_matrix) return complex_polar_matrix;
  function times (l    : complex_polar_matrix; r : real_matrix) return complex_polar_matrix;
  function times (l    : real_matrix; r : complex_polar_matrix) return complex_polar_matrix;
  function times (l, r : complex_polar_vector) return complex_polar_vector;
  function times (l    : complex_polar_vector; r : real_vector) return complex_polar_vector;
  function times (l    : real_vector; r : complex_polar_vector) return complex_polar_vector;

  -- Matlab ./ operator
  function rdivide (l, r : complex_matrix) return complex_matrix;
  function rdivide (l    : complex_matrix; r : real_matrix) return complex_matrix;
  function rdivide (l    : real_matrix; r : complex_matrix) return complex_matrix;
  function rdivide (l, r : complex_vector) return complex_vector;
  function rdivide (l    : complex_vector; r : real_vector) return complex_vector;
  function rdivide (l    : real_vector; r : complex_vector) return complex_vector;

  function rdivide (l, r : complex_polar_matrix) return complex_polar_matrix;
  function rdivide (l    : complex_polar_matrix; r : real_matrix) return complex_polar_matrix;
  function rdivide (l    : real_matrix; r : complex_polar_matrix) return complex_polar_matrix;
  function rdivide (l, r : complex_polar_vector) return complex_polar_vector;
  function rdivide (l    : complex_polar_vector; r : real_vector) return complex_polar_vector;
  function rdivide (l    : real_vector; r : complex_polar_vector) return complex_polar_vector;

  -- Matlab / operator (calls mrdivide)
  function "/" (l, r      : complex_matrix) return complex_matrix;
  function "/" (l         : complex_matrix; r : real_matrix) return complex_matrix;
  function "/" (l         : real_matrix; r : complex_matrix) return complex_matrix;
  function mrdivide (l, r : complex_matrix) return complex_matrix;
  function mrdivide (l    : complex_matrix; r : real_matrix) return complex_matrix;
  function mrdivide (l    : real_matrix; r : complex_matrix) return complex_matrix;
  function "/" (l, r      : complex_polar_matrix) return complex_polar_matrix;
  function "/" (l         : complex_polar_matrix; r : real_matrix) return complex_polar_matrix;
  function "/" (l         : real_matrix; r : complex_polar_matrix) return complex_polar_matrix;
  function mrdivide (l, r : complex_polar_matrix) return complex_polar_matrix;
  function mrdivide (l    : complex_polar_matrix; r : real_matrix) return complex_polar_matrix;
  function mrdivide (l    : real_matrix; r : complex_polar_matrix) return complex_polar_matrix;

  -- Matlab \ operator
  function mldivide (l, r : complex_matrix) return complex_matrix;
  function mldivide (l    : complex_matrix; r : real_matrix) return complex_matrix;
  function mldivide (l    : real_matrix; r : complex_matrix) return complex_matrix;
  function mldivide (l, r : complex_polar_matrix) return complex_polar_matrix;
  function mldivide (l    : complex_polar_matrix; r : real_matrix) return complex_polar_matrix;
  function mldivide (l    : real_matrix; r : complex_polar_matrix) return complex_polar_matrix;

  function sqrt (arg : complex_matrix) return complex_matrix;
  function sqrt (arg : complex_vector) return complex_vector;
  function sqrt (arg : complex_polar_matrix) return complex_polar_matrix;
  function sqrt (arg : complex_polar_vector) return complex_polar_vector;

  function exp (arg : complex_matrix) return complex_matrix;
  function exp (arg : complex_vector) return complex_vector;
  function exp (arg : complex_polar_matrix) return complex_polar_matrix;
  function exp (arg : complex_polar_vector) return complex_polar_vector;

  function log (arg : complex_matrix) return complex_matrix;
  function log (arg : complex_vector) return complex_vector;
  function log (arg : complex_polar_matrix) return complex_polar_matrix;
  function log (arg : complex_polar_vector) return complex_polar_vector;
  
  -- Raise a matrix to a power ^ operator
  function "**" (arg : complex_matrix; pow : INTEGER) return complex_matrix;
  function "**" (arg : complex_polar_matrix; pow : INTEGER) return complex_polar_matrix;

  -- same as the Matlab .^ function
  -- no "pow" functions because "**" is not in math_complex

  -- Compare functions (use the defaults when possible)
  function "=" (l  : complex_matrix; r : complex_vector) return BOOLEAN;
  function "=" (l  : complex_vector; r : complex_matrix) return BOOLEAN;
  function "/=" (l : complex_matrix; r : complex_vector) return BOOLEAN;
  function "/=" (l : complex_vector; r : complex_matrix) return BOOLEAN;

  function "=" (l  : complex_polar_matrix; r : complex_polar_vector) return BOOLEAN;
  function "=" (l  : complex_polar_vector; r : complex_polar_matrix) return BOOLEAN;
  function "/=" (l : complex_polar_matrix; r : complex_polar_vector) return BOOLEAN;
  function "/=" (l : complex_polar_vector; r : complex_polar_matrix) return BOOLEAN;
  -----------------------------------------------------------------------------
  -- Algorithmic functions
  -----------------------------------------------------------------------------

  -- Sum the diagonal
  function trace (arg : complex_matrix) return complex;
  function trace (arg : complex_polar_matrix) return complex_polar;

  -- Sum a vector
  function sum (arg : complex_vector) return complex;
  function sum (arg : complex_polar_vector) return complex_polar;

  -- Sum a matrix and returns a vector
  function sum (
    arg          : complex_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return complex_vector;
  -- Sum a matrix and returns a vector
  function sum (
    arg          : complex_polar_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return complex_polar_vector;

  -- multiply a vector
  function prod (arg : complex_vector) return complex;
  function prod (arg : complex_polar_vector) return complex_polar;

  -- multiply a matrix and returns a vector
  function prod (
    arg          : complex_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return complex_vector;
  -- multiply a matrix and returns a vector
  function prod (
    arg          : complex_polar_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return complex_polar_vector;

    -- purpose: Dot product of two vectors
  function dot (l, r : complex_vector) return complex;
  function dot (l, r : complex_polar_vector) return complex_polar;

  -- purpose: cross product
  function cross (l, r : complex_matrix) return complex_matrix;
  function cross (l, r : complex_vector) return complex_vector;
  function cross (l, r : complex_polar_matrix) return complex_polar_matrix;
  function cross (l, r : complex_polar_vector) return complex_polar_vector;

  -- Kronecker product.
  function kron (l, r : complex_matrix) return complex_matrix;
  function kron (l, r : complex_polar_matrix) return complex_polar_matrix;

  -- purpose: Finds the determinant of a matrix
  function det (arg : complex_matrix) return complex;
  function det (arg : complex_polar_matrix) return complex_polar;

  -- purpose: Inverts a matrix
  function inv (arg : complex_matrix) return complex_matrix;
  function inv (arg : complex_polar_matrix) return complex_polar_matrix;

  -- Solve a linear equation
  function linsolve (l : complex_matrix; r : complex_vector) return complex_vector;
  function linsolve (l : complex_polar_matrix; r : complex_polar_vector) return complex_polar_vector;

  -- Normalize a Matrix
  function normalize (arg : complex_matrix; constant rval : REAL := 1.0)
    return complex_matrix;
  function normalize (arg : complex_vector; constant rval : REAL := 1.0)
    return complex_vector;
  function normalize (arg : complex_polar_matrix; constant rval : REAL := 1.0)
    return complex_polar_matrix;
  function normalize (arg : complex_polar_vector; constant rval : REAL := 1.0)
    return complex_polar_vector;

  -- Evaluate the polynomial
  -- no "poly" functions because "**" is not in math_complex

  -----------------------------------------------------------------------------
  -- These functions manipulate the data in a matrix non mathematically
  -----------------------------------------------------------------------------

  -- purpose: Returns "true" if a matrix or vector is null.
  function isempty (arg : complex_matrix) return BOOLEAN;
  function isempty (arg : complex_vector) return BOOLEAN;
  function isempty (arg : complex_polar_matrix) return BOOLEAN;
  function isempty (arg : complex_polar_vector) return BOOLEAN;

  -- purpose: Transpose a matrix (Similar to Matlab A' syntax)
  function transpose (arg : complex_matrix) return complex_matrix;
  function transpose (arg : complex_vector) return complex_matrix;
  function transpose (arg : complex_matrix) return complex_vector;
  function transpose (arg : complex_polar_matrix) return complex_polar_matrix;
  function transpose (arg : complex_polar_vector) return complex_polar_matrix;
  function transpose (arg : complex_polar_matrix) return complex_polar_vector;

  -- purpose: Complex Conjugate transpose a matrix (Similar to Matlab A' syntax)
  function ctranspose (arg : complex_matrix) return complex_matrix;
  function ctranspose (arg : complex_vector) return complex_matrix;
  function ctranspose (arg : complex_matrix) return complex_vector;
  function ctranspose (arg : complex_polar_matrix) return complex_polar_matrix;
  function ctranspose (arg : complex_polar_vector) return complex_polar_matrix;
  function ctranspose (arg : complex_polar_matrix) return complex_polar_vector;

  -- purpose: returns a matrix of zeros
  function zeros (rows, columns : NATURAL) return complex_matrix;
  function zeros (rows, columns : NATURAL) return complex_polar_matrix;
  function zeros (rows, columns : NATURAL) return complex_vector;
  function zeros (rows, columns : NATURAL) return complex_polar_vector;
  -- purpose: returns a matrix of ones
  function ones (rows, columns : NATURAL) return complex_matrix;
  function ones (rows, columns : NATURAL) return complex_polar_matrix;
  function ones (rows, columns : NATURAL) return complex_vector;
  function ones (rows, columns : NATURAL) return complex_polar_vector;
  -- purpose: Returns an identity matrix
  function eye (rows, columns : NATURAL) return complex_matrix;
  function eye (rows, columns : NATURAL) return complex_polar_matrix;

  -- Puts two matrices together to form one
  function cat (
    dim  : POSITIVE;                    -- 1 = y, 2 = x
    l, r : complex_matrix)
    return complex_matrix;
  function horzcat (l, r : complex_matrix) return complex_matrix;
  function vertcat (l, r : complex_matrix) return complex_matrix;
  function cat (
    dim  : POSITIVE;                    -- 1 = y, 2 = x
    l, r : complex_polar_matrix)
    return complex_polar_matrix;
  function horzcat (l, r : complex_polar_matrix) return complex_polar_matrix;
  function vertcat (l, r : complex_polar_matrix) return complex_polar_matrix;

  -- Rotate a matrix
  function flipdim (
    arg          : complex_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return complex_matrix;
  function fliplr (arg : complex_matrix) return complex_matrix;
  function flipup (arg : complex_matrix) return complex_matrix;
  function fliplr (arg : complex_vector) return complex_vector;
  function rot90 (
    arg          : complex_matrix;
    constant dim : INTEGER := 1)
    return complex_matrix;
  function flipdim (
    arg          : complex_polar_matrix;
    constant dim : POSITIVE := 1)       -- 1 = y, 2 = x
    return complex_polar_matrix;
  function fliplr (arg : complex_polar_matrix) return complex_polar_matrix;
  function flipup (arg : complex_polar_matrix) return complex_polar_matrix;
  function fliplr (arg : complex_polar_vector) return complex_polar_vector;
  function rot90 (
    arg          : complex_polar_matrix;
    constant dim : INTEGER := 1)
    return complex_polar_matrix;

  -----------------------------------------------------------------------------
  -- These functions allow you to do matrix and vector slicing
  -----------------------------------------------------------------------------

  -- returns an rows/columns matrix from position x,y in the input matrix
  function SubMatrix (
    arg                    : complex_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)  -- rows and columns in new matrix
    return complex_matrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : complex_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)  -- rows and columns in new matrix
    return complex_vector;

  -- Places the matrix "arg" at location X,Y in matrix "result"
  procedure BuildMatrix (
    arg           : in    complex_matrix;
    result        : inout complex_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    complex_vector;
    result        : inout complex_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    complex_vector;
    result        : inout complex_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- purpose: SubMatrix returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : complex_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return complex_matrix;

  -- returns an rows/columns matrix from position x,y in the input matrix
  function SubMatrix (
    arg                    : complex_polar_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)  -- rows and columns in new matrix
    return complex_polar_matrix;

  -- returns an rows/columns matrix from position l,r in the input matrix
  function SubMatrix (
    arg                    : complex_polar_matrix;
    constant x, y          : NATURAL;   -- index into the matrix
    constant rows, columns : NATURAL)  -- rows and columns in new matrix
    return complex_polar_vector;

  -- Places the matrix "arg" at location X,Y in matrix "result"
  procedure BuildMatrix (
    arg           : in    complex_polar_matrix;
    result        : inout complex_polar_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "x" axis starting
  -- at x,y
  procedure BuildMatrix (
    arg           : in    complex_polar_vector;
    result        : inout complex_polar_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- Places the vector "arg" into matrix "result" along "y" axis starting
  -- at x,y
  procedure InsertColumn (
    arg           : in    complex_polar_vector;
    result        : inout complex_polar_matrix;
    constant x, y : in    NATURAL);     -- index into the matrix

  -- purpose: SubMatrix returns a matrix with 1 less row and column
  -- Used by determinant function
  function exclude (
    arg                  : complex_polar_matrix;
    constant row, column : NATURAL)     -- row and column to exclude
    return complex_polar_matrix;

  -- Uses the elements of the input matrix to create one of a new shape
  function reshape (
    arg           : complex_matrix;
    rows, columns : POSITIVE)
    return complex_matrix;

  function reshape (
    arg           : complex_vector;
    rows, columns : POSITIVE)
    return complex_matrix;

  function reshape (
    arg           : complex_matrix;
    rows, columns : POSITIVE)
    return complex_vector;

  function reshape (
    arg           : complex_polar_matrix;
    rows, columns : POSITIVE)
    return complex_polar_matrix;

  function reshape (
    arg           : complex_polar_vector;
    rows, columns : POSITIVE)
    return complex_polar_matrix;

  function reshape (
    arg           : complex_polar_matrix;
    rows, columns : POSITIVE)
    return complex_polar_vector;

  -- returns the size of a matrix
  function size (arg      : complex_matrix) return integer_vector;
  function size (arg      : complex_polar_matrix) return integer_vector;
  -- True if matrix is one dimensional
  function isvector (arg  : complex_matrix) return BOOLEAN;
  function isvector (arg  : complex_polar_matrix) return BOOLEAN;
  -- True if a 1/1 matrix
  function isscalar (arg  : complex_matrix) return BOOLEAN;
  function isscalar (arg  : complex_polar_matrix) return BOOLEAN;
  -- returns the number of elements in a matrix
  function numel (arg     : complex_matrix) return INTEGER;
  function numel (arg     : complex_polar_matrix) return INTEGER;
  -- Return the diagonal of a matrix
  function diag (arg      : complex_matrix) return complex_vector;
  function diag (arg      : complex_polar_matrix) return complex_polar_vector;
  -- Return a matrix with the vector as the diagonal
  function diag (arg      : complex_vector) return complex_matrix;
  function diag (arg      : complex_polar_vector) return complex_polar_matrix;
  -- Return the matrix of a diagonal
  function blkdiag (arg   : complex_vector) return complex_matrix;
  function blkdiag (arg   : complex_polar_vector) return complex_polar_matrix;
  -- Creates a block diagonal matrix from "arg", repeated "rep" times
  function blockdiag (arg : complex_matrix; rep : POSITIVE)
    return complex_matrix;
  function blockdiag (arg : complex_polar_matrix; rep : POSITIVE)
    return complex_polar_matrix;
  -- Creates a matrix set to the value "val"
  function repmat (
    arg                    : complex;
    constant rows, columns : NATURAL)
    return complex_matrix;
  function repmat (
    arg                    : complex_polar;
    constant rows, columns : NATURAL)
    return complex_polar_matrix;
  function repmat (
    arg                    : complex;
    constant rows, columns : NATURAL)
    return complex_vector;
  function repmat (
    arg                    : complex_polar;
    constant rows, columns : NATURAL)
    return complex_polar_vector;

  -- Replicate a matrix row/column times
  function repmat (
    arg                    : complex_matrix;
    constant rows, columns : NATURAL)
    return complex_matrix;
  function repmat (
    arg                    : complex_polar_matrix;
    constant rows, columns : NATURAL)
    return complex_polar_matrix;

  -- Return the lower triangle of a matrix
  function tril (arg : complex_matrix) return complex_matrix;
  function tril (arg : complex_polar_matrix) return complex_polar_matrix;
  -- Return the upper triangle of a matrix
  function triu (arg : complex_matrix) return complex_matrix;
  function triu (arg : complex_polar_matrix) return complex_polar_matrix;

  -----------------------------------------------------------------------------
  -- TextIO functions
  -----------------------------------------------------------------------------
  -- Since there is no textio for the math_complex package, put it here.
  function to_string (value : complex) return STRING;
  function to_string (value : complex_polar) return STRING;
  procedure write (
    L      : inout LINE;
    VALUE  : in    complex;
    DIGITS : in    POSITIVE := 4);
  procedure write (
    L      : inout LINE;
    VALUE  : in    complex_polar;
    DIGITS : in    POSITIVE := 4);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex;
                 GOOD  : out   BOOLEAN);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar;
                 GOOD  : out   BOOLEAN);

  -- Functions for matrix I/O
  function to_string (value : complex_vector) return STRING;
  function to_string (value : complex_matrix) return STRING;
  function to_string (value : complex_polar_vector) return STRING;
  function to_string (value : complex_polar_matrix) return STRING;

  procedure write (
    L      : inout LINE;
    VALUE  : in    complex_vector;
    DIGITS : in    POSITIVE := 4);
  procedure write (
    L      : inout LINE;
    VALUE  : in    complex_matrix;
    DIGITS : in    POSITIVE := 4);
  procedure write (
    L      : inout LINE;
    VALUE  : in    complex_polar_vector;
    DIGITS : in    POSITIVE := 4);
  procedure write (
    L      : inout LINE;
    VALUE  : in    complex_polar_matrix;
    DIGITS : in    POSITIVE := 4);

  procedure READ(L     : inout LINE;
                 VALUE : out   complex_vector);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex_matrix);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar_vector);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar_matrix);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex_vector;
                 GOOD  : out   BOOLEAN);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex_matrix;
                 GOOD  : out   BOOLEAN);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar_vector;
                 GOOD  : out   BOOLEAN);
  procedure READ(L     : inout LINE;
                 VALUE : out   complex_polar_matrix;
                 GOOD  : out   BOOLEAN);

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in complex_matrix;
    index : in BOOLEAN := false);

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in complex_vector;
    index : in BOOLEAN := false);

  -- purpose: Prints out a matrix
  procedure print_matrix (
    arg   : in complex_polar_matrix;
    index : in BOOLEAN := false);

  -- purpose: Prints out a vector
  procedure print_vector (
    arg   : in complex_polar_vector;
    index : in BOOLEAN := false);

end package complex_matrix_pkg;
