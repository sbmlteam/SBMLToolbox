function offset = Unit_getOffset(SBMLUnit)
%
%   Unit_getOffset 
%             takes an SBMLUnit structure 
%
%             and returns 
%               the offset of the unit as a double
%
%       offset = Unit_getOffset(SBMLUnit)

%  Filename    :   Unit_getOffset.m
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



% check that input is correct
if (~isstruct(SBMLUnit))
    error(sprintf('%s', ...
      'argument must be an SBML Unit structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLUnit);

if (~isSBML_Unit(SBMLUnit, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Unit_getOffset(SBMLUnit)', 'argument must be an SBML unit structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Unit_getOffset(SBMLUnit)', 'no offset field in a level 1 model'));    
end;

offset = SBMLUnit.offset;
