function [Species, RateLaws] = GetSymbolicRateLawsFromReactions(SBMLModel)
% GetSymbolicRateLawsFromReactions(SBMLModel) takes an SBML model 
% and returns 
%       1)array of species symbols
%       2)an array of symbolic representations of the rate law for each species
%           from reactions
%--------------------------------------------------------------------------

%
%  Filename    : GetSymbolicRateLawsFromReactions.m
%  Description : GetSymbolicRateLawsFromReactions(SBMLModel) takes an SBML model 
%           returns     1) array of species symbols
%                       2)an array of symbolic representations of the rate
%                       law for each species
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
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
    error('GetSymbolicRateLawsFromReactions(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%--------------------------------------------------------------
% determine the symbols representing the species 
Symbols = GetSpeciesSymbols(SBMLModel);

%------------------------------------------------------------
% determine the number of species and reactions
NumSpecies = length(SBMLModel.species);
NumReactions = length(SBMLModel.reaction);

%--------------------------------------------------------------------------
% for each species loop through each reaction and determine whether the species
% takes part and in what capacity

for i = 1:NumSpecies
    output = '';
    symOut = sym(output);
    
    % if species is a boundary condition (or constant in level 2
    % no rate law is required
    boundary = SBMLModel.species(i).boundaryCondition;
    if (SBMLModel.SBML_level == 2)
        constant = SBMLModel.species(i).constant;
    else
        constant = -1;
    end;
    
    if (boundary == 1)
        symOut = sym('0');
    elseif (constant ==1)
        symOut = sym('0');
    else
        
        %determine which reactions it occurs within 
        for j = 1:NumReactions
            
            SpeciesRole = Species_determineRoleInReaction(SBMLModel.species(i), SBMLModel.reaction(j));

            TotalOccurences = 0;
            % record numbers of occurences of species as reactant/product
            % and check that we can deal with reaction
            if (sum(SpeciesRole)>0)

                NoReactants = SpeciesRole(2);
                NoProducts =  SpeciesRole(1);
                TotalOccurences = NoReactants + NoProducts; 

                %--------------------------------------------------------------
                % check that a species does not occur twice on one side of the
                % reaction
                if (NoReactants > 1 || NoProducts > 1)
                    error('GetSymbolicRateLawsFromReactions(SBMLModel)\n%s', 'SPECIES OCCURS MORE THAN ONCE ON ONE SIDE OF REACTION');
                end;

                %--------------------------------------------------------------
                % check that reaction has a kinetic law formula
                if (isempty(SBMLModel.reaction(j).kineticLaw))
                    error('GetSymbolicRateLawsFromReactions(SBMLModel)\n%s', 'NO KINETC LAW SUPPLIED');
                end;
                %--------------------------------------------------------------


            end;
            
            % species has been found in this reaction
            while (TotalOccurences > 0) %
                % get names in order to make the parameter symbols unique
                Params = GetParameterSymbolsFromReaction(SBMLModel.reaction(j));
                ParamsUnique = GetParameterSymbolsFromReactionUnique(SBMLModel.reaction(j));
                Formula = LoseWhiteSpace(SBMLModel.reaction(j).kineticLaw.formula);
                if (SBMLModel.SBML_level > 1)
                  for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
                    newFormula = SubstituteFunction(Formula, Model_getFunctionDefinition(SBMLModel, fd));
                    if (~isempty(newFormula))
                      Formula = newFormula;
                    end;
                  end;
                end;
                % add the kinetic law to the output for this species
                if (isempty(symOut))
                    
                    if(NoProducts > 0)
                      if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)
                        stoichiometry = sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometry);
                      else
                        stoichiometry = sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometry/double(SBMLModel.reaction(j).product(SpeciesRole(4)).denominator));
                      end;
                        if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath)))
                          if (SBMLModel.SBML_version < 3)  
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath);
                          else
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath.math);
                          end;
                        end;
                        if (~isempty(Params))
                            symOut = sym(stoichiometry) * subs(charFormula2sym(Formula), Params, ParamsUnique);
                        else
                            symOut = sym(stoichiometry) * charFormula2sym(Formula);
                        end;
                        NoProducts = NoProducts - 1;
                    elseif (NoReactants > 0)
                      if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)
                        stoichiometry = sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometry);
                      else
                        stoichiometry = sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometry/double(SBMLModel.reaction(j).reactant(SpeciesRole(5)).denominator));
                      end;
                        if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath)))
                          if (SBMLModel.SBML_version < 3)
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath);
                          else
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath.math);
                          end;
                        end;
                        if (~isempty(Params))
                            symOut = - sym(stoichiometry) * subs(charFormula2sym(Formula), Params, ParamsUnique);
                        else
                            symOut = - sym(stoichiometry) * charFormula2sym(Formula);
                        end;
                        NoReactants = NoReactants - 1;
                    end;

                else
                    
                    if(NoProducts > 0) 
                      if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)
                        stoichiometry = sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometry);
                      else
                        stoichiometry = sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometry/double(SBMLModel.reaction(j).product(SpeciesRole(4)).denominator));
                      end;
                        if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath)))
                         if (SBMLModel.SBML_version < 3)
                           stoichiometry = charFormula2sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath);
                         else
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath.math);
                         end;
                        end;
                        if (~isempty(Params))
                            symOut = symOut + sym(stoichiometry) * subs(charFormula2sym(Formula), Params, ParamsUnique);
                        else
                            symOut = symOut + sym(stoichiometry) * charFormula2sym(Formula);
                        end;
                        NoProducts = NoProducts - 1;
                    elseif (NoReactants > 0) 
                      if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)
                        stoichiometry = sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometry);
                      else
                        stoichiometry = sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometry/double(SBMLModel.reaction(j).reactant(SpeciesRole(5)).denominator));
                      end;
                        if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath)))
                         if (SBMLModel.SBML_version < 3)
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath);
                         else
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath.math);
                         end;
                        end;
                        if (~isempty(Params))
                            symOut = symOut - sym(stoichiometry) * subs(charFormula2sym(Formula), Params, ParamsUnique);
                        else
                            symOut = symOut - sym(stoichiometry) * charFormula2sym(Formula);
                        end;
                        NoReactants = NoReactants - 1;
                    end; 
                    
                end; % isempty(output)
                
                TotalOccurences = TotalOccurences - 1;
                
            end; % while found > 0           
            
        end; % for NumReactions
        
    end; % if boundary condition
    

    % finished looking for this species
    % record rate law and loop to next species
    % rate = 0 if no law found
    if (isempty(symOut))
        symRateLaws(i) = sym('0');
    else
        symRateLaws(i) = symOut;
    end;
    
end; % for NumSpecies

%--------------------------------------------------------------------------
% assign outputs
Species = Symbols;
RateLaws = symRateLaws;
