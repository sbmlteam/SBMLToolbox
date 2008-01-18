function SBMLUnit = Unit_setOffset(SBMLUnit, offset)
%
%   Unit_setOffset 
%             takes  1) an SBMLUnit structure 
%             and    2) the offset to be set
%
%             and returns 
%               the unit with the offset set
%
%       SBMLUnit = Unit_setOffset(SBMLUnit, offset)

%  Filename    :   Unit_setOffset.m
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
    error(sprintf('%s\n%s', 'Unit_setOffset(SBMLUnit, offset)', 'first argument must be an SBML unit structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Unit_setOffset(SBMLUnit, offset)', 'no offset field in a level 1 model'));    
elseif (~isnumeric(offset))
    error(sprintf('%s\n%s', 'Unit_setOffset(SBMLUnit, offset)', 'second argument must be a number representing the offset'));        
end;

SBMLUnit.offset = offset;
