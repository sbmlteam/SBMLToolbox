function SBMLSpecies = Species_setSpatialSizeUnits(SBMLSpecies, spatialSizeUnits)
%
%   Species_setSpatialSizeUnits 
%             takes  1) an SBMLSpecies structure 
%             and    2) a string representing the spatialSizeUnits to be set
%
%             and returns 
%               the species with the spatialSizeUnits set
%
%       SBMLSpecies = Species_setSpatialSizeUnits(SBMLSpecies, 'spatialSizeUnits')

%  Filename    :   Species_setSpatialSizeUnits.m
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
    error(sprintf('%s\n%s', 'Species_setSpatialSizeUnits(SBMLSpecies, spatialSizeUnits)', 'first argument must be an SBML species structure'));
elseif (~ischar(spatialSizeUnits))
    error(sprintf('Species_setSpatialSizeUnits(SBMLSpecies, spatialSizeUnits)\n%s', 'second argument must be a string representing the spatialSizeUnits of the species'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setSpatialSizeUnits(SBMLSpecies, spatialSizeUnits)', 'no spatialSizeUnits field in a level 1 model'));    
end;

SBMLSpecies.spatialSizeUnits = spatialSizeUnits;
