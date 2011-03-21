% toolbox\MATLAB_SBML_Structure_Functions\MODEL
%
% Files
%   Model_addCompartment                      - Model_addCompartment 
%   Model_addEvent                            - Model_addEvent 
%   Model_addFunctionDefinition               - Model_addFunctionDefinition 
%   Model_addParameter                        - Model_addParameter 
%   Model_addReaction                         - Model_addReaction 
%   Model_addRule                             - Model_addRule 
%   Model_addSpecies                          - Model_addSpecies 
%   Model_addUnitDefinition                   - Model_addUnitDefinition 
%   Model_create                              - Model_create 
%   Model_createAssignmentRule                - Model_createAssignmentRule 
%   Model_createCompartment                   - Model_createCompartment 
%   Model_createCompartmentVolumeRule         - Model_createCompartmentVolumeRule 
%   Model_createEvent                         - Model_createEvent 
%   Model_createEventAssignment               - Model_createEventAssignment 
%   Model_createFunctionDefinition            - Model_createFunctionDefinition 
%   Model_createKineticLaw                    - Model_createKineticLaw 
%   Model_createKineticLawParameter           - Model_createKineticLawParameter 
%   Model_createModifier                      - Model_createModifier 
%   Model_createParameter                     - Model_createParameter 
%   Model_createParameterRule                 - Model_createParameterRule 
%   Model_createProduct                       - Model_createProduct 
%   Model_createRateRule                      - Model_createRateRule 
%   Model_createReactant                      - Model_createReactant 
%   Model_createReaction                      - Model_createReaction 
%   Model_createSpecies                       - Model_createSpecies 
%   Model_createSpeciesConcentrationRule      - Model_createSpeciesConcentrationRule 
%   Model_createUnit                          - Model_createUnit 
%   Model_createUnitDefinition                - Model_createUnitDefinition 
%   Model_getCompartment                      - Model_getCompartment 
%   Model_getCompartmentById                  - Model_getCompartmentById 
%   Model_getEvent                            - Model_getEvent 
%   Model_getEventById                        - Model_getEventById 
%   Model_getFunctionDefinition               - Model_getFunctionDefinition 
%   Model_getFunctionDefinitionById           - Model_getFunctionDefinitionById 
%   Model_getFunctionIds                      - Model_getFunctionIds 
%   Model_getId                               - Model_getId 
%   Model_getListOfByTypecode                 - Model_getListOfByTypecode 
%   Model_getListOfCompartments               - Model_getListOfCompartments 
%   Model_getListOfEvents                     - Model_getListOfEvents 
%   Model_getListOfFunctionDefinitions        - Model_getListOfFunctionDefinitions 
%   Model_getListOfParameters                 - Model_getListOfParameters 
%   Model_getListOfReactions                  - Model_getListOfReactions 
%   Model_getListOfRules                      - Model_getListOfRules 
%   Model_getListOfSpecies                    - Model_getListOfSpecies 
%   Model_getListOfUnitDefinitions            - Model_getListOfUnitDefinitions 
%   Model_getName                             - Model_getName 
%   Model_getNumCompartments                  - Model_getNumCompartments 
%   Model_getNumEvents                        - Model_getNumEvents 
%   Model_getNumFunctionDefinitions           - Model_getNumFunctionDefinitions
%   Model_getNumParameters                    - Model_getNumParameters 
%   Model_getNumReactions                     - Model_getNumReactions 
%   Model_getNumRules                         - Model_getNumRules 
%   Model_getNumSpecies                       - Model_getNumSpecies 
%   Model_getNumSpeciesWithBoundaryCondition  - Model_getNumSpeciesWithBoundaryCondition 
%   Model_getNumUnitDefinitions               - Model_getNumUnitDefinitions 
%   Model_getParameter                        - Model_getParameter 
%   Model_getParameterById                    - Model_getParameterById 
%   Model_getReaction                         - Model_getReaction 
%   Model_getReactionById                     - Model_getReactionById 
%   Model_getRule                             - Model_getRule 
%   Model_getSpecies                          - Model_getSpecies 
%   Model_getSpeciesById                      - Model_getSpeciesById 
%   Model_getSpeciesNamesAndInitialValues     - Model_getSpeciesNamesAndInitialValues takes a SBMLModel 
%   Model_getUnitDefinition                   - Model_getUnitDefinition 
%   Model_getUnitDefinitionById               - Model_getUnitDefinitionById 
%   Model_isSetId                             - Model_isSetId 
%   Model_isSetName                           - Model_isSetName 
%   Model_moveAllIdsToNames                   - Model_moveAllIdsToNames 
%   Model_moveAllNamesToIds                   - Model_moveAllNamesToIds 
%   Model_moveIdToName                        - Model_moveIdToName 
%   Model_moveNameToId                        - Model_moveNameToId 
%   Model_setId                               - Model_setId 
%   Model_setName                             - Model_setName 
%   Model_unsetId                             - Model_unsetId 
%   Model_unsetName                           - Model_unsetName 
%
%   ADDITIONAL TO libSBML API
%
%   Model_determineRateLawsFromReactions      - Model_determineRateLawsFromReactions  
%   Model_determineRateLawsFromRules          - Model_determineRateLawsFromRules 
%   Model_getAllParameterNamesAndValues       - Model_getAllParameterNamesAndValues 
%   Model_getAllParameterUniqueNamesAndValues - Model_getAllParameterUniqueNamesAndValues 
%   Model_getGlobalParameterNamesAndValues    - Model_getGlobalParameterNamesAndValues 
%   Model_getListOfAlgebraicRules             - Model_getListOfAlgebraicRules
%   Model_getListOfAssignmentRules            - Model_getListOfAssignmentRules 
%   Model_getListOfRateRules                  - Model_getListOfRateRules 
%   Model_getNumAlgebraicRules                - Model_getNumAlgebraicRules 
%   Model_getNumAssignmentRules               - Model_getNumAssignmentRules
%   Model_getNumRateRules                     - Model_getNumRateRules 

%  Filename    :   Contents.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
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

