function [reaction, SBMLModel] = Model_createReaction(SBMLModel)
%
%   Model_createReaction 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the reaction structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created reaction
%
%       [reaction, SBMLModel] = Model_createReaction(SBMLModel)

%  Filename    :   Model_createReaction.m
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
    error(sprintf('%s\n%s', 'Model_createReaction(SBMLModel)', 'first argument must be an SBML model structure'));
end;

reaction = Reaction_create(SBMLModel.SBML_level, SBMLModel.SBML_version);

SBMLModel = Model_addReaction(SBMLModel, reaction);
