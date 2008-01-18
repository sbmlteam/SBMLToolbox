function FunctionIds = Model_getFunctionIds(SBMLModel)
%
%   Model_getFunctionIds 
%             takes  an SBMLModel structure 
%
%             and returns 
%               an array of the ids of all functionDefinitions within the
%               model
%
%       FunctionIds = Model_getFunctionIds(SBMLModel)

%  Filename    :   Model_getFunctionIds.m
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



%-------------------------------------------------------------------
% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('Model_getFunctionIds(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;
   
FunctionIds = {};
if (SBMLModel.SBML_level == 2)
    for i = 1:length(SBMLModel.functionDefinition)
        FunctionIds{i} = SBMLModel.functionDefinition(i).id;
    end;
end;

