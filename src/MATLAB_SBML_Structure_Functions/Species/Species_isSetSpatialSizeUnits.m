function value = Species_isSetSpatialSizeUnits(SBMLSpecies)
%
%   Species_isSetSpatialSizeUnits 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               1 if the spatialSizeUnits has been set 
%               0 otherwise
%
%       value = Species_isSetSpatialSizeUnits(SBMLSpecies)

%  Filename    :   Species_isSetSpatialSizeUnits.m
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
    error(sprintf('%s\n%s', 'Species_isSetSpatialSizeUnits(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_isSetSpatialSizeUnits(SBMLSpecies)', 'no spatialSizeUnits field in a level 1 model'));    
end;

value = ~isempty(SBMLSpecies.spatialSizeUnits);