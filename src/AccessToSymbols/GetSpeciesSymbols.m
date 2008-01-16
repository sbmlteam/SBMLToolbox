function varargout = GetSpeciesSymbols(SBMLModel)
% GetSpeciesSymbols takes an SBMLModel 
% and returns 
%           1) an array of symbols representing all species within the model 
%           2) an array of the initial concentration/amount values of each species
%           3) an array of character names of the symbols
%
% NOTE: if the initial concentrations are not set then the value NaN is used


%--------------------------------------------------------------------------
%
%  Filename    : GetSpeciesSymbols.m
%  Description : GetSpeciesSymbols takes a SBMLModel 
%           and returns 1) an array of symbols representing all species within the model 
%                       2) an array of the initial concentration values of each species
%                       3) an array of character names of the symbols
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
    error('GetSpeciesSymbols(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%------------------------------------------------------------
% determine the number of species within the model
NumSpecies = length(SBMLModel.species);

%------------------------------------------------------------
% loop through the list of species
for i = 1:NumSpecies
    
    %determine the name or id of the species
    if (SBMLModel.SBML_level == 1)
        name = SBMLModel.species(i).name;
    else
        if (isempty(SBMLModel.species(i).id))
            name = SBMLModel.species(i).name;
        else
            name = SBMLModel.species(i).id;
        end;
    end;
    
    % create a symbol from the species name
    % save into an array of species symbols
    % and array of the character names
    SymbolArray(i) = sym(name);
    
    CharArray{i} = name;
    
    % get the initial concentration values
    % add to an array
    Values(i) = SBMLModel.species(i).initialAmount;
    
    if (SBMLModel.SBML_level == 2)
        if (SBMLModel.species(i).isSetInitialConcentration)
            Values(i) = SBMLModel.species(i).initialConcentration;
        end;
    end;
    % might be an initial assignment in l2v2
    if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)
      IA = Model_getInitialAssignmentBySymbol(SBMLModel, SBMLModel.species(i).id);
      if (~isempty(IA))
        % remove this from the substtution
        newSBMLModel = SBMLModel;
        newSBMLModel.species(i) = [];
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

if (NumSpecies ~= 0)
    varargout{1} = SymbolArray;
    varargout{2} = Values;
    varargout{3} = CharArray;
else
    varargout{1} = [];
    varargout{2} = [];
    varargout{3} = [];
end;
