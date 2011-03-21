function [Species, AlgebraicRules] = GetSymbolicSpeciesAlgebraicRules(SBMLModel)
% GetSymbolicSpeciesAlgebraicRules takes an SBMLModel 
% and returns
%             1) an array of species symbols
%             2) an array of the symbolic representation of each algebraic
%             rule the species appears in

%--------------------------------------------------------------------------
%
%  Filename    : GetSymbolicSpeciesAlgebraicRules.m
%  Description : takes a SBMLModel and returns assignments
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-12-06
%  Revision    : $Id$
%  Source      : $Source ,v $
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
    error('GetSymbolicSpeciesAlgebraicRules(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%--------------------------------------------------------------

% get information from the model
Species = GetSpeciesSymbols(SBMLModel);
NumberSpecies = length(SBMLModel.species);
Rules = Model_getListOfAlgebraicRules(SBMLModel);
NumRules = Model_getNumAlgebraicRules(SBMLModel);

for i = 1:NumberSpecies
    output = '';
    symOut = sym(output);

    if (NumRules > 0)
        %determine which rules it occurs within
        RuleNo = Species_isInAlgebraicRule(SBMLModel.species(i), Rules);

        for j = 1:length(RuleNo)
            if (RuleNo(j) > 0)
                Formula = Rules(RuleNo(j)).formula;
                if (SBMLModel.SBML_level > 1)
                  for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
                    newFormula = SubstituteFunction(Formula, Model_getFunctionDefinition(SBMLModel, fd));
                    if (~isempty(newFormula))
                      Formula = newFormula;
                    end;
                  end;
                end;
                symOut(j) = charFormula2sym(Formula);
            end;
        end;
    end;



    % finished looking for this species
    % record rate law and loop to next species
    % rate = 0 if no law found
%     if (isempty(symOut))
%         AlgebraicRules{i} = sym('0');
%     else
        AlgebraicRules{i} = symOut;
%     end;
end; % for NumSpecies
