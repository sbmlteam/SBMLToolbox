% toolbox\MATLAB_SBML_Structure_Functions\REACTION
%
% Files
%   Reaction_addModifier                      - Reaction_addModifier 
%   Reaction_addProduct                       - Reaction_addProduct 
%   Reaction_addReactant                      - Reaction_addReactant 
%   Reaction_create                           - Reaction_create 
%   Reaction_getFast                          - Reaction_getFast 
%   Reaction_getId                            - Reaction_getId 
%   Reaction_getKineticLaw                    - Reaction_getKineticLaw 
%   Reaction_getListOfModifiers               - Reaction_getListOfModifiers 
%   Reaction_getListOfProducts                - Reaction_getListOfProducts 
%   Reaction_getListOfReactants               - Reaction_getListOfReactants 
%   Reaction_getModifier                      - Reaction_getModifier 
%   Reaction_getModifierById                  - Reaction_getModifierById 
%   Reaction_getName                          - Reaction_getName 
%   Reaction_getNumModifiers                  - Reaction_getNumModifiers 
%   Reaction_getNumProducts                   - Reaction_getNumProducts 
%   Reaction_getNumReactants                  - Reaction_getNumReactants 
%   Reaction_getProduct                       - Reaction_getProduct 
%   Reaction_getProductById                   - Reaction_getProductById 
%   Reaction_getReactant                      - Reaction_getReactant 
%   Reaction_getReactantById                  - Reaction_getReactantById 
%   Reaction_getReversible                    - Reaction_getReversible 
%   Reaction_getSBOTerm                       - Reaction_getSBOTerm 
%   Reaction_isSetFast                        - Reaction_isSetFast 
%   Reaction_isSetId                          - Reaction_isSetId 
%   Reaction_isSetKineticLaw                  - Reaction_isSetKineticLaw 
%   Reaction_isSetName                        - Reaction_isSetName 
%   Reaction_moveIdToName                     - Reaction_moveIdToName 
%   Reaction_moveNameToId                     - Reaction_moveNameToId 
%   Reaction_setFast                          - Reaction_setFast 
%   Reaction_setId                            - Reaction_setId 
%   Reaction_setKineticLaw                    - Reaction_setKineticLaw 
%   Reaction_setName                          - Reaction_setName 
%   Reaction_setReversible                    - Reaction_setReversible 
%   Reaction_setSBOTerm                       - Reaction_setSBOTerm 
%   Reaction_unsetFast                        - Reaction_setFast 
%   Reaction_unsetKineticLaw                  - Reaction_unsetKineticLaw 
%   Reaction_unsetName                        - Reaction_unsetName 
%
%   ADDITIONAL TO libSBML API
%
%   Reaction_getParameterNamesAndValues       - Reaction_getParameterNamesAndValues takes a SBMLReaction 
%   Reaction_getParameterUniqueNamesAndValues - Reaction_getParameterUniqueNamesAndValues takes a SBMLReaction 

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

