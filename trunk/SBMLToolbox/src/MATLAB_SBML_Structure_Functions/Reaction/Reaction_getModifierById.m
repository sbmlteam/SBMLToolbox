function modifier = Reaction_getModifierById(SBMLReaction, id)
%
%   Reaction_getModifierById 
%             takes  1) an SBMLReaction structure 
%             and    2) a string representing the id of the modifier to be found
%
%             and returns 
%               the modifier structure with the matching id 
%               or an empty structure if no such modifier exists
%               
%       modifier = Reaction_getModifierById(SBMLReaction, 'id')

%  Filename    :   Reaction_getModifierById.m
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
if (~isstruct(SBMLReaction))
  error(sprintf('%s', ...
    'first argument must be an SBML Reaction structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLReaction);

if (~isSBML_Reaction(SBMLReaction, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Reaction_getModifierById(SBMLReaction, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Reaction_getModifierById(SBMLReaction, id)', 'second argument must be a string'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_getModifierById(SBMLReaction, id)', 'no id or modifier field in a level 1 model'));   
end;

modifier = [];

for i = 1:length(SBMLReaction.modifier)
    if (strcmp(id, SBMLReaction.modifier(i).species))
        modifier = SBMLReaction.modifier(i);
        return;
    end;
end;
