function [Compartment, InitialAssignment] = GetSymbolicCompartmentInitialAssignment(SBMLModel)
% GetSymbolicCompartmentInitialAssignment takes an SBMLModel 
% and returns
%             1) an array of compartment symbols
%             2) an array of the symbolic representation of the
%             initial assignment for each compartment assigned by an
%             initialAssignment

%--------------------------------------------------------------------------
%
%  Filename    : GetSymbolicCompartmentAssignmentRules.m
%  Description : takes a SBMLModel and returns assignments
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-12-06
%  Revision    : $Id$
%  Source      : $Source $
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


% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('GetSymbolicCompartmentInitialAssignment(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

if (SBMLModel.SBML_level < 2 || SBMLModel.SBML_version < 2)
    error('GetSymbolicCompartmentInitialAssignment(SBMLModel)\n%s', ...
    'no initialAssignments before SBML L2V2');
end;

%--------------------------------------------------------------
            
% get information from the model
NumberCompartment = length(SBMLModel.compartment);
InitialAssign = Model_getListOfInitialAssignments(SBMLModel);
NumInitialAssign = Model_getNumInitialAssignments(SBMLModel);

% for each compartment loop through each initial assignment and determine whether the compartment
% takes part and in what capacity

for i = 1:NumberCompartment
    %determine the name or id of the compartment
    if (SBMLModel.SBML_level == 1)
        name = SBMLModel.compartment(i).name;
    else
        if (isempty(SBMLModel.compartment(i).id))
            name = SBMLModel.compartment(i).name;
        else
            name = SBMLModel.compartment(i).id;
        end;
    end;
    
    % create a symbol from the name
    % save into an array of symbols
    % and array of the character names
    Compartment(i) = sym(name);

    output = '';
    symOut = sym(output);
 
    if (NumInitialAssign > 0)
       IA = Model_getInitialAssignmentBySymbol(SBMLModel, SBMLModel.compartment(i).id);
      if (~isempty(IA))
       for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
          newFormula = SubstituteFunction(IA.math, Model_getFunctionDefinition(SBMLModel, fd));
         if (~isempty(newFormula))
           IA.math = newFormula;
         end;
       end;
        symOut = charFormula2sym(IA.math);
       else
        symOut = sym('0');
       end;

    end;
 
    % finished looking for this compartment
     InitialAssignment{i} = symOut;
    
end; % for NumCompartment
