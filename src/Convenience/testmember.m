function value = testmember (num, array)
% testmember takes a value and an array of values 
%       and returns 
%           1 if value is a member of the array 
%           0 otherwise
% 
% NOTE: this function is necessary for octave to emulate the MATLAB
%       functionality of the 'ismember' function


%  Filename    :   testmember.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:  
%  Created     :   
%  Revision    :   $Id: $
%  Source      :   $Source v $
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


value = 0;

[m, n] = size(array);

for i=1:m
  for j=1:n
    if (num == array(m,n))
	    value = 1;
	    return;
	  end;
  end;
end;

