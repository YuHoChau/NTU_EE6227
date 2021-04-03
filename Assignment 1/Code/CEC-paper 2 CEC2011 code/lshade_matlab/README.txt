Author: Ryoji Tanabe
Date: 9/Jun/2014

###
Update:
9/Oct/2014: incompatibilities-fix between Octave and Matlab and bug-fix of population size reduction procedure (thanks to Dr. Elsayed)

###
This package is a MATLAB/Octave source code of L-SHADE 1.0.1.
Please note that this source code is transferred from the C++ source code of L-SHADE 1.0.1.
Where, the version submitted to the competition (version 1.0.0) had a bug in the archive update mechanism which resulted in a slight performance degradation.
Version 1.0.1 fixes the bug and achieves slightly better performance compared to 1.0.0.

See the details of L-SHADE in the following paper:

* Ryoji Tanabe and Alex Fukunaga: Improving the Search Performance of SHADE Using Linear Population Size Reduction,  Proc. IEEE Congress on Evolutionary Computation (CEC-2014), Beijing, July, 2014.

For this package, we downloaded JADE's source code from Dr. Q. Zhang's website (http://dces.essex.ac.uk/staff/qzhang) and modified it.
###
System configurations in our experimental environment:

OS: Ubuntu 12.04 LTS
CPU: core i7 (2.20GHz)
RAM: 8GB
Language: Octave/Matlab

###
How to execute:

Step 1. generate cec14_func.mex as "mex cec14_func.cpp"
(For Windows, comment out "#include <WINDOWS.H>" in cec14_func.cpp and "mex cec14_func.cpp -DWINDOWS")
Step 2. execute lshade.m

###
Dimension size and parameter settings of the algorithm are easily changeable by rewriting source code in "lshade.m"
If you have any questions, please feel free to contact me (rt.ryoji.tanabe@gmail.com).
