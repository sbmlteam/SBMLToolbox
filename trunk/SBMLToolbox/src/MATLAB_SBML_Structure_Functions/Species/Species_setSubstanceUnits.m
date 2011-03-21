function SBMLSpecies = Species_setSubstanceUnits(SBMLSpecies, substanceUnits)
%
%   Species_setSubstanceUnits 
%             takes  1) an SBMLSpecies structure 
%             and    2) a string representing the substanceUnits to be set
%
%             and returns 
%               the species with the substanceUnits set
%
%       SBMLSpecies = Species_setSubstanceUnits(SBMLSpecies, 'substanceUnits')

%  Filename    :   Species_setSubstanceUnits.m
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
if (~isstruct(SBMLSpecies))
    error(sprintf('%s', ...
      'argument must be an SBML Species structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLSpecies);

if (~isSBML_Species(SBMLSpecies, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Species_setSubstanceUnits(SBMLSpecies, substanceUnits)', 'first argument must be an SBML species structure'));
elseif (~ischar(substanceUnits))
    error(sprintf('Species_setSubstanceUnits(SBMLSpecies, substanceUnits)\n%s', 'second argument must be a string representing the substanceUnits of the species'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setSubstanceUnits(SBMLSpecies, substanceUnits)', 'no substanceUnits field in a level 1 model'));    
end;

SBMLSpecies.substanceUnits = substanceUnits;
