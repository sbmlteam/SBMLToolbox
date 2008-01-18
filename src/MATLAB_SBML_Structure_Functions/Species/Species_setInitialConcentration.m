function SBMLSpecies = Species_setInitialConcentration(SBMLSpecies, initialConcentration)
%
%   Species_setInitialConcentration 
%             takes  1) an SBMLSpecies structure 
%             and    2) a double representing the initialConcentration to be set
%
%             and returns 
%               the species with the initialConcentration set
%
%       SBMLSpecies = Species_setInitialConcentration(SBMLSpecies, initialConcentration)

%  Filename    :   Species_setInitialConcentration.m
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
    error(sprintf('%s\n%s', 'Species_setInitialConcentration(SBMLSpecies, initialConcentration)', 'first argument must be an SBML species structure'));
elseif(~isnumeric(initialConcentration))
    error(sprintf('%s\n%s', 'Species_setInitialConcentration(SBMLSpecies, initialConcentration)', 'second argument must be a number representing the initialConcentration')); 
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setInitialConcentration(SBMLSpecies, ,initialConcentration)', 'no initialConcentration field in a level 1 model'));    
end;

SBMLSpecies.initialConcentration = initialConcentration;
SBMLSpecies.isSetInitialConcentration = int32(1);

warning off all;
SBMLSpecies.initialAmount = 0/0;
SBMLSpecies.isSetInitialAmount = int32(0);
warning on all;