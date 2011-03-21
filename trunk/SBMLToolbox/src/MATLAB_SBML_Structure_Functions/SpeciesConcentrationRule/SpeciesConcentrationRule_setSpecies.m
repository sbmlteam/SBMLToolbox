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
