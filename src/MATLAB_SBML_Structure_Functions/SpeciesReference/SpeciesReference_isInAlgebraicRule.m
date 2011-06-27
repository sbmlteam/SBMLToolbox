function y = SpeciesReference_isInAlgebraicRule(SBMLSpeciesReference, SBMLRules)
% SpeciesReference_isInAlgebraicRule takes an SBMLSpeciesReference structure and an array of SBMLRule structures
% and returns
%             0 if the species is not in an algebraic rule
%             [n1, n2] if the species occurs as within a rule
%     where n1, n2 refers to the index of the matched rule in the array

%  Filename    :   SpeciesReference_isInAlgebraicRule.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: SpeciesReference_isInAlgebraicRule.m 13259 2011-03-21 05:40:36Z mhucka $
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

 
y = 0;

%-------------------------------------------------------------------
% check input arguments are as expected

if (~isstruct(SBMLSpeciesReference))
    error(sprintf('%s', ...
      'argument must be an SBML SpeciesReference structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLSpeciesReference);

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel, sbmlVersion))
  error('SpeciesReference_isInAlgebraicRule(SBMLSpeciesReference, SBMLRules)\n%s', ...
    'first argument must be an SBMLSpeciesReference structure');
elseif (~isfield(SBMLSpeciesReference, 'id'))
  error('SpeciesReference cannot be used by rules in SBML level %u version %u', ...
    sbmlLevel, sbmlVersion);
end;



NumRules = length(SBMLRules);

if (NumRules < 1)
    error('SpeciesReference_isInAlgebraicRule(SBMLSpeciesReference, SBMLRules)\n%s', ...
      'SBMLRule structure is empty');
else
    for i = 1:NumRules
        if (~isSBML_Rule(SBMLRules(i), sbmlLevel, sbmlVersion))
            error('SpeciesReference_isInAlgebraicRule(SBMLSpeciesReference, SBMLRules)\n%s', ...
              'second argument must be an array of SBMLRule structures');
        end;
    end;
end;

%--------------------------------------------------------------------------

% loop through each rule and check whether the species occurs
%determine the name or id of the species
name = SBMLSpeciesReference.id;

y = [];
for i = 1:NumRules
    index = matchName(SBMLRules(i).formula, name);
    if (~isempty(index) && strcmp(SBMLRules(i).typecode, 'SBML_ALGEBRAIC_RULE'))
        y = [y;i];
    end;
end;

if isempty(y)
  y = 0;
end;

