function number = Reaction_getNumModifiers(SBMLReaction)
%
%   Reaction_getNumModifiers 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the number of modifier structures defined within the reaction
%
%       number = Reaction_getNumModifiers(SBMLReaction)

%  Filename    :   Reaction_getNumModifiers.m
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
    error(sprintf('%s\n%s', 'Reaction_getNumModifiers(SBMLReaction)', 'argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_getNumModifiers(SBMLReaction)', 'no modifiers in level 1 model'));
end;

number = 0;

if (~isempty(SBMLReaction.modifier))
    number = length(SBMLReaction.modifier);
end;
