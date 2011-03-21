function reaction = Reaction_addModifier(SBMLReaction, SBMLModifier)
%
%   Reaction_addModifier 
%             takes  1) an SBMLReaction structure 
%             and    2) an SBMLModifier structure
%
%             and returns 
%               the reaction with the modifier added
%
%       reaction = Reaction_addModifier(SBMLReaction, SBMLModifier)

%  Filename    :   Reaction_addModifier.m
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
if (~isstruct(SBMLReaction))
  error(sprintf('%s\n%s', ...
    'Reaction_addModifier(SBMLReaction, SBMLModifier)', ...
    'first argument must be an SBML Reaction structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLReaction);

if (~isSBML_Reaction(SBMLReaction, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Reaction_addModifier(SBMLReaction, SBMLModifier)', 'first argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_addModifier(SBMLReaction, SBMLModifier)', 'no modifiers in level 1 model'));
elseif (~isSBML_ModifierSpeciesReference(SBMLModifier, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s\n of the same SBML level, namely level %u', 'Reaction_addModifier(SBMLReaction, SBMLModifier)', 'second argument must be an SBML modifier structure', sbmlLevel));
end;

numberModifiers = length(SBMLReaction.modifier);

SBMLReaction.modifier(numberModifiers+1) = SBMLModifier;

reaction = SBMLReaction;

