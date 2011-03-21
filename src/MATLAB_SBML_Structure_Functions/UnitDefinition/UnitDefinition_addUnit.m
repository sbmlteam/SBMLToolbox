function unitDefinition = UnitDefinition_addUnit(SBMLUnitDefinition, SBMLUnit)
%
%   UnitDefinition_addUnit 
%             takes  1) an SBMLUnitDefinition structure 
%             and    2) an SBMLUnit structure
%
%             and returns 
%               the unitDefinition with the unit added
%
%       unitDefinition = UnitDefinition_addUnit(SBMLUnitDefinition, SBMLUnit)

%  Filename    :   UnitDefinition_addUnit.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
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



% check that input is correct
if (~isstruct(SBMLUnitDefinition))
    error(sprintf('%s', ...
      'argument must be an SBML UnitDefinition structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLUnitDefinition);

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'UnitDefinition_addUnit(SBMLUnitDefinition, SBMLUnit)', 'first argument must be an SBML unitDefinition structure'));
elseif (~isSBML_Unit(SBMLUnit, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s\n of the same SBML level, namely level %u', 'UnitDefinition_addUnit(SBMLUnitDefinition, SBMLUnit)', 'second argument must be an SBML unit structure', sbmlLevel));
end;

numberUnits = length(SBMLUnitDefinition.unit);

SBMLUnitDefinition.unit(numberUnits+1) = SBMLUnit;

unitDefinition = SBMLUnitDefinition;

