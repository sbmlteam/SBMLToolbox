function SBMLFunctionDefinition = FunctionDefinition_setName(SBMLFunctionDefinition, name)
%
%   FunctionDefinition_setName 
%             takes  1) an SBMLFunctionDefinition structure 
%             and    2) a string representing the name to be set
%
%             and returns 
%               the functionDefinition with the name set
%
%       SBMLFunctionDefinition = FunctionDefinition_setName(SBMLFunctionDefinition, 'name')

%  Filename    :   FunctionDefinition_setName.m
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
if (~isstruct(SBMLFunctionDefinition))
  error(sprintf('%s\n%s', ...
    'FunctionDefinition_setName(SBMLFunctionDefinition, name)', ...
    'first argument must be an SBML functionDefinition structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLFunctionDefinition);

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'FunctionDefinition_setName(SBMLFunctionDefinition, name)', 'first argument must be an SBML functionDefinition structure'));
elseif (~ischar(name))
    error(sprintf('FunctionDefinition_setName(SBMLFunctionDefinition, name)\n%s', 'second argument must be a string representing the name of the functionDefinition'));
end;

SBMLFunctionDefinition.name = name;
