function [Species, InitialAssignment] = GetSymbolicSpeciesInitialAssignments(SBMLModel)
% GetSymbolicSpeciesInitialAssignment takes an SBMLModel 
% and returns
%             1) an array of species symbols
%             2) an array of the symbolic representation of the
%             initial assignment for each species assigned by an
%             initialAssignment

%--------------------------------------------------------------------------
%
%  Filename    : GetSymbolicSpeciesAssignmentRules.m
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

% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('GetSymbolicSpeciesInitialAssignment(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

if (SBMLModel.SBML_level < 2 || SBMLModel.SBML_version < 2)
    error('GetSymbolicSpeciesInitialAssignment(SBMLModel)\n%s', ...
    'no initialAssignments before SBML L2V2');
end;

%--------------------------------------------------------------
            
% get information from the model
NumberSpecies = length(SBMLModel.species);
InitialAssign = Model_getListOfInitialAssignments(SBMLModel);
NumInitialAssign = Model_getNumInitialAssignments(SBMLModel);

% for each species loop through each reaction and determine whether the species
% takes part and in what capacity

for i = 1:NumberSpecies
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
    
    % create a symbol from the name
    % save into an array of symbols
    % and array of the character names
    Species(i) = sym(name);

    output = '';
    symOut = sym(output);
 
    if (NumInitialAssign > 0)
        IA = Model_getInitialAssignmentBySymbol(SBMLModel, SBMLModel.species(i).id);
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
 
    % finished looking for this species
    InitialAssignment{i} = symOut;
    
end; % for NumSpecies
