% toolbox\MATLAB_SBML_Structure_Functions\SpeciesReference
%
% The functions allow users to create and work with the SBML SpeciesReference structure. 
%
%===============================================================================
% SpeciesReference = SpeciesReference_create(level(optional), version(optional)
%===============================================================================
% takes
% 1. level; an integer representing an SBML level (optional)
% 2. version; an integer representing an SBML version (optional)
% returns
% 1. a MATLAB_SBML SpeciesReference structure of the appropriate level and version
%
%===============================================================
% constant = SpeciesReference_getConstant(SBMLSpeciesReference)
%===============================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the value of the constant attribute
%
%=====================================================================
% denominator = SpeciesReference_getDenominator(SBMLSpeciesReference)
%=====================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the value of the denominator attribute
%
%===================================================
% id = SpeciesReference_getId(SBMLSpeciesReference)
%===================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the value of the id attribute
%
%===========================================================
% metaid = SpeciesReference_getMetaid(SBMLSpeciesReference)
%===========================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the value of the metaid attribute
%
%=======================================================
% name = SpeciesReference_getName(SBMLSpeciesReference)
%=======================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the value of the name attribute
%
%=============================================================
% sboTerm = SpeciesReference_getSBOTerm(SBMLSpeciesReference)
%=============================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the value of the sboTerm attribute
%
%=============================================================
% species = SpeciesReference_getSpecies(SBMLSpeciesReference)
%=============================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the value of the species attribute
%
%=========================================================================
% stoichiometry = SpeciesReference_getStoichiometry(SBMLSpeciesReference)
%=========================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the value of the stoichiometry attribute
%
%=================================================================================
% stoichiometryMath = SpeciesReference_getStoichiometryMath(SBMLSpeciesReference)
%=================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the SBML StoichiometryMath structure
%
%============================================================================
% y = SpeciesReference_isAssignedByRateRule(SBMLSpeciesReference, SBMLRules)
%============================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. SBMLRules; the array of rules from an SBML Model structure
% returns
% y = 
%   - the index of the rateRule used to assigned value to the SpeciesReference
%   - 0 if the SpeciesReference is not assigned by rateRule 
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->
%
%========================================================================
% y = SpeciesReference_isAssignedByRule(SBMLSpeciesReference, SBMLRules)
%========================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. SBMLRules; the array of rules from an SBML Model structure
% returns
% y = 
%   - the index of the assignmentRule used to assigned value to the SpeciesReference
%   - 0 if the SpeciesReference is not assigned by assignmentRule 
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->
%
%=========================================================================
% y = SpeciesReference_isInAlgebraicRule(SBMLSpeciesReference, SBMLRules)
%=========================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. SBMLRules; the array of rules from an SBML Model structure
% returns
% y = 
%   - an array of the indices of any algebraicRules the id of the SpeciesReference appears in 
%   - 0 if the SpeciesReference appears in no algebraicRules 
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->
%
%=================================================================
% value = SpeciesReference_isSetDenominator(SBMLSpeciesReference)
%=================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. value = 
%  - 1 if the denominator attribute is set
%  - 0 otherwise
%
%========================================================
% value = SpeciesReference_isSetId(SBMLSpeciesReference)
%========================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. value = 
%  - 1 if the id attribute is set
%  - 0 otherwise
%
%============================================================
% value = SpeciesReference_isSetMetaid(SBMLSpeciesReference)
%============================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. value = 
%  - 1 if the metaid attribute is set
%  - 0 otherwise
%
%==========================================================
% value = SpeciesReference_isSetName(SBMLSpeciesReference)
%==========================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. value = 
%  - 1 if the name attribute is set
%  - 0 otherwise
%
%=============================================================
% value = SpeciesReference_isSetSBOTerm(SBMLSpeciesReference)
%=============================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. value = 
%  - 1 if the sboTerm attribute is set
%  - 0 otherwise
%
%=============================================================
% value = SpeciesReference_isSetSpecies(SBMLSpeciesReference)
%=============================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. value = 
%  - 1 if the species attribute is set
%  - 0 otherwise
%
%===================================================================
% value = SpeciesReference_isSetStoichiometry(SBMLSpeciesReference)
%===================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. value = 
%  - 1 if the stoichiometry attribute is set
%  - 0 otherwise
%
%=======================================================================
% value = SpeciesReference_isSetStoichiometryMath(SBMLSpeciesReference)
%=======================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. value = 
%  - 1 if the stoichiometryMath structure is set
%  - 0 otherwise
%
%=====================================================================================
% SBMLSpeciesReference = SpeciesReference_setConstant(SBMLSpeciesReference, constant)
%=====================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. constant; an integer (0/1) representing the value of constant to be set
% returns
% 1. the SBML SpeciesReference structure with the new value for the constant attribute
%
%===========================================================================================
% SBMLSpeciesReference = SpeciesReference_setDenominator(SBMLSpeciesReference, denominator)
%===========================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. denominator; an integer representing the denominator to be set
% returns
% 1. the SBML SpeciesReference structure with the new value for the denominator attribute
%
%=========================================================================
% SBMLSpeciesReference = SpeciesReference_setId(SBMLSpeciesReference, id)
%=========================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. id; a string representing the id to be set
% returns
% 1. the SBML SpeciesReference structure with the new value for the id attribute
%
%=================================================================================
% SBMLSpeciesReference = SpeciesReference_setMetaid(SBMLSpeciesReference, metaid)
%=================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. metaid; a string representing the metaid to be set
% returns
% 1. the SBML SpeciesReference structure with the new value for the metaid attribute
%
%=============================================================================
% SBMLSpeciesReference = SpeciesReference_setName(SBMLSpeciesReference, name)
%=============================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. name; a string representing the name to be set
% returns
% 1. the SBML SpeciesReference structure with the new value for the name attribute
%
%===================================================================================
% SBMLSpeciesReference = SpeciesReference_setSBOTerm(SBMLSpeciesReference, sboTerm)
%===================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. sboTerm; an integer representing the sboTerm to be set
% returns
% 1. the SBML SpeciesReference structure with the new value for the sboTerm attribute
%
%===================================================================================
% SBMLSpeciesReference = SpeciesReference_setSpecies(SBMLSpeciesReference, species)
%===================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. species; a string representing the species to be set
% returns
% 1. the SBML SpeciesReference structure with the new value for the species attribute
%
%===============================================================================================
% SBMLSpeciesReference = SpeciesReference_setStoichiometry(SBMLSpeciesReference, stoichiometry)
%===============================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. stoichiometry; number representing the value of stoichiometry to be set
% returns
% 1. the SBML SpeciesReference structure with the new value for the stoichiometry attribute
%
%===========================================================================================================
% SBMLSpeciesReference = SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, SBMLStoichiometryMath)
%===========================================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% 2. SBMLStoichiometryMath; an SBML StoichiometryMath structure
% returns
% 1. the SBML SpeciesReference structure with the new value for the stoichiometryMath field
%
%================================================================================
% SBMLSpeciesReference = SpeciesReference_unsetDenominator(SBMLSpeciesReference)
%================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the SBML SpeciesReference structure with the denominator attribute unset
%
%=======================================================================
% SBMLSpeciesReference = SpeciesReference_unsetId(SBMLSpeciesReference)
%=======================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the SBML SpeciesReference structure with the id attribute unset
%
%===========================================================================
% SBMLSpeciesReference = SpeciesReference_unsetMetaid(SBMLSpeciesReference)
%===========================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the SBML SpeciesReference structure with the metaid attribute unset
%
%=========================================================================
% SBMLSpeciesReference = SpeciesReference_unsetName(SBMLSpeciesReference)
%=========================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the SBML SpeciesReference structure with the name attribute unset
%
%============================================================================
% SBMLSpeciesReference = SpeciesReference_unsetSBOTerm(SBMLSpeciesReference)
%============================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the SBML SpeciesReference structure with the sboTerm attribute unset
%
%============================================================================
% SBMLSpeciesReference = SpeciesReference_unsetSpecies(SBMLSpeciesReference)
%============================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the SBML SpeciesReference structure with the species attribute unset
%
%==================================================================================
% SBMLSpeciesReference = SpeciesReference_unsetStoichiometry(SBMLSpeciesReference)
%==================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the SBML SpeciesReference structure with the stoichiometry attribute unset
%
%======================================================================================
% SBMLSpeciesReference = SpeciesReference_unsetStoichiometryMath(SBMLSpeciesReference)
%======================================================================================
% takes
% 1. SBMLSpeciesReference; an SBML SpeciesReference structure
% returns
% 1. the SBML SpeciesReference structure with the stoichiometryMath field unset
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


