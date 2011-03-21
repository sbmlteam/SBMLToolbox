function [Species, RateLaws] = GetSymbolicRateLawsFromRules(SBMLModel)
% GetSymbolicRateLawsFromRules takes an SBMLModel 
% and returns 
%       1)array of species symbols
%       2)an array of symbolic representations of the rate law for each species
%--------------------------------------------------------------------------

%
%  Filename    : GetSymbolicRateLawsFromRules.m
%  Description : takes a SBMLModel and returns rate laws
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-11-12
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
    error('GetSymbolicRateLawsFromRules(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%--------------------------------------------------------------
            
% get information from the model
Species = GetSpecies(SBMLModel);
NumberSpecies = length(SBMLModel.species);
RateRules = Model_getListOfRateRules(SBMLModel);
NumRateRules = Model_getNumRateRules(SBMLModel);

% for each species loop through each reaction and determine whether the species
% takes part and in what capacity

for i = 1:NumberSpecies
    output = '';
    symOut = sym(output);
 
    % if species is constant in level 2
    % concentration cannot be changed by a rate rule
    boundary = SBMLModel.species(i).boundaryCondition;
    if (SBMLModel.SBML_level == 2)
        constant = SBMLModel.species(i).constant;
    else
        constant = -1;
    end;
    
    if (constant == 1)
        symOut = sym('0');
    else
        
        %determine which rules it occurs within 
        j = 0;
        while (j <NumRateRules)
         
            if ((strcmp(Species(i), RateRules(j+1).variable)) | (strcmp(Species(i), RateRules(j+1).species)))
                Formula = RateRules(j+1).formula;
                if (SBMLModel.SBML_level > 1)
                  for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
                    newFormula = SubstituteFunction(Formula, Model_getFunctionDefinition(SBMLModel, fd));
                    if (~isempty(newFormula))
                      Formula = newFormula;
                    end;
                  end;
                end;
                
                symOut = charFormula2sym(Formula);
                break;
            else
                j = j + 1;
            end;
           
        end; % while NumRateRules
        
    end; % if constant
    
    
    % finished looking for this species
    % record rate law and loop to next species
    % rate = 0 if no law found
    if (isempty(symOut))
        RateLaws(i) = sym('0');
    else
        RateLaws(i) = symOut;
    end;
    
end; % for NumSpecies

Species = GetSpeciesSymbols(SBMLModel);
