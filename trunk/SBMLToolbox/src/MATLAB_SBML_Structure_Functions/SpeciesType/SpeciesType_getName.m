function name = SpeciesType_getName(SBMLSpeciesType)
%
%   SpeciesType_getName 
%             takes an SBMLSpeciesType structure 
%
%             and returns 
%               the name of the SpeciesType as a string
%
%       name = SpeciesType_getName(SBMLSpeciesType)

%  Filename    :   SpeciesType_getName.m
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
if (~isstruct(SBMLSpeciesType))
    error(sprintf('%s\n%s', ...
      'SpeciesType_getName(SBMLSpeciesType)', ...
      'argument must be an SBML SpeciesType structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLSpeciesType);

if (~isSBML_SpeciesType(SBMLSpeciesType, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', ...
      'SpeciesType_getName(SBMLSpeciesType)', ...
      'argument must be an SBML SpeciesType structure'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'SpeciesType_getName(SBMLSpeciesType)', ...
      'name field only in level 2 version 2/3 model'));    
end;

name = SBMLSpeciesType.name;
