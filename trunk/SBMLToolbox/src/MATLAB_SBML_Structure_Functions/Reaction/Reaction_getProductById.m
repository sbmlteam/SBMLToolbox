function product = Reaction_getProductById(SBMLReaction, id)
%
%   Reaction_getProductById 
%             takes  1) an SBMLReaction structure 
%             and    2) a string representing the id of the product to be found
%
%             and returns 
%               the product structure with the matching id 
%               or an empty structure if no such product exists
%               
%       product = Reaction_getProductById(SBMLReaction, 'id')

%  Filename    :   Reaction_getProductById.m
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
  error(sprintf('%s', ...
    'first argument must be an SBML Reaction structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLReaction);

if (~isSBML_Reaction(SBMLReaction, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Reaction_getProductById(SBMLReaction, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Reaction_getProductById(SBMLReaction, id)', 'second argument must be a string'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_getProductById(SBMLReaction, id)', 'no id field in a level 1 model'));   
end;

product = [];

for i = 1:length(SBMLReaction.product)
    if (strcmp(id, SBMLReaction.product(i).species))
        product = SBMLReaction.product(i);
        return;
    end;
end;
