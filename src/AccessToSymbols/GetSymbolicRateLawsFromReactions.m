function [Species, RateLaws] = GetSymbolicRateLawsFromReactions(SBMLModel)
% GetSymbolicRateLawsFromReactions(SBMLModel) takes an SBML model 
% and returns 
%       1)array of species symbols
%       2)an array of symbolic representations of the rate law for each species
%           from rules
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
%  Copyright 2003 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Centre
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):
%
% GetSymbolicRateLawsFromReactions(SBMLModel) takes an SBML model 
% returns 
%       1)array of species symbols
%       2)an array of symbolic representations of the rate law for each species
%--------------------------------------------------------------------------

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
                
                % add the kinetic law to the output for this species
                if (isempty(symOut))
                    
                    if(NoProducts > 0)
                        stoichiometry = sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometry/double(SBMLModel.reaction(j).product(SpeciesRole(4)).denominator));
                        if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath)))
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath);
                        end;
                        if (~isempty(Params))
                            symOut = sym(stoichiometry) * subs(charFormula2sym(SBMLModel.reaction(j).kineticLaw.formula), Params, ParamsUnique);
                        else
                            symOut = sym(stoichiometry) * charFormula2sym(SBMLModel.reaction(j).kineticLaw.formula);
                        end;
                        NoProducts = NoProducts - 1;
                    elseif (NoReactants > 0)
                        stoichiometry = sym(double(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometry)/double(SBMLModel.reaction(j).reactant(SpeciesRole(5)).denominator));
                        if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath)))
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath);
                        end;
                        if (~isempty(Params))
                            symOut = - sym(stoichiometry) * subs(charFormula2sym(SBMLModel.reaction(j).kineticLaw.formula), Params, ParamsUnique);
                        else
                            symOut = - sym(stoichiometry) * charFormula2sym(SBMLModel.reaction(j).kineticLaw.formula);
                        end;
                        NoReactants = NoReactants - 1;
                    end;

                else
                    
                    if(NoProducts > 0) 
                         stoichiometry = sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometry/double(SBMLModel.reaction(j).product(SpeciesRole(4)).denominator));
                        if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath)))
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath);
                        end;
                        if (~isempty(Params))
                            symOut = symOut + sym(stoichiometry) * subs(charFormula2sym(SBMLModel.reaction(j).kineticLaw.formula), Params, ParamsUnique);
                        else
                            symOut = symOut + sym(stoichiometry) * charFormula2sym(SBMLModel.reaction(j).kineticLaw.formula);
                        end;
                        NoProducts = NoProducts - 1;
                    elseif (NoReactants > 0) 
                        stoichiometry = sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometry/double(SBMLModel.reaction(j).reactant(SpeciesRole(5)).denominator));
                        if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath)))
                            stoichiometry = charFormula2sym(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath);
                        end;
                        if (~isempty(Params))
                            symOut = symOut - sym(stoichiometry) * subs(charFormula2sym(SBMLModel.reaction(j).kineticLaw.formula), Params, ParamsUnique);
                        else
                            symOut = symOut - sym(stoichiometry) * charFormula2sym(SBMLModel.reaction(j).kineticLaw.formula);
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