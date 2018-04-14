Needleman-Wunsch
================

Needleman-Wunsch is an algorithm for calculating optimal global alignment of two
DNA sequences. All-pairs matching is represented by an NxM 2D matrix. Matrix
cells are scored from northwestern-most to southeastern-most, depending solely
on northern, northeastern, and eastern neighboring scores. Finally, the
algorithm backtracks through the array to return an optimal alignment.

Note: This application was ported from the Rodinia Suite
      (https://www.cs.virginia.edu/~skadron/wiki/rodinia/).