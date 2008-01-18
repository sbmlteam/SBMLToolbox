function value = UnitDefinition_isSetName(SBMLUnitDefinition)
%
%   UnitDefinition_isSetName 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               1 if the name has been set 
%               0 otherwise
%
%       value = UnitDefinition_isSetName(SBMLUnitDefinition)

%  Filename    :   UnitDefinition_isSetName.m
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
    error(sprintf('%s\n%s', 'UnitDefinition_isSetName(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
end;

value = ~isempty(SBMLUnitDefinition.name);
