function SBMLReaction = Reaction_setKineticLaw(SBMLReaction, SBMLKineticLaw)
%
%   Reaction_setKineticLaw 
%             takes  1) an SBMLReaction structure 
%             and    2) an SBMLKineticLaw structure representing the kineticLaw to be set
%
%             and returns 
%               the reaction with the kineticLaw set
%
%       SBMLReaction = Reaction_setKineticLaw(SBMLReaction, SBMLKineticLaw)

%  Filename    :   Reaction_setKineticLaw.m
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
    error(sprintf('%s\n%s', 'Reaction_setKineticLaw(SBMLReaction, kineticLaw)', 'first argument must be an SBML reaction structure'));
elseif (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel, sbmlVersion))
    error(sprintf('Reaction_setKineticLaw(SBMLReaction, kineticLaw)\n%s\nof the same level, namely level %u', 'second argument must be an SBML KineticLaw structure', sbmlLevel));
end;

SBMLReaction.kineticLaw = SBMLKineticLaw;
