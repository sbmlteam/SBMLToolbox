function SBMLSpecies = Species_setHasOnlySubstanceUnits(SBMLSpecies, hasOnlySubstanceUnits)
%
%   Species_setHasOnlySubstanceUnits 
%             takes  1) an SBMLSpecies structure 
%             and    2) an integer representing the hasOnlySubstanceUnits to be set
%
%             and returns 
%               the species with the hasOnlySubstanceUnits set
%
%       SBMLSpecies = Species_setHasOnlySubstanceUnits(SBMLSpecies, hasOnlySubstanceUnits)

%  Filename    :   Species_setHasOnlySubstanceUnits.m
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
if (~isstruct(SBMLSpecies))
    error(sprintf('%s', ...
      'argument must be an SBML Species structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLSpecies);

if (~isSBML_Species(SBMLSpecies, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Species_setHasOnlySubstanceUnits(SBMLSpecies, hasOnlySubstanceUnits)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(hasOnlySubstanceUnits)) || (hasOnlySubstanceUnits < 0) || (hasOnlySubstanceUnits > 1))
    error(sprintf('Species_setHasOnlySubstanceUnits(SBMLSpecies, hasOnlySubstanceUnits)\n%s', 'second argument must be either true (=1) or false (=0) representing whether the species is hasOnlySubstanceUnits'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setHasOnlySubstanceUnits(SBMLSpecies, hasOnlySubstanceUnits)', 'no hasOnlySubstanceUnits field in a level 1 model'));    
end;

SBMLSpecies.hasOnlySubstanceUnits = int32(hasOnlySubstanceUnits);
