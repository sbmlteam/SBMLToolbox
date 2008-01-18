function SBMLModel = Model_addSpeciesType(SBMLModel, SBMLSpeciesType)
%
%   Model_addSpeciesType 
%             takes  1) an SBMLModel structure 
%             and    2) an SBMLSpeciesType structure
%
%             and returns 
%               the model with the species added
%
%       SBMLModel = Model_addSpeciesType(SBMLModel, SBMLSpeciesType)

%  Filename    :   Model_addSpeciesType.m
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



% get level and version
sbmlLevel = SBMLModel.SBML_level;
sbmlVersion = SBMLModel.SBML_version;

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', ...
    'Model_addSpeciesType(SBMLModel, SBMLSpeciesType)', ...
    'first argument must be an SBML model structure'));
elseif (~isSBML_SpeciesType(SBMLSpeciesType, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s\n%s%u%s%u\n', ...
    'Model_addSpeciesType(SBMLModel, SBMLSpeciesType)', ...
    'second argument must be an SBML speciesType structure', ...
    'of the same SBML level and version, namely level ', sbmlLevel, ...
    ' version ', sbmlVersion));
end;

numberSpeciesTypes = length(SBMLModel.speciesType);

SBMLModel.speciesType(numberSpeciesTypes+1) = SBMLSpeciesType;

