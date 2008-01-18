function reaction = Reaction_addProduct(SBMLReaction, SBMLProduct)
%
%   Reaction_addProduct 
%             takes  1) an SBMLReaction structure 
%             and    2) an SBMLProduct structure
%
%             and returns 
%               the reaction with the product added
%
%       reaction = Reaction_addProduct(SBMLReaction, SBMLProduct)

%  Filename    :   Reaction_addProduct.m
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
  error(sprintf('%s\n%s', ...
    'Reaction_addProduct(SBMLReaction, SBMLProduct)', ...
    'first argument must be an SBML Reaction structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLReaction);

if (~isSBML_Reaction(SBMLReaction, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Reaction_addProduct(SBMLReaction, SBMLProduct)', 'first argument must be an SBML reaction structure'));
elseif (~isSBML_SpeciesReference(SBMLProduct, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s\n of the same SBML level, namely level %u', 'Reaction_addProduct(SBMLReaction, SBMLProduct)', 'second argument must be an SBML product structure', sbmlLevel));
end;

numberProducts = length(SBMLReaction.product);

SBMLReaction.product(numberProducts+1) = SBMLProduct;

reaction = SBMLReaction;

