function number = Reaction_getNumReactants(SBMLReaction)
%
%   Reaction_getNumReactants 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the number of reactant structures defined within the reaction
%
%       number = Reaction_getNumReactants(SBMLReaction)

%  Filename    :   Reaction_getNumReactants.m
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
    error(sprintf('%s\n%s', 'Reaction_getNumReactants(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

number = 0;

if (~isempty(SBMLReaction.reactant))
    number = length(SBMLReaction.reactant);
end;
