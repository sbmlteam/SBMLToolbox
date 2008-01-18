function value = FunctionDefinition_isSetName(SBMLFunctionDefinition)
%
%   FunctionDefinition_isSetName 
%             takes an SBMLFunctionDefinition structure 
%
%             and returns 
%               1 if the name has been set 
%               0 otherwise
%
%       value = FunctionDefinition_isSetName(SBMLFunctionDefinition)

%  Filename    :   FunctionDefinition_isSetName.m
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
    'FunctionDefinition_isSetName(SBMLFunctionDefinition)', ...
    'first argument must be an SBML functionDefinition structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLFunctionDefinition);

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'FunctionDefinition_isSetName(SBMLFunctionDefinition)', 'argument must be an SBML functionDefinition structure'));
end;

value = ~isempty(SBMLFunctionDefinition.name);
