function SBMLSpecies = Species_setCharge(SBMLSpecies, charge)
%
%   Species_setCharge 
%             takes  1) an SBMLSpecies structure 
%             and    2) an integer representing the charge to be set
%
%             and returns 
%               the species with the charge set
%
%       SBMLSpecies = Species_setCharge(SBMLSpecies, charge)

%  Filename    :   Species_setCharge.m
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
    error(sprintf('%s\n%s', 'Species_setCharge(SBMLSpecies, charge)', 'first argument must be an SBML model structure'));
elseif (~isIntegralNumber(charge))
    error(sprintf('Species_setCharge(SBMLSpecies, charge)\n%s', 'second argument must be an integer representing the charge of the species'));
end;

SBMLSpecies.charge = int32(charge);
SBMLSpecies.isSetCharge = int32(1);
