function fail = TestisIntegralNumber
%
%   isIntegralNumber 
%             takes a number n
%             and returns 1 if it is an integer 0 otherwise
%
%       NOTE: MATLAB's isinteger is only true if the number has been
%       declared as an int; whereas the default type for numbers in MATLAB
%       is double
%
%       value = isIntegralNumber(number)


%  Filename    :   TestisIntegralNumber.m
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


a = 2;
b = 3.5;

fail = TestFunction('isIntegralNumber', 1, 1, a, 1);
fail = fail + TestFunction('isIntegralNumber', 1, 1, b, 0);
