function SBMLUnit = Unit_setKind(SBMLUnit, kind)
%
%   Unit_setKind 
%             takes  1) an SBMLUnit structure 
%             and    2) a string representing the kind to be set
%
%             and returns 
%               the unit with the kind set
%
%       SBMLUnit = Unit_setKind(SBMLUnit, 'kind')

%  Filename    :   Unit_setKind.m
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
    error(sprintf('%s\n%s', 'Unit_setKind(SBMLUnit, kind)', 'first argument must be an SBML unit structure'));
elseif (~ischar(kind) || (~isValidUnitKind(kind)))
    error(sprintf('Unit_setKind(SBMLUnit, kind)\n%s', 'second argument must be a string representing the kind of the unit'));
end;

SBMLUnit.kind = kind;
