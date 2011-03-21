function SBMLFunctionDefinition = FunctionDefinition_setMath(SBMLFunctionDefinition, math)
%
%   FunctionDefinition_setMath 
%             takes  1) an SBMLFunctionDefinition structure 
%             and    2) a string representing the math to be set
%
%             and returns 
%               the functionDefinition with the math set
%
%       SBMLFunctionDefinition = FunctionDefinition_setMath(SBMLFunctionDefinition, 'math')

%  Filename    :   FunctionDefinition_setMath.m
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
if (~isstruct(SBMLFunctionDefinition))
  error(sprintf('%s\n%s', ...
    'FunctionDefinition_setMath(SBMLFunctionDefinition, math)', ...
    'first argument must be an SBML functionDefinition structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLFunctionDefinition);

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'FunctionDefinition_setMath(SBMLFunctionDefinition, math)', 'first argument must be an SBML functionDefinition structure'));
elseif (~ischar(math))
    error(sprintf('FunctionDefinition_setMath(SBMLFunctionDefinition, math)\n%s', 'second argument must be a string representing the math of the functionDefinition'));
end;

SBMLFunctionDefinition.math = math;
