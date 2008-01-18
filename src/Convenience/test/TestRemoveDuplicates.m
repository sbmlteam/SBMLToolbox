function fail = TestRemoveDuplicates
% RemoveDuplicates takes any array and returns it with any duplicates removed


%  Filename    :   TestRemoveDuplicates.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
%  Revision    :   $Id$
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


input1 = [1, 3, 4, 3, 1, 5];
output1 = [1, 3, 4, 5];

input2 = 'adasfeds';
output2 = 'adsfe';

fail = TestFunction('RemoveDuplicates', 1, 1, input1, output1);
fail = fail + TestFunction('RemoveDuplicates', 1, 1, input2, output2);
