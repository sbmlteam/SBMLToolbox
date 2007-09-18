function varargout = GetStoichiometryMatrix(SBMLModel)
% GetStoichiometryMatrix takes an SBML model 
% and returns 
%       1) stoichiometry matrix
%       2) an array of character names of all species within the model 
%           (in the order in which the matrix deals with them)

%--------------------------------------------------------------------------

%
%  Filename    : GetStoichiometryMatrix.m
%  Description : takes a SBMLModel and returns the stoichiometry matrix
%                   and an array of character names representing all species 
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
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
%
% GetStoichiometryMatrix(SBMLModel) takes an SBML model 
% returns 
%       1) stoichiometry matrix
%       2) an array of character names of all species within the model 
%--------------------------------------------------------------------------

% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('GetStoichiometryMatrix(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%------------------------------------------------------------
% determine the number of species and reactions
NumSpecies = length(SBMLModel.species);
NumReactions = length(SBMLModel.reaction);

%--------------------------------------------------------------------------
% for each species loop through each reaction and determine whether the species
% takes part and in what capacity

for i = 1:NumSpecies

    %determine which reactions it occurs within
    for j = 1:NumReactions

        SpeciesRole = Species_determineRoleInReaction(SBMLModel.species(i), SBMLModel.reaction(j));

        if (sum(SpeciesRole) == 0)
            % not in this reaction
            StoichiometryMatrix(i,j) = 0;
            TotalOccurences = 0;
        else

            % record numbers of occurences of species as reactant/product
            % and check that we can deal with reaction

            NoReactants = SpeciesRole(2);
            NoProducts =  SpeciesRole(1);
            TotalOccurences = NoReactants + NoProducts;

            %--------------------------------------------------------------
            % check that a species does not occur twice on one side of the
            % reaction
            if (NoReactants > 1 || NoProducts > 1)
                error('GetStoichiometryMatrix(SBMLModel)\n%s', 'SPECIES OCCURS MORE THAN ONCE ON ONE SIDE OF REACTION');
            end;


        end;

        % species has been found in this reaction
        while (TotalOccurences > 0) %

            if(NoProducts > 0)
                stoichiometry = SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometry/double(SBMLModel.reaction(j).product(SpeciesRole(4)).denominator);
                if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath)))
                    error('GetStoichiometryMatrix(SBMLModel)\n%s', 'stoichiometry has been entered as a formula');
                end;
                StoichiometryMatrix(i,j) = stoichiometry;
                NoProducts = NoProducts - 1;
            elseif (NoReactants > 0)
                stoichiometry = SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometry/double(SBMLModel.reaction(j).reactant(SpeciesRole(5)).denominator);
                if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath)))
                    error('GetStoichiometryMatrix(SBMLModel)\n%s', 'stoichiometry has been entered as a formula');
                end;
                StoichiometryMatrix(i,j) = - stoichiometry;
                NoReactants = NoReactants - 1;
            end;
            TotalOccurences = TotalOccurences - 1;

        end; % while found > 0

    end; % for NumReactions

end; % for NumSpecies

%--------------------------------------------------------------------------
% assign outputs

varargout{1} = StoichiometryMatrix;
varargout{2} = GetSpecies(SBMLModel);
