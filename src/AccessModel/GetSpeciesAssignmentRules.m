function [Species, AssignmentRules] = GetSpeciesAssignmentRules(SBMLModel)
% GetSpeciesAssignmentRules takes an SBMLModel 
% and returns
%             1) an array of species names
%             2) an array of the character representation of the
%                   assignment rule used to assign value to each species 

%--------------------------------------------------------------------------
%
%  Filename    : GetSpeciesAssignmentRules.m
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
    error('GetSpeciesAssignmentRules(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%--------------------------------------------------------------
            
% get information from the model
Species = GetSpecies(SBMLModel);
NumberSpecies = length(SBMLModel.species);
AssignRules = Model_getListOfAssignmentRules(SBMLModel);
NumAssignRules = Model_getNumAssignmentRules(SBMLModel);

% for each species loop through each reaction and determine whether the species
% takes part and in what capacity

for i = 1:NumberSpecies
    output = '';
 
    % if species is constant in level 2
    % concentration cannot be changed by a rule
    boundary = SBMLModel.species(i).boundaryCondition;
    if (SBMLModel.SBML_level == 2)
        constant = SBMLModel.species(i).constant;
    else
        constant = -1;
    end;
    
    if (constant == 1)
        output = '0';
    else

        if (NumAssignRules > 0)
        %determine which rules it occurs within
        RuleNo = Species_isAssignedByRule(SBMLModel.species(i), AssignRules);
        if (RuleNo > 0)
            output = AssignRules(RuleNo).formula;

        end;
        end;

    end; % if constant


    % finished looking for this species
    % record rate law and loop to next species
    % rate = 0 if no law found
    if (isempty(output))
        AssignmentRules{i} = '0';
    else
        AssignmentRules{i} = output;
    end;
    
end; % for NumSpecies
