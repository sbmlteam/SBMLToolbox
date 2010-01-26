function RunTest

%  Filename    :   RunTest.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->

cd ..;
cd AccessModel;
cd Test;
disp('Performing tests in AccessModel directory');
test_am;
cd ..;

% NEED work to get these to pass in octave
v = ver('symbolic');
% only run if symbolic toolbox is intalled
if (~isempty(v) && isoctave == '0')
  cd ..;
  cd AccessToSymbols;
  cd Test;
  disp('Performing tests in AccessToSymbols directory');
  RunTest;
  cd ..;
end;

cd ..;
cd Convenience;
cd Test;
disp('Performing tests in Convenience directory');
test_conv;
cd ..;

cd ..;
cd MATLAB_SBML_Structure_Functions;
cd Test;
disp('Performing tests in MATLAB_SBML_Structure_Functions directory');
TestCreate;
cd ..;

cd ..;
cd Simulation;
cd Test;
disp('Performing tests in Simulation directory');
test_sim;
cd ..;

cd ..;
cd Validate_MATLAB_SBML_Structures;
cd Test;
disp('Performing tests in Validate_MATLAB_SBML_Structures directory');
test_valid;
cd ..;

cd ..;
cd Test;

TestOutput;
