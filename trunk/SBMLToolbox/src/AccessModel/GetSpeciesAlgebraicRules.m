function [Species, AlgebraicRules] = GetSpeciesAlgebraicRules(SBMLModel)
% GetSpeciesAlgebraicRules takes an SBMLModel 
% and returns
%             1) an array of species names
%             2) an array of the character representation of each algebraic
%                   rule the species appears in

%--------------------------------------------------------------------------
%
%  Filename    : GetSpeciesAlgebraicRules.m
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
    error('GetSpeciesAlgebraicRules(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%--------------------------------------------------------------

% get information from the model
Species = GetSpecies(SBMLModel);
NumberSpecies = length(SBMLModel.species);
Rules = Model_getListOfAlgebraicRules(SBMLModel);
NumRules = Model_getNumAlgebraicRules(SBMLModel);

for i = 1:NumberSpecies
    output = '';


    if (NumRules > 0)
        %determine which rules it occurs within
        RuleNo = Species_isInAlgebraicRule(SBMLModel.species(i), Rules);

        for j = 1:length(RuleNo)
            if (RuleNo(j) > 0)
                output{j} = Rules(RuleNo(j)).formula;
            end;
        end;
    end;



    % finished looking for this species
    % record rate law and loop to next species
    % rate = 0 if no law found
    if (isempty(output))
        AlgebraicRules{i} = '0';
    else
        AlgebraicRules{i} = output;
    end;
end; % for NumSpecies
