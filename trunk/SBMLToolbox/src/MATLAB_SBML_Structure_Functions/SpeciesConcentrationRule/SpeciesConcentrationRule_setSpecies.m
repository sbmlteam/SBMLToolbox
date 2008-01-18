function SBMLSpeciesConcentrationRule = SpeciesConcentrationRule_setSpecies(SBMLSpeciesConcentrationRule, species)
%
%   SpeciesConcentrationRule_setSpecies 
%             takes  1) an SBMLSpeciesConcentrationRule structure 
%             and    2) a string representing the species to be set
%
%             and returns 
%               the speciesConcentrationRule with the species set
%
%       SBMLSpeciesConcentrationRule = SpeciesConcentrationRule_setSpecies(SBMLSpeciesConcentrationRule, 'species')

%  Filename    :   SpeciesConcentrationRule_setSpecies.m
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
if (~isstruct(SBMLSpeciesConcentrationRule))
    error(sprintf('%s', ...
      'argument must be an SBML SpeciesConcentrationRule structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLSpeciesConcentrationRule);

if (~isSBML_SpeciesConcentrationRule(SBMLSpeciesConcentrationRule, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'SpeciesConcentrationRule_setSpecies(SBMLSpeciesConcentrationRule, species)', 'first argument must be an SBML speciesConcentrationRule structure'));
elseif (~ischar(species))
    error(sprintf('SpeciesConcentrationRule_setSpecies(SBMLSpeciesConcentrationRule, species)\n%s', 'second argument must be a string representing the species of the speciesConcentrationRule'));
end;

SBMLSpeciesConcentrationRule.species = species;
