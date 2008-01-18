function unit = UnitDefinition_getUnit(SBMLUnitDefinition, number)
%
%   UnitDefinition_getUnit 
%             takes  1) an SBMLUnitDefinition structure 
%             and    2) a number n
%
%             and returns 
%               the nth unit structure defined within the unitDefinition
%
%       unit = UnitDefinition_getUnit(SBMLUnitDefinition, number)

%  Filename    :   UnitDefinition_getUnit.m
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
if (~isstruct(SBMLUnitDefinition))
    error(sprintf('%s', ...
      'argument must be an SBML UnitDefinition structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLUnitDefinition);

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'UnitDefinition_getUnit(SBMLUnitDefinition, number)', 'first argument must be an SBML unitDefinition structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'UnitDefinition_getUnit(SBMLUnitDefinition, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLUnitDefinition.unit))
    unit = [];
else
    unit = SBMLUnitDefinition.unit(number);
end;
