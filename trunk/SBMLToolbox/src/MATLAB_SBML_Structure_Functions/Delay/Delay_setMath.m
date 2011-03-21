function SBMLDelay = Delay_setMath(SBMLDelay, math)
%
%   Delay_setMath 
%             takes  1) an SBMLDelay structure 
%             and    2) an string representing the math to be set
%
%             and returns 
%               the compartment with the math set
%
%       SBMLDelay = Delay_setMath(SBMLDelay, math)

%  Filename    :   Delay_setMath.m
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
if (~isstruct(SBMLDelay))
    error(sprintf('%s\n%s', ...
      'Delay_getMath(SBMLDelay)', ...
      'argument must be an SBML Delay structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLDelay);

if (~isSBML_Delay(SBMLDelay, sbmlLevel, sbmlVersion))
  error(sprintf('%s\n%s', ...
    'Delay_setMath(SBMLDelay, math)', ...
    'first argument must be an SBML Delay structure'));
elseif (~ischar(math))
    error(sprintf('%s\n%s', ...
      'Delay_setMath(SBMLDelay, math)', ...
      'second argument must be a string representing the math'));
elseif (sbmlLevel ~= 2 || sbmlVersion ~= 3)
    error(sprintf('%s\n%s', ...
      'Delay_setMath(SBMLDelay, math)',  ...
      'math field only in level 2 version 3 model'));    
end;

SBMLDelay.math = math;
