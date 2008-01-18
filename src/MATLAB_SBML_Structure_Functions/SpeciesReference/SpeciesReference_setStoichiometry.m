function SBMLSpeciesReference = SpeciesReference_setStoichiometry(SBMLSpeciesReference, stoichiometry)
%
%   SpeciesReference_setStoichiometry 
%             takes  1) an SBMLSpeciesReference structure 
%             and    2) an number representing the stoichiometry to be set
%                   NOTE: in Level 1 models stoichiometry must be an integer
%
%             and returns 
%               the speciesreference with the stoichiometry set
%
%       SBMLSpeciesReference = SpeciesReference_setStoichiometry(SBMLSpeciesReference, stoichiometry)

%  Filename    :   SpeciesReference_setStoichiometry.m
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
if (~isstruct(SBMLSpeciesReference))
    error(sprintf('%s', ...
      'argument must be an SBML SpeciesReference structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLSpeciesReference);

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'SpeciesReference_setStoichiometry(SBMLSpeciesReference, stoichiometry)', 'first argument must be an SBML model structure'));
elseif ((sbmlLevel ~= 2) &&(~isIntegralNumber(stoichiometry)))
    error(sprintf('SpeciesReference_setStoichiometry(SBMLSpeciesReference, stoichiometry)\n%s', 'second argument must be an integer in level 1 models'));
end;

if (sbmlLevel == 1)
    stoichiometry = int32(stoichiometry);
end;

SBMLSpeciesReference.stoichiometry = stoichiometry;
