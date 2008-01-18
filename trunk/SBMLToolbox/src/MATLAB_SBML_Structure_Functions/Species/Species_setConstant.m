function SBMLSpecies = Species_setConstant(SBMLSpecies, constant)
%
%   Species_setConstant 
%             takes  1) an SBMLSpecies structure 
%             and    2) an integer representing the constant to be set
%
%             and returns 
%               the species with the constant set
%
%       SBMLSpecies = Species_setConstant(SBMLSpecies, constant)

%  Filename    :   Species_setConstant.m
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
    error(sprintf('%s\n%s', 'Species_setConstant(SBMLSpecies, constant)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(constant)) || (constant < 0) || (constant > 1))
    error(sprintf('Species_setConstant(SBMLSpecies, constant)\n%s', 'second argument must be either true (=1) or false (=0) representing whether the species is constant'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setConstant(SBMLSpecies, constant)', 'no constant field in a level 1 model'));    
end;

SBMLSpecies.constant = int32(constant);
