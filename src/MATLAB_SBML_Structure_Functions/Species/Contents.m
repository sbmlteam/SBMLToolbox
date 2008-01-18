% toolbox\MATLAB_SBML_Structure_Functions\SPECIES
%
% Files
%   Species_create                    - Species_create 
%   Species_getBoundaryCondition      - Species_getBoundaryCondition 
%   Species_getCharge                 - Species_getCharge 
%   Species_getCompartment            - Species_getCompartment 
%   Species_getConstant               - Species_getConstant 
%   Species_getHasOnlySubstanceUnits  - Species_getHasOnlySubstanceUnits 
%   Species_getId                     - Species_getId 
%   Species_getInitialAmount          - Species_getInitialAmount 
%   Species_getInitialConcentration   - Species_getInitialConcentration 
%   Species_getName                   - Species_getName 
%   Species_getSBOTerm                - Species_getSBOTerm 
%   Species_getSpatialSizeUnits       - Species_getSpatialSizeUnits 
%   Species_getSpeciesType            - Species_getSpeciesType 
%   Species_getSubstanceUnits         - Species_getSubstanceUnits 
%   Species_getUnits                  - Species_getUnits 
%   Species_isSetCharge               - Species_isSetCharge 
%   Species_isSetCompartment          - Species_isSetCompartment 
%   Species_isSetId                   - Species_isSetId 
%   Species_isSetInitialAmount        - Species_isSetInitialAmount 
%   Species_isSetInitialConcentration - Species_isSetInitialConcentration 
%   Species_isSetName                 - Species_isSetName 
%   Species_isSetSpatialSizeUnits     - Species_isSetSpatialSizeUnits 
%   Species_isSetSubstanceUnits       - Species_isSetSubstanceUnits 
%   Species_isSetUnits                - Species_isSetUnits 
%   Species_moveIdToName              - Species_moveIdToName 
%   Species_moveNameToId              - Species_moveNameToId 
%   Species_setBoundaryCondition      - Species_setBoundaryCondition 
%   Species_setCharge                 - Species_setCharge 
%   Species_setCompartment            - Species_setCompartment 
%   Species_setConstant               - Species_setConstant 
%   Species_setHasOnlySubstanceUnits  - Species_setHasOnlySubstanceUnits 
%   Species_setId                     - Species_setId 
%   Species_setInitialAmount          - Species_setInitialAmount 
%   Species_setInitialConcentration   - Species_setInitialConcentration 
%   Species_setName                   - Species_setName 
%   Species_setSBOTerm                - Species_setSBOTerm 
%   Species_setSpatialSizeUnits       - Species_setSpatialSizeUnits 
%   Species_setSpeciesType            - Species_setSpeciesType 
%   Species_setSubstanceUnits         - Species_setSubstanceUnits 
%   Species_setUnits                  - Species_setUnits 
%   Species_unsetCharge               - Species_unsetCharge 
%   Species_unsetInitialAmount        - Species_unsetInitialAmount 
%   Species_unsetInitialConcentration - Species_unsetInitialConcentration 
%   Species_unsetName                 - Species_unsetName 
%   Species_unsetSpatialSizeUnits     - Species_unsetSpatialSizeUnits 
%   Species_unsetSubstanceUnits       - Species_unsetSubstanceUnits 
%   Species_unsetUnits                - Species_unsetUnits 
%
%   ADDITIONAL TO libSBML API
%
%   Species_determineRoleInReaction   - Species_determineRoleInReaction
%   Species_isAssignedByRule          - Species_isAssignedByRule 

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

