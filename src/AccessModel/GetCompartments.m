function varargout = GetCompartments(SBMLModel)
% GetCompartments takes a SBMLModel 
% and returns 
%           1) an array of character names of all compartments within the model 
%           2) an array of the size/volume values of each compartment
%

%--------------------------------------------------------------------------
%
%  Filename    : GetCompartments.m
%  Description : takes a SBMLModel and returns an array of character names representing all compartments 
%                   and an array of the initial values of each compartment
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
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
    error('GetCompartments(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%------------------------------------------------------------
% determine the number of compartments within the model
NumCompartments = length(SBMLModel.compartment);

%------------------------------------------------------------
% loop through the list of compartments
for i = 1:NumCompartments

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

    % and array of the character names
    CharArray{i} = name;

    % get the volume/size
    % add to an array
    if (SBMLModel.SBML_level == 1)
        Values(i) = SBMLModel.compartment(i).volume;
    else
        Values(i) = SBMLModel.compartment(i).size;
    end;

    AR = Model_getAssignmentRuleByVariable(SBMLModel, name);
    if (~isempty(AR))
        newSBMLModel = SBMLModel;
        newSBMLModel.compartment(i) = [];
        for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
          newFormula = SubstituteFunction(AR.formula, Model_getFunctionDefinition(SBMLModel, fd));
          if (~isempty(newFormula))
           AR.formula = newFormula;
          end;
        end;
        Values(i) = Substitute(AR.formula, newSBMLModel);  
    end;
      
    % might be an initial assignment in l2v2
    if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)
      IA = Model_getInitialAssignmentBySymbol(SBMLModel, name);
      if (~isempty(IA))
        % remove this from the substtution
        newSBMLModel = SBMLModel;
        newSBMLModel.compartment(i) = [];
        for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
          newFormula = SubstituteFunction(IA.math, Model_getFunctionDefinition(SBMLModel, fd));
          if (~isempty(newFormula))
           IA.math = newFormula;
          end;
        end;
        Values(i) = Substitute(IA.math, newSBMLModel);  
      end;
    end;
end;

%--------------------------------------------------------------------------
% assign output

if (NumCompartments ~= 0)
    varargout{1} = CharArray;
    varargout{2} = Values;
else
    varargout{1} = [];
    varargout{2} = [];
end;
