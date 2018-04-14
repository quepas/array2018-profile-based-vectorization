#!/bin/sh
r2013a=/usr/local/MATLAB/R2013a/bin/matlab
#r2014b=/usr/local/MATLAB/R2014b/bin/matlab
r2015b=/usr/local/MATLAB/R2015b/bin/matlab
#r2016b=/usr/local/MATLAB/R2016b/bin/matlab
#r2017a=/usr/local/MATLAB/R2017a/bin/matlab
r2017b=/usr/local/MATLAB/R2017b/bin/matlab

matlapOps="-nodesktop -nodisplay -nosplash -noFigureWindows"

echo "R2013a"
echo "R2013a::BACKPROP"
$r2013a $matlapOps -r "cd('loops/backprop');run backprop1.m;quit"
$r2013a $matlapOps -r "cd('loops/backprop');run backprop2.m;quit"
$r2013a $matlapOps -r "cd('loops/backprop');run backprop3.m;quit"
$r2013a $matlapOps -r "cd('loops/backprop');run backprop4.m;quit"
echo "R2013a::CAPR"
$r2013a $matlapOps -r "cd('loops/capr');run capr1.m;quit"
$r2013a $matlapOps -r "cd('loops/capr');run capr2.m;quit"
$r2013a $matlapOps -r "cd('loops/capr');run capr3.m;quit"
echo "R2013a::CRNI"
$r2013a $matlapOps -r "cd('loops/crni');run crni1.m;quit"
$r2013a $matlapOps -r "cd('loops/crni');run crni2.m;quit"
$r2013a $matlapOps -r "cd('loops/crni');run crni3.m;quit"
echo "R2013a::FFT"
$r2013a $matlapOps -r "cd('loops/fft');run fft1.m;quit"
$r2013a $matlapOps -r "cd('loops/fft');run fft2.m;quit"
echo "R2013a::NW"
$r2013a $matlapOps -r "cd('loops/nw');run nw1.m;quit"
$r2013a $matlapOps -r "cd('loops/nw');run nw2.m;quit"
$r2013a $matlapOps -r "cd('loops/nw');run nw3.m;quit"
echo "R2013a::PAGERANK"
$r2013a $matlapOps -r "cd('loops/pagerank');run pagerank1.m;quit"
echo "R2013a::SPMV"
$r2013a $matlapOps -r "cd('loops/spmv');run spmv1.m;quit"

echo "R2015b"
echo "R2015b::BACKPROP"
$r2015b $matlapOps -r "cd('loops/backprop');run backprop1.m;quit"
$r2015b $matlapOps -r "cd('loops/backprop');run backprop2.m;quit"
$r2015b $matlapOps -r "cd('loops/backprop');run backprop3.m;quit"
$r2015b $matlapOps -r "cd('loops/backprop');run backprop4.m;quit"
echo "R2015b::CAPR"
$r2015b $matlapOps -r "cd('loops/capr');run capr1.m;quit"
$r2015b $matlapOps -r "cd('loops/capr');run capr2.m;quit"
$r2015b $matlapOps -r "cd('loops/capr');run capr3.m;quit"
echo "R2015b::CRNI"
$r2015b $matlapOps -r "cd('loops/crni');run crni1.m;quit"
$r2015b $matlapOps -r "cd('loops/crni');run crni2.m;quit"
$r2015b $matlapOps -r "cd('loops/crni');run crni3.m;quit"
echo "R2015b::FFT"
$r2015b $matlapOps -r "cd('loops/fft');run fft1.m;quit"
$r2015b $matlapOps -r "cd('loops/fft');run fft2.m;quit"
echo "R2015b::NW"
$r2015b $matlapOps -r "cd('loops/nw');run nw1.m;quit"
$r2015b $matlapOps -r "cd('loops/nw');run nw2.m;quit"
$r2015b $matlapOps -r "cd('loops/nw');run nw3.m;quit"
echo "R2015b::PAGERANK"
$r2015b $matlapOps -r "cd('loops/pagerank');run pagerank1.m;quit"
echo "R2015b::SPMV"
$r2015b $matlapOps -r "cd('loops/spmv');run spmv1.m;quit"

echo "R2017b"
echo "R2017b::BACKPROP"
$r2017b $matlapOps -r "cd('loops/backprop');run backprop1.m;quit"
$r2017b $matlapOps -r "cd('loops/backprop');run backprop2.m;quit"
$r2017b $matlapOps -r "cd('loops/backprop');run backprop3.m;quit"
$r2017b $matlapOps -r "cd('loops/backprop');run backprop4.m;quit"
echo "R2017b::CAPR"
$r2017b $matlapOps -r "cd('loops/capr');run capr1.m;quit"
$r2017b $matlapOps -r "cd('loops/capr');run capr2.m;quit"
$r2017b $matlapOps -r "cd('loops/capr');run capr3.m;quit"
echo "R2017b::CRNI"
$r2017b $matlapOps -r "cd('loops/crni');run crni1.m;quit"
$r2017b $matlapOps -r "cd('loops/crni');run crni2.m;quit"
$r2017b $matlapOps -r "cd('loops/crni');run crni3.m;quit"
echo "R2017b::FFT"
$r2017b $matlapOps -r "cd('loops/fft');run fft1.m;quit"
$r2017b $matlapOps -r "cd('loops/fft');run fft2.m;quit"
echo "R2017b::NW"
$r2017b $matlapOps -r "cd('loops/nw');run nw1.m;quit"
$r2017b $matlapOps -r "cd('loops/nw');run nw2.m;quit"
$r2017b $matlapOps -r "cd('loops/nw');run nw3.m;quit"
echo "R2017b::PAGERANK"
$r2017b $matlapOps -r "cd('loops/pagerank');run pagerank1.m;quit"
echo "R2017b::SPMV"
$r2017b $matlapOps -r "cd('loops/spmv');run spmv1.m;quit"
