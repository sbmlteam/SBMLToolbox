function y = Species_isAssignedByRule(SBMLSpecies, SBMLRules)
% Species_isAssignedByRule takes an SBMLSpecies structure and an array of SBMLRule structures
% and returns
%             0 if the species is not assigned by a rule
%             n if the species occurs as the species field of a SPECIES_CONCENTRATION_RULE
%                                  or as the variable field of an ASSIGNMENT_RULE
%     where n refers to the index of the matched rule in the array

%  Filename    :   Species_isAssignedByRule.m
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

 
y = 0;

%-------------------------------------------------------------------
% check input arguments are as expected
if (~isstruct(SBMLSpecies))
    error(sprintf('%s', ...
      'argument must be an SBML Species structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLSpecies);

if (~isSBML_Species(SBMLSpecies, sbmlLevel, sbmlVersion))
  error('Species_isAssignedByRule(SBMLSpecies, SBMLRules)\n%s', 'first argument must be an SBMLSpecies structure');
end;


NumRules = length(SBMLRules);

if (NumRules < 1)
    error('Species_isAssignedByRule(SBMLSpecies, SBMLRules)\n%s', 'SBMLRule structure is empty');
else
    for i = 1:NumRules
        if (~isSBML_Rule(SBMLRules(i), sbmlLevel, sbmlVersion))
            error('Species_isAssignedByRule(SBMLSpecies, SBMLRules)\n%s', 'second argument must be an array of SBMLRule structures');
        end;
    end;
end;

%--------------------------------------------------------------------------

% loop through each rule and check whether the species is assigned by it
%determine the name or id of the species
if (sbmlLevel == 1)
    name = SBMLSpecies.name;
else
    if (isempty(SBMLSpecies.id))
        name = SBMLSpecies.name;
    else
        name = SBMLSpecies.id;
    end;
end;

for i = 1:NumRules
    if (strcmp(SBMLRules(i).typecode, 'SBML_ASSIGNMENT_RULE'))
        if (strcmp(SBMLRules(i).variable, name))
            % once found return as cannot occur more than once
            y = i;
            return;
        end;
    elseif ((strcmp(SBMLRules(i).typecode, 'SBML_SPECIES_CONCENTRATION_RULE')) & (strcmp(SBMLRules(i).type, 'scalar')))
        if (strcmp(SBMLRules(i).species, name))
            y = i;
            return;
        end;
    end;
end;

