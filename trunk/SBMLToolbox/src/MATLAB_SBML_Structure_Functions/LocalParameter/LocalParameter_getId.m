function id = LocalParameter_getId(SBMLLocalParameter)
%
%   LocalParameter_getId 
%             takes an SBMLLocalParameter structure 
%
%             and returns 
%               the id of the parameter as a string
%
%       id = LocalParameter_getId(SBMLLocalParameter)

%  Filename    :   LocalParameter_getId.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: LocalParameter_getId.m 13259 2011-03-21 05:40:36Z mhucka $
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
    'LocalParameter_getId(SBMLLocalParameter)', ...
    'first argument must be an SBML LocalParameter structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLLocalParameter);

if (~isSBML_LocalParameter(SBMLLocalParameter, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'LocalParameter_getId(SBMLLocalParameter)', 'argument must be an SBML parameter structure'));
elseif (sbmlLevel ~= 3)
    error(sprintf('%s\n%s', 'LocalParameter_getId(SBMLLocalParameter)', 'no id field in a level 1 model'));    
end;

id = SBMLLocalParameter.id;
