function SBMLModel = Model_addUnitDefinition(SBMLModel, SBMLUnitDefinition)
%
%   Model_addUnitDefinition 
%             takes  1) an SBMLModel structure 
%             and    2) an SBMLUnitDefinition structure
%
%             and returns 
%               the model with the unitDefinition added
%
%       SBMLModel = Model_addUnitDefinition(SBMLModel, SBMLUnitDefinition)

%  Filename    :   Model_addUnitDefinition.m
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



% get level and version
sbmlLevel = SBMLModel.SBML_level;
sbmlVersion = SBMLModel.SBML_version;

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', ...
    'Model_addUnitDefinition(SBMLModel, SBMLUnitDefinition)', ...
    'first argument must be an SBML model structure'));
elseif (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s\n%s%u%s%u\n', ...
    'Model_addUnitDefinition(SBMLModel, SBMLUnitDefinition)', ...
    'second argument must be an SBML UnitDefinition structure', ...
    'of the same SBML level and version, namely level ', sbmlLevel, ...
    ' version ', sbmlVersion));
end;

numberUnitDefinitions = length(SBMLModel.unitDefinition);

SBMLModel.unitDefinition(numberUnitDefinitions+1) = SBMLUnitDefinition;

