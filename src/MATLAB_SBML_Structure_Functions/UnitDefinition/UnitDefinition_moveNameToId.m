function SBMLUnitDefinition = UnitDefinition_moveNameToId(SBMLUnitDefinition)
%
%   UnitDefinition_moveNameToId 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               the model with name moved to the id field 
%               (unless the id field is already set)
%
%       SBMLUnitDefinition = UnitDefinition_moveNameToId(SBMLUnitDefinition)

%  Filename    :   UnitDefinition_moveNameToId.m
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
    error(sprintf('%s\n%s', 'UnitDefinition_moveNameToId(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'UnitDefinition_moveNameToId(SBMLUnitDefinition)', 'no id field in a level 1 model'));    
end;

if (~UnitDefinition_isSetId(SBMLUnitDefinition))
    name = UnitDefinition_getName(SBMLUnitDefinition);
    SBMLUnitDefinition = UnitDefinition_setId(SBMLUnitDefinition, name);
    SBMLUnitDefinition = UnitDefinition_setName(SBMLUnitDefinition, '');
end;
