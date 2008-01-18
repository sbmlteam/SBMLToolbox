function [kineticLawParameter, SBMLModel] = Model_createKineticLawParameter(SBMLModel)
%
%   Model_createKineticLawParameter 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the kineticLawParameter structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created kineticLawParameter
%
%       NOTE: the kineticLawParameter is added to the last reaction created
%
%       [kineticLawParameter, SBMLModel] = Model_createKineticLawParameter(SBMLModel)

%  Filename    :   Model_createKineticLawParameter.m
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



% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createKineticLawParameter(SBMLModel)', 'first argument must be an SBML model structure'));
end;

kineticLawParameter = Parameter_create(SBMLModel.SBML_level, SBMLModel.SBML_version);

if (length(SBMLModel.reaction) == 0)
    kineticLawParameter = [];
    warning('Failed to create kineticLawParameter');
elseif (isempty(Reaction_getKineticLaw(SBMLModel.reaction(end))))
    kineticLawParameter = [];
    warning('No KineticLaw created for this reaction');  
else
    SBMLModel.reaction(end).kineticLaw = KineticLaw_addParameter(SBMLModel.reaction(end).kineticLaw, kineticLawParameter);
end;

