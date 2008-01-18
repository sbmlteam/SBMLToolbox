function number = Model_getNumFunctionDefinitions(SBMLModel)
%
%   Model_getNumFunctionDefinitions
%             takes an SBMLModel structure 
%
%             and returns 
%               the number of function definition structures defined within the model
%
%       number = Model_getNumFunctionDefinitions(SBMLModel)

%  Filename    :   Model_getNumFunctionDefinitions.m
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
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getNumFunctionDefinitions(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getNumFunctionDefinitions(SBMLModel)', 'no function definitions in a level 1 model'));   
end;

number = 0;

if (~isempty(SBMLModel.functionDefinition))
    number = length(SBMLModel.functionDefinition);
end;
