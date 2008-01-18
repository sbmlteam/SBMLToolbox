function SBMLSpecies = Species_setBoundaryCondition(SBMLSpecies, boundaryCondition)
%
%   Species_setBoundaryCondition 
%             takes  1) an SBMLSpecies structure 
%             and    2) an integer representing the boundaryCondition to be set
%
%             and returns 
%               the species with the boundaryCondition set
%
%       SBMLSpecies = Species_setBoundaryCondition(SBMLSpecies, boundaryCondition)

%  Filename    :   Species_setBoundaryCondition.m
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
    error(sprintf('%s\n%s', 'Species_setBoundaryCondition(SBMLSpecies, boundaryCondition)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(boundaryCondition)) || (boundaryCondition < 0) || (boundaryCondition > 1))
    error(sprintf('Species_setBoundaryCondition(SBMLSpecies, boundaryCondition)\n%s', 'second argument must be either true (=1) or false (=0) representing whether the species is boundaryCondition'));
end;

SBMLSpecies.boundaryCondition = int32(boundaryCondition);
