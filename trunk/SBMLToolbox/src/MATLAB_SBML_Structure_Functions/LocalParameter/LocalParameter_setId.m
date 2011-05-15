function SBMLLocalParameter = LocalParameter_setId(SBMLLocalParameter, id)
%
%   LocalParameter_setId 
%             takes  1) an SBMLLocalParameter structure 
%             and    2) a string representing the id to be set
%
%             and returns 
%               the parameter with the id set
%
%       SBMLLocalParameter = LocalParameter_setId(SBMLLocalParameter, 'id')

%  Filename    :   LocalParameter_setId.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: LocalParameter_setId.m 13259 2011-03-21 05:40:36Z mhucka $
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
if (~isstruct(SBMLLocalParameter))
  error(sprintf('%s\n%s', ...
    'LocalParameter_setId(SBMLLocalParameter)', ...
    'first argument must be an SBML LocalParameter structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLLocalParameter);

if (~isSBML_LocalParameter(SBMLLocalParameter, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'LocalParameter_setId(SBMLLocalParameter, id)', 'first argument must be an SBML parameter structure'));
elseif (~ischar(id))
    error(sprintf('LocalParameter_setId(SBMLLocalParameter, id)\n%s', 'second argument must be a string representing the id of the parameter'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'LocalParameter_setId(SBMLLocalParameter, id)', 'no id field in a level 1 model'));    
end;

SBMLLocalParameter.id = id;
