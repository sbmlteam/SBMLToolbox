function [modifier, SBMLModel] = Model_createModifier(SBMLModel)
%
%   Model_createModifier 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the modifier structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created modifier
%
%       NOTE: the modifier is added to the last reaction created
%
%       [modifier, SBMLModel] = Model_createModifier(SBMLModel)

%  Filename    :   Model_createModifier.m
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



% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createModifier(SBMLModel)', 'first argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_createModifier(SBMLModel)', 'no modifiers in a level 1 model'));
end;

modifier = ModifierSpeciesReference_create(SBMLModel.SBML_level, SBMLModel.SBML_version);

if (length(SBMLModel.reaction) == 0)
    modifier = [];
    warning('Failed to create modifier');
else
    SBMLModel.reaction(end) = Reaction_addModifier(SBMLModel.reaction(end), modifier);
end;

