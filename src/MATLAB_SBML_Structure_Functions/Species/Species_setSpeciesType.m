function SBMLSpecies = Species_setSpeciesType(SBMLSpecies, speciesType)
%
%   Species_setSpeciesType 
%             takes  1) an SBMLSpecies structure 
%             and    2) an string representing the speciesType to be set
%
%             and returns 
%               the Species with the speciesType set
%
%       SBMLSpecies = Species_setSpeciesType(SBMLSpecies, speciesType)

%  Filename    :   Species_setSpeciesType.m
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
  error(sprintf('%s\n%s', ...
    'Species_setSpeciesType(SBMLSpecies, speciesType)', ...
    'first argument must be an SBML Species structure'));
elseif (~ischar(speciesType))
    error(sprintf('%s\n%s', ...
      'Species_setSpeciesType(SBMLSpecies, speciesType)', ...
      'second argument must be a string representing the speciesType'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'Species_setSpeciesType(SBMLSpecies, speciesType)',  ...
      'speciesType field only in level 2 version 2/3 model'));    
end;

SBMLSpecies.speciesType = speciesType;
