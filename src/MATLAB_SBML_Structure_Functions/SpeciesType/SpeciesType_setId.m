function SBMLSpeciesType = SpeciesType_setId(SBMLSpeciesType, id)
%
%   SpeciesType_setId 
%             takes  1) an SBMLSpeciesType structure 
%             and    2) an string representing the id to be set
%
%             and returns 
%               the Species with the id set
%
%       SBMLSpeciesType = SpeciesType_setId(SBMLSpeciesType, id)

%  Filename    :   SpeciesType_setId.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->



% check that input is correct
if (~isstruct(SBMLSpeciesType))
    error(sprintf('%s\n%s', ...
      'SpeciesType_getId(SBMLSpeciesType)', ...
      'argument must be an SBML SpeciesType structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLSpeciesType);

if (~isSBML_SpeciesType(SBMLSpeciesType, sbmlLevel, sbmlVersion))
  error(sprintf('%s\n%s', ...
    'SpeciesType_setId(SBMLSpeciesType, id)', ...
    'first argument must be an SBML SpeciesType structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', ...
      'SpeciesType_setId(SBMLSpeciesType, id)', ...
      'second argument must be a string representing the id'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'SpeciesType_setId(SBMLSpeciesType, id)',  ...
      'id field only in level 2 version 2/3 model'));    
end;

SBMLSpeciesType.id = id;
