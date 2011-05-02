function value = isIntegralNumber(number)
% isIntegralNumber takes a number n 
%       and returns 
%           1 if it is an integer 
%           0 otherwise (maybe of MATLAB type double)
%
%       NOTE: MATLAB's 'isinteger' function only returns true if the number 
%       has been declared as an int; whereas the default type for numbers 
%       in MATLAB is double
%


%  Filename    :   isIntegralNumber.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   09-Feb-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->


value = 0;

integerClasses = {'int8', 'uint8', 'int16', 'uint16', 'int32', 'uint32', 'int64', 'uint64'};

% since the function isinteger does not exist in MATLAB Rel 13
% this is not used
%if (isinteger(number))
if (ismember(class(number), integerClasses))
    value = 1;
elseif (isnumeric(number))
    % if it is an integer 
    if (number == fix(number))
        value = 1;
    end;
end;


