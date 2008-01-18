function id = SpeciesReference_getId(SBMLSpeciesReference)
%
%   SpeciesReference_getId 
%             takes an SBMLSpeciesReference structure 
%
%             and returns 
%               the id of the speciesReference as an integer
%
%       id = SpeciesReference_getId(SBMLSpeciesReference)

%  Filename    :   SpeciesReference_getId.m
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
    error(sprintf('%s\n%s', ...
      'SpeciesReference_getId(SBMLSpeciesReference)', ...
      'argument must be an SBML SpeciesReference structure'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'SpeciesReference_getId(SBMLSpeciesReference)', ...
      'id field only in level 2 version 2/3 model'));    
end;

id = SBMLSpeciesReference.id;
